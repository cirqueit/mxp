###########################################################################
#
# Copyright (C) 2013-2015 VectorBlox Computing, Inc.
#
###########################################################################

###########################################################################
proc iplevel_update_c_m_axi_data_width {param_handle} {

    set mhsinst [xget_hw_parent_handle $param_handle]
    set memory_width_lanes [xget_hw_parameter_value $mhsinst MEMORY_WIDTH_LANES]
    set c_m_axi_data_width [expr $memory_width_lanes * 32]

    # puts "c_m_axi_data_width = $c_m_axi_data_width"

    return $c_m_axi_data_width
}

###########################################################################
proc iplevel_update_c_m_axi_len_width {param_handle} {

    set mhsinst [xget_hw_parent_handle $param_handle]
    set c_m_axi_protocol [xget_hw_parameter_value $mhsinst C_M_AXI_PROTOCOL]

    # puts "c_m_axi_protocol = $c_m_axi_protocol"

    if {$c_m_axi_protocol == "AXI3"} {
        return 4
    } else {
        return 8
    }
}

###########################################################################
# set burstlength_bytes to beats_per_burst*(memory_width_lanes*4)
# Note: max AXI4 beats per burst is 256 and an AXI burst cannot cross a
# 4KB boundary, so burstlength_bytes must be
# <= min(4096, 256*memory_width_lanes*4).
proc iplevel_update_burstlength_bytes {param_handle} {

    set mhsinst [xget_hw_parent_handle $param_handle]
    set beats_per_burst [xget_hw_parameter_value $mhsinst BEATS_PER_BURST]
    set memory_width_lanes [xget_hw_parameter_value $mhsinst MEMORY_WIDTH_LANES]
    set burstlength_bytes [expr $beats_per_burst * $memory_width_lanes * 32 / 8]

    # puts "burstlength_bytes = $burstlength_bytes"

    return $burstlength_bytes
}

###########################################################################
proc iplevel_update_mulfxp_word_format {param_handle} {

    set mhsinst [xget_hw_parent_handle $param_handle]
    set word_qn [xget_hw_parameter_value $mhsinst MULFXP_WORD_FRACTION_BITS]
    if {($word_qn > 0 ) && ($word_qn < 32)} {
        set s [format "Q%d.%d" [expr 32-$word_qn] $word_qn]
    } else {
        set s "Q?.?"
    }

    # puts "mulfxp_word_format = $s"

    return $s
}

###########################################################################
proc iplevel_update_mulfxp_half_format {param_handle} {

    set mhsinst [xget_hw_parent_handle $param_handle]
    set half_qn [xget_hw_parameter_value $mhsinst MULFXP_HALF_FRACTION_BITS]
    if {($half_qn > 0 ) && ($half_qn < 16)} {
        set s [format "Q%d.%d" [expr 16-$half_qn] $half_qn]
    } else {
        set s "Q?.?"
    }

    # puts "mulfxp_half_format = $s"

    return $s
}

###########################################################################
proc iplevel_update_mulfxp_byte_format {param_handle} {

    set mhsinst [xget_hw_parent_handle $param_handle]
    set byte_qn [xget_hw_parameter_value $mhsinst MULFXP_BYTE_FRACTION_BITS]
    if {($byte_qn > 0 ) && ($byte_qn < 8)} {
        set s [format "Q%d.%d" [expr 8-$byte_qn] $byte_qn]
    } else {
        set s "Q?.?"
    }

    # puts "mulfxp_byte_format = $s"

    return $s
}

###########################################################################
# Called from iplevel_drc because the iplevel_update_value_proc procedures
# for derived parameters aren't automatically called from the XPS Core Config
# dialog box, but iplevel_drc is.
proc update_derived_params {mhsinst} {
    set param_handle [xget_hw_parameter_handle $mhsinst C_M_AXI_DATA_WIDTH]
    set param_val [iplevel_update_c_m_axi_data_width $param_handle]
    xset_hw_parameter_value $param_handle $param_val

    set param_handle [xget_hw_parameter_handle $mhsinst C_M_AXI_LEN_WIDTH]
    set param_val [iplevel_update_c_m_axi_len_width $param_handle]
    xset_hw_parameter_value $param_handle $param_val

    set param_handle [xget_hw_parameter_handle $mhsinst BURSTLENGTH_BYTES]
    set param_val [iplevel_update_burstlength_bytes $param_handle]
    xset_hw_parameter_value $param_handle $param_val

    set param_handle [xget_hw_parameter_handle $mhsinst MULFXP_WORD_FORMAT]
    set param_val [iplevel_update_mulfxp_word_format $param_handle]
    xset_hw_parameter_value $param_handle $param_val

    set param_handle [xget_hw_parameter_handle $mhsinst MULFXP_HALF_FORMAT]
    set param_val [iplevel_update_mulfxp_half_format $param_handle]
    xset_hw_parameter_value $param_handle $param_val

    set param_handle [xget_hw_parameter_handle $mhsinst MULFXP_BYTE_FORMAT]
    set param_val [iplevel_update_mulfxp_byte_format $param_handle]
    xset_hw_parameter_value $param_handle $param_val

    if {0} {
        # Would like to change the BASEADDR parameter's MIN_SIZE keyword value
        # based on the desired scratchpad size, but there doesn't seem to be a
        # way to do this. Can get the value of the MIN_SIZE subproperty, but
        # can't change it.
        set scratchpad_kb [xget_hw_parameter_value $mhsinst SCRATCHPAD_KB]
        set addr_handle [xget_hw_parameter_handle $mhsinst C_S_AXI_BASEADDR]
        set min_size [xget_hw_subproperty_value $addr_handle "MIN_SIZE"]
    }

}


###########################################################################
# Return 1 if n is a power of 2, else 0.
proc is_pow2 {n} {
    if {$n <= 0} {
        return 0
    }
    set p 1
    while {$p < $n} {
        set p [expr 2*$p]
    }
    if {$p == $n} {
        return 1
    } else {
        return 0
    }
}

###########################################################################
# Checks:
# - memory_width_lanes is a power of 2 (range in MPD enforces this)
# - memory_width_lanes <= vector_lanes
# - burstlength_bytes <= min(4096, beats_per_burst*memory_width_lanes*4).
# - AXI slave address range fits the scratchpad RAM.
proc iplevel_drc {mhsinst} {

    # puts "vectorblox_mxp::iplevel_drc"

    # First recalculate all derived parameters.
    update_derived_params $mhsinst

    ###########################################################################
    # Check that memory_width_lanes <= vector_lanes.
    set vector_lanes [xget_hw_parameter_value $mhsinst VECTOR_LANES]
    set memory_width_lanes [xget_hw_parameter_value $mhsinst MEMORY_WIDTH_LANES]

    if {($memory_width_lanes > $vector_lanes)} {
        error [concat \
            "The number of memory lanes ($memory_width_lanes) " \
            "cannot be larger than the number of vector lanes ($vector_lanes)." \
            "Please reduce the number of memory lanes or increase " \
            "the number of vector lanes."]
    }

    ######################################################################
    set vector_custom_instructions [xget_hw_parameter_value $mhsinst VECTOR_CUSTOM_INSTRUCTIONS]

    set vci_0_lanes [xget_hw_parameter_value $mhsinst VCI_0_LANES]
    if {($vci_0_lanes > $vector_lanes) && ($vector_custom_instructions > 0)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 0) or increase the number of vector lanes."]
    }
    set vci_1_lanes [xget_hw_parameter_value $mhsinst VCI_1_LANES]
    if {($vci_1_lanes > $vector_lanes) && ($vector_custom_instructions > 1)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 1) or increase the number of vector lanes."]
    }
    set vci_2_lanes [xget_hw_parameter_value $mhsinst VCI_2_LANES]
    if {($vci_2_lanes > $vector_lanes) && ($vector_custom_instructions > 2)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 2) or increase the number of vector lanes."]
    }
    set vci_3_lanes [xget_hw_parameter_value $mhsinst VCI_3_LANES]
    if {($vci_3_lanes > $vector_lanes) && ($vector_custom_instructions > 3)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 3) or increase the number of vector lanes."]
    }
    set vci_4_lanes [xget_hw_parameter_value $mhsinst VCI_4_LANES]
    if {($vci_4_lanes > $vector_lanes) && ($vector_custom_instructions > 4)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 4) or increase the number of vector lanes."]
    }
    set vci_5_lanes [xget_hw_parameter_value $mhsinst VCI_5_LANES]
    if {($vci_5_lanes > $vector_lanes) && ($vector_custom_instructions > 5)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 5) or increase the number of vector lanes."]
    }
    set vci_6_lanes [xget_hw_parameter_value $mhsinst VCI_6_LANES]
    if {($vci_6_lanes > $vector_lanes) && ($vector_custom_instructions > 6)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 6) or increase the number of vector lanes."]
    }
    set vci_7_lanes [xget_hw_parameter_value $mhsinst VCI_7_LANES]
    if {($vci_7_lanes > $vector_lanes) && ($vector_custom_instructions > 7)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 7) or increase the number of vector lanes."]
    }
    set vci_8_lanes [xget_hw_parameter_value $mhsinst VCI_8_LANES]
    if {($vci_8_lanes > $vector_lanes) && ($vector_custom_instructions > 8)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 8) or increase the number of vector lanes."]
    }
    set vci_9_lanes [xget_hw_parameter_value $mhsinst VCI_9_LANES]
    if {($vci_9_lanes > $vector_lanes) && ($vector_custom_instructions > 9)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 9) or increase the number of vector lanes."]
    }
    set vci_10_lanes [xget_hw_parameter_value $mhsinst VCI_10_LANES]
    if {($vci_10_lanes > $vector_lanes) && ($vector_custom_instructions > 10)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 10) or increase the number of vector lanes."]
    }
    set vci_11_lanes [xget_hw_parameter_value $mhsinst VCI_11_LANES]
    if {($vci_11_lanes > $vector_lanes) && ($vector_custom_instructions > 11)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 11) or increase the number of vector lanes."]
    }
    set vci_12_lanes [xget_hw_parameter_value $mhsinst VCI_12_LANES]
    if {($vci_12_lanes > $vector_lanes) && ($vector_custom_instructions > 12)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 12) or increase the number of vector lanes."]
    }
    set vci_13_lanes [xget_hw_parameter_value $mhsinst VCI_13_LANES]
    if {($vci_13_lanes > $vector_lanes) && ($vector_custom_instructions > 13)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 13) or increase the number of vector lanes."]
    }
    set vci_14_lanes [xget_hw_parameter_value $mhsinst VCI_14_LANES]
    if {($vci_14_lanes > $vector_lanes) && ($vector_custom_instructions > 14)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 14) or increase the number of vector lanes."]
    }
    set vci_15_lanes [xget_hw_parameter_value $mhsinst VCI_15_LANES]
    if {($vci_15_lanes > $vector_lanes) && ($vector_custom_instructions > 15)} {
        error [concat \
            "The number of custom instruction lanes cannot be larger than " \
            "the number of vector lanes. Please reduce the number of custom " \
            "instruction lanes (VCI Port 15) or increase the number of vector lanes."]
    }

    ##FIXME: Validate Opcodes##


    ######################################################################
    # AXI master data bus width should be legal by construction,
    # but do a sanity check.
    set bus_width [expr $memory_width_lanes*32]
    set allowed_values [list 32 64 128 256 512 1024]
    if {[lsearch $allowed_values $bus_width] == -1} {
        error [concat \
            "Memory bus width of $bus_width bits is not allowed. " \
            "Must be one of $allowed_values."]
    }

    ######################################################################
    # Beats per burst should be legal by construction, but check.
    set beats_per_burst [xget_hw_parameter_value $mhsinst BEATS_PER_BURST]
    set allowed_values [list 1 2 4 8 16 32 64 128 256]
    if {[lsearch $allowed_values $beats_per_burst] == -1} {
        error [concat \
            "Burst size of $beat_per_burst beats is not allowed. " \
            "Must be one of $allowed_values."]
    }

    # Don't know how to restrict beats_per_burst range when protocol is set
    # to AXI3, so check here.
    set c_m_axi_protocol [xget_hw_parameter_value $mhsinst C_M_AXI_PROTOCOL]
    if {$c_m_axi_protocol == "AXI3"} {
        if {$beats_per_burst > 16} {
            error [concat \
                "Burst size cannot be larger than 16 beats when DMA master " \
                "protocol is set to AXI3."]
        }
    }

    ######################################################################
    # A burst must not cross a 4KB boundary. This limits the maximum
    # number of beats per burst for large data bus widths.
    # burstlength_bytes <= min(4096, beats_per_burst*memory_width_lanes*4).
    set burstlength_bytes [xget_hw_parameter_value $mhsinst BURSTLENGTH_BYTES]
    set max_beats [expr 4096 / (4*$memory_width_lanes)]
    if {$burstlength_bytes > 4096} {
        error [concat \
                   "The selected number of beats per burst ($beats_per_burst) " \
                   "is too large for the selected number of memory lanes " \
                   "($memory_width_lanes). " \
                   "An AXI burst cannot be larger than 4 KB, so a burst " \
                   "cannot be longer than $max_beats beats when there are " \
                   "$memory_width_lanes memory lanes. " \
                   "Please reduce the maximum number of beats per burst or " \
                   "reduce the number of memory lanes."]
    }

    ######################################################################
    set scratchpad_kb [xget_hw_parameter_value $mhsinst SCRATCHPAD_KB]
    set scratchpad_size [expr $scratchpad_kb*1024]
    set max_axi_addr_w 32
    # Exponentiation operator ** only works in Tcl 8.5 and later...
    set max_scratchpad_size [expr pow(2, $max_axi_addr_w)]
    if {$scratchpad_size > $max_scratchpad_size} {
        error [concat "Scratchpad is larger than " \
                   "the 32-bit AXI slave address space!"]
    } else {
        if {0} {
            if {![is_pow2 $scratchpad_kb]} {
                puts [concat "Warning: Scratchpad size is not a power " \
                      "of 2. The scratchpad may not map efficiently to BRAMs."]
            }
        }
    }

    ###########################################################################
    # Check AXI slave address range is large enough for scratchpad.
    # HIGHADDR-BASEADDR+1 >= SCRATCHPAD_KB*1024
    set base_addr [xget_hw_parameter_value $mhsinst C_S_AXI_BASEADDR]
    set high_addr [xget_hw_parameter_value $mhsinst C_S_AXI_HIGHADDR]

    set addr_window_size [expr $high_addr - $base_addr + 1]

    set addr_handle [xget_hw_parameter_handle $mhsinst C_S_AXI_BASEADDR]
    set min_size [xget_hw_subproperty_value $addr_handle MIN_SIZE]

    # puts "base_addr = $base_addr"
    # puts "high_addr = $high_addr"
    # puts "min_size = $min_size"

    # Check that base address is aligned to scratchpad size.
    # Scratchpad size is assumed to be a power of 2.
    #
    # Note: EDK 14.4 already performs this check: e.g.
    #
    # EDK:4055 - INST:mxp_0 BASEADDR-HIGHADDR:0x70eff000-0x70f02fff -
    #   For the memory size of 0x4000, the least significant 14-bits of
    #   BASEADDR must be '0'. BASEADDR must align on a 2^N boundary!
    #
    if {$base_addr & ($scratchpad_size-1)} {
        error [concat "AXI slave base address is not aligned to a " \
                   "scratchpad-sized ($scratchpad_kb KB) boundary. " \
                   "Please adjust the base address."]
    }

    if {$addr_window_size < $scratchpad_size} {
        error [concat "AXI slave address range $base_addr-$high_addr " \
                   "($addr_window_size bytes) is not large enough for " \
                   "the chosen scratchpad size ($scratchpad_kb KB). " \
                   "Please adjust the address range or reduce the scratchpad" \
                   "size."]
    }

    ###########################################################################
}

###########################################################################
proc syslevel_drc {mhsinst} {

    puts "vectorblox_mxp::syslevel_drc"
}

###########################################################################
proc syslevel_update {mhsinst} {

    puts "vectorblox_mxp::syslevel_update"
}

###########################################################################
proc platgen_syslevel_update {mhsinst} {

    puts "vectorblox_mxp::platgen_syslevel_update"
}

###########################################################################
