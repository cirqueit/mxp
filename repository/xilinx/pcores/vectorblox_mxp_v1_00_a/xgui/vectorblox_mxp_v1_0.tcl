
#Loading additional proc with user specified bodies to compute parameter values.
# source [file join [file dirname [file dirname [info script] ]] gui/vectorblox_mxp_v1_0.gtcl ]

#Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
    set Page0 [ ipgui::add_page $IPINST  -name "MXP" -layout vertical]
    set Component_Name [ ipgui::add_param  $IPINST  -parent  $Page0  -name Component_Name ]

    set VECTOR_LANES [ipgui::add_param $IPINST -parent $Page0 -name VECTOR_LANES -widget comboBox]
    set MEMORY_WIDTH_LANES [ipgui::add_param $IPINST -parent $Page0 -name MEMORY_WIDTH_LANES -widget comboBox]

    set C_M_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_M_AXI_DATA_WIDTH -widget comboBox]

    set C_M_AXI_PROTOCOL [ipgui::add_param $IPINST -parent $Page0 -name C_M_AXI_PROTOCOL -widget comboBox]

    set BEATS_PER_BURST [ipgui::add_param $IPINST -parent $Page0 -name BEATS_PER_BURST -widget comboBox]

    set BURSTLENGTH_BYTES [ipgui::add_param $IPINST -parent $Page0 -name BURSTLENGTH_BYTES]

    set SCRATCHPAD_KB [ipgui::add_param $IPINST -parent $Page0 -name SCRATCHPAD_KB -widget comboBox]

    set MIN_MULTIPLIER_HW [ipgui::add_param $IPINST -parent $Page0 -name MIN_MULTIPLIER_HW -widget comboBox]

    set C_INSTR_PORT_TYPE [ipgui::add_param $IPINST -parent $Page0 -name C_INSTR_PORT_TYPE -widget comboBox]

    set MASK_PARTITIONS [ipgui::add_param $IPINST -parent $Page0 -name MASK_PARTITIONS -widget comboBox]

    set MAX_MASKED_WAVES [ipgui::add_param $IPINST -parent $Page0 -name MAX_MASKED_WAVES -widget comboBox]

    set tabgroup0 [ipgui::add_group $IPINST -parent $Page0 -name {Fixed-Point Multiply Format} -layout vertical]
    set MULFXP_WORD_FRACTION_BITS [ipgui::add_param $IPINST -parent $tabgroup0 -name MULFXP_WORD_FRACTION_BITS]
    set MULFXP_HALF_FRACTION_BITS [ipgui::add_param $IPINST -parent $tabgroup0 -name MULFXP_HALF_FRACTION_BITS]
    set MULFXP_BYTE_FRACTION_BITS [ipgui::add_param $IPINST -parent $tabgroup0 -name MULFXP_BYTE_FRACTION_BITS]
    set MULFXP_WORD_FORMAT [ipgui::add_param $IPINST -parent $tabgroup0 -name MULFXP_WORD_FORMAT]
    set MULFXP_HALF_FORMAT [ipgui::add_param $IPINST -parent $tabgroup0 -name MULFXP_HALF_FORMAT]
    set MULFXP_BYTE_FORMAT [ipgui::add_param $IPINST -parent $tabgroup0 -name MULFXP_BYTE_FORMAT]

    set ID_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name ID_WIDTH]

    set_property tooltip "The number of vector lanes. Must be a power of 2." \
        $VECTOR_LANES
    set_property tooltip [concat \
        "The data bus width of the AXI master interface expressed in " \
        "terms of 32-bit lanes. The number of memory lanes must be a power " \
        "of two and no larger than the number of vector lanes."] \
        $MEMORY_WIDTH_LANES
    set_property tooltip [concat \
        "The maximum number of beats per burst issued by the " \
        "AXI master interface."] \
        $BEATS_PER_BURST
    set_property tooltip [concat \
        "The AXI master interface's maximum burst size in bytes, " \
        "as determined by the number of memory lanes and the maximum number " \
        "of beats per burst. Note that the AXI protocol does not allow bursts " \
        "longer than 4096 bytes."] \
        $BURSTLENGTH_BYTES
    set_property tooltip "The Scratchpad RAM size in kilobytes." \
        $SCRATCHPAD_KB
    set_property tooltip [concat \
        "Sets the minimum multiplier size. This can be used to reduce DSP block " \
        "usage at the cost of performance. If set to Byte, then byte, halfword, " \
        "and word multipliers are instantiated and multiplication of any element " \
        "size runs at full speed. If set to Halfword, only word and " \
        "halfword multipliers are instantiated; byte-width " \
        "multiplication will be executed with the halfword multiplier and run at " \
        "half speed. If set to Word, only word multipliers are instantiated; " \
        "halfword-width multiplication will run at half speed and " \
        "byte-width multiplication will run at quarter speed."] \
        $MIN_MULTIPLIER_HW
    set_property tooltip [concat \
        "Specifies the number of least-significant bits that will be used to " \
        "represent the fractional part of a 32-bit fixed-point number."] \
        $MULFXP_WORD_FRACTION_BITS
    set_property tooltip [concat \
        "Specifies the number of least-significant bits that will be used to " \
        "represent the fractional part of a 16-bit fixed-point number."] \
        $MULFXP_HALF_FRACTION_BITS
    set_property tooltip [concat \
        "Specifies the number of least-significant bits that will be used to " \
        "represent the fractional part of an 8-bit fixed-point number."] \
        $MULFXP_BYTE_FRACTION_BITS
    set_property tooltip [concat \
        "32-bit fixed-point format in Q notation, where the first number " \
        "specifies the number of integer bits and the second number " \
        "specifies the number of fractional bits."] \
        $MULFXP_WORD_FORMAT
    set_property tooltip [concat \
        "16-bit fixed-point format in Q notation, where the first number " \
        "specifies the number of integer bits and the second number " \
        "specifies the number of fractional bits."] \
        $MULFXP_HALF_FORMAT
    set_property tooltip [concat \
        "8-bit fixed-point format in Q notation, where the first number " \
        "specifies the number of integer bits and the second number " \
        "specifies the number of fractional bits."] \
        $MULFXP_BYTE_FORMAT

    set_property tooltip [concat \
        "The data bus width in bits of the AXI master interface, " \
        "as determined by the number of memory lanes."] \
        $C_M_AXI_DATA_WIDTH

    set_property tooltip [concat \
        "Select between AXI3 and AXI4 as the DMA master interface " \
        "protocol. This only affects the maximum burst length allowed " \
        "(16 beats for AXI3, 256 beats for AXI4). If the DMA master is " \
        "connected to an AXI3 slave (such as a Zynq PS S_AXI_HP port), " \
        "selecting AXI3 as the AXI master protocol will prevent an " \
        "AXI4-to-AXI3 protocol converter (burst splitter) from being " \
        "automatically inserted in the AXI interconnect."] \
        $C_M_AXI_PROTOCOL
    set_property tooltip [concat \
        "Type of bus interface to use for the MXP intruction port."] \
        $C_INSTR_PORT_TYPE

    set_property tooltip [concat \
        "Changes the granularity of masked instructions. Currently only 1
        (enabled) and 0 (disabled) supported."] \
        $MASK_PARTITIONS
    set_property tooltip [concat \
        "The number of waves supported by a masked vector instruction " \
        "(when the element size is one byte). " \
        "The maximum vector length for masked instructions will be this " \
        "value multiplied by VECTOR_LANES*4."] \
        $MAX_MASKED_WAVES

    set VCI_CONFIG [ ipgui::add_page $IPINST -name "Custom Instructions" -layout horizontal]
    set vci_ports [ipgui::add_group $IPINST -parent $VCI_CONFIG -name "VCI Ports" -layout vertical]
    set VECTOR_CUSTOM_INSTRUCTIONS [ipgui::add_param $IPINST -parent $vci_ports -name VECTOR_CUSTOM_INSTRUCTIONS -widget comboBox]
    set_property tooltip [concat \
        "Number of Vector Custom Instruction (VCI) Ports. "\
        "VCI configuration is done on the \"VCI X\" tab"] \
        $VECTOR_CUSTOM_INSTRUCTIONS

    for {set vci 0} {$vci < 16} {incr vci} {
	set vci_tab[set vci] [ipgui::add_group $IPINST -parent $vci_ports -name "VCI $vci" -layout vertical]
	set VCI_[set vci]_LANES [ipgui::add_param $IPINST -parent [set vci_tab[set vci]] -name VCI_[set vci]_LANES]
	set_property tooltip "The number of lanes on VCI port $vci. Must be less than or equal to VECTOR_LANES." \
	    [set VCI_[set vci]_LANES]
	set VCI_[set vci]_OPCODE_START [ipgui::add_param $IPINST -parent [set vci_tab[set vci]] -name VCI_[set vci]_OPCODE_START -widget comboBox]
	set_property tooltip "The starting VCUSTOM opcode for VCI port $vci." \
	    [set VCI_[set vci]_OPCODE_START]
	set VCI_[set vci]_FUNCTIONS [ipgui::add_param $IPINST -parent [set vci_tab[set vci]] -name VCI_[set vci]_FUNCTIONS -widget comboBox]
	set_property tooltip "The number of functions (opcodes) for VCI port $vci." \
	    [set VCI_[set vci]_FUNCTIONS]
	set VCI_[set vci]_OPCODE_END [ipgui::add_param $IPINST -parent [set vci_tab[set vci]] -name VCI_[set vci]_OPCODE_END]
	set_property tooltip "The ending VCUSTOM opcode for VCI port $vci." \
	    [set VCI_[set vci]_OPCODE_END]
	set VCI_[set vci]_MODIFIES_DEST_ADDR [ipgui::add_param $IPINST -parent [set vci_tab[set vci]] -name VCI_[set vci]_MODIFIES_DEST_ADDR -widget comboBox]
	set_property tooltip "Set true if VCI port $vci modifies the destination (writeback) address." \
	    [set VCI_[set vci]_MODIFIES_DEST_ADDR]
    }

    set vci_opcodes [ipgui::add_group $IPINST -parent $VCI_CONFIG -name "VCI Opcodes" -layout vertical]
    for {set opcode 0} {$opcode < 16} {incr opcode} {
	set VCUSTOM[set opcode]_DEPTH [ipgui::add_param $IPINST -parent $vci_opcodes -name VCUSTOM[set opcode]_DEPTH]
	set_property tooltip "The depth (pipeline stages) of the VCI mapped to VCUSTOM${opcode}." \
	    [set VCUSTOM[set opcode]_DEPTH]
    }
}

###########################################################################
proc update_PARAM_VALUE.MIN_MULTIPLIER_HW { PARAM_VALUE.MIN_MULTIPLIER_HW } {
    # Procedure called to update MIN_MULTIPLIER_HW when any of the dependent
    # parameters in the arguments change
}

proc validate_PARAM_VALUE.MIN_MULTIPLIER_HW { PARAM_VALUE.MIN_MULTIPLIER_HW } {
    # Procedure called to validate MIN_MULTIPLIER_HW
    return true
}

proc update_PARAM_VALUE.SCRATCHPAD_KB { PARAM_VALUE.SCRATCHPAD_KB } {
}

proc validate_PARAM_VALUE.SCRATCHPAD_KB { PARAM_VALUE.SCRATCHPAD_KB } {
    return true
}

proc update_PARAM_VALUE.VECTOR_LANES { PARAM_VALUE.VECTOR_LANES } {
}

proc update_PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS { PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS } {
}

proc validate_PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS { PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS } {
    return true
}

proc common_validate_VL_MWL { PARAM_VALUE.VECTOR_LANES PARAM_VALUE.MEMORY_WIDTH_LANES CHANGED_PARAM } {
    set memory_width_lanes [get_property value ${PARAM_VALUE.MEMORY_WIDTH_LANES}]
    set vector_lanes [get_property value ${PARAM_VALUE.VECTOR_LANES}]
    if {($memory_width_lanes > $vector_lanes)} {
        set_property errmsg [concat \
            "The number of memory lanes ($memory_width_lanes) " \
            "cannot be larger than the number of vector lanes ($vector_lanes)." \
            "Please reduce the number of memory lanes or increase " \
            "the number of vector lanes."] \
            ${CHANGED_PARAM}
        return false
    }
    return true
}

proc common_validate_BPB_MWL { PARAM_VALUE.BEATS_PER_BURST PARAM_VALUE.MEMORY_WIDTH_LANES CHANGED_PARAM } {
    # An AXI burst must not cross a 4KB boundary. This limits the maximum
    # number of beats per burst for large data bus widths.
    # burstlength_bytes <= min(4096, beats_per_burst*memory_width_lanes*4).
    # NOTE: this is only an issue for AXI4, where beats_per_burst <= 256.
    # For AXI, maximum transfer size (bytes per beat) is 128 bytes, or 1024 bits,
    # so memory_width_lanes must be <= 32.
    # For AXI3, beats_per_burst must be <= 16, so
    # burstlength_bytes <= 2048 bytes, and bursts never exceed 4KB.
    set beats_per_burst [get_property value ${PARAM_VALUE.BEATS_PER_BURST}]
    set memory_width_lanes [get_property value ${PARAM_VALUE.MEMORY_WIDTH_LANES}]
    set burstlength_bytes [expr $beats_per_burst * $memory_width_lanes * 32/8]
    set max_beats [expr 4096 / (4*$memory_width_lanes)]
    if {$burstlength_bytes > 4096} {
        set_property errmsg [concat \
            "The selected number of beats per burst ($beats_per_burst) " \
            "is too large for the selected number of memory lanes " \
            "($memory_width_lanes). " \
            "An AXI burst cannot be larger than 4 KB, so a burst " \
            "cannot be longer than $max_beats beats when there are " \
            "$memory_width_lanes memory lanes. " \
            "Please reduce the maximum number of beats per burst or " \
            "reduce the number of memory lanes."] \
            ${CHANGED_PARAM}
        return false
    }
    return true
}

proc common_validate_BPB_PROTOCOL { PARAM_VALUE.BEATS_PER_BURST PARAM_VALUE.C_M_AXI_PROTOCOL CHANGED_PARAM } {
    set beats_per_burst [get_property value ${PARAM_VALUE.BEATS_PER_BURST}]
    set protocol [get_property value ${PARAM_VALUE.C_M_AXI_PROTOCOL}]
    if {$protocol == "AXI3"} {
        if {$beats_per_burst > 16} {
            set_property errmsg [concat \
                "The burst size cannot be larger than 16 beats when the " \
                "AXI master protocol is set to AXI3. " \
                "Please reduce the maximum number of beats per burst or " \
                "change the protocol to AXI4."] \
                ${CHANGED_PARAM}
            return false
        }
    }
    return true
}

proc validate_PARAM_VALUE.VECTOR_LANES { PARAM_VALUE.VECTOR_LANES PARAM_VALUE.MEMORY_WIDTH_LANES } {

    set r [common_validate_VL_MWL ${PARAM_VALUE.VECTOR_LANES} \
               ${PARAM_VALUE.MEMORY_WIDTH_LANES} \
               ${PARAM_VALUE.VECTOR_LANES}]
    return $r
}

proc update_PARAM_VALUE.MEMORY_WIDTH_LANES { PARAM_VALUE.MEMORY_WIDTH_LANES } {
}

proc validate_PARAM_VALUE.MEMORY_WIDTH_LANES { PARAM_VALUE.MEMORY_WIDTH_LANES PARAM_VALUE.VECTOR_LANES PARAM_VALUE.BEATS_PER_BURST } {

    set r [common_validate_VL_MWL ${PARAM_VALUE.VECTOR_LANES} \
               ${PARAM_VALUE.MEMORY_WIDTH_LANES} \
               ${PARAM_VALUE.MEMORY_WIDTH_LANES}]
    if {!$r} {
        return $r
    }
    set r [common_validate_BPB_MWL ${PARAM_VALUE.BEATS_PER_BURST} \
               ${PARAM_VALUE.MEMORY_WIDTH_LANES} \
               ${PARAM_VALUE.MEMORY_WIDTH_LANES}]
    return $r
}

proc common_update_range_BPB { PARAM_VALUE.BEATS_PER_BURST PARAM_VALUE.C_M_AXI_PROTOCOL } {
    # Change range of allowable values depending on selected AXI master
    # protocol.
    # Note: [in Vivado 2013.4] if protocol is AXI4 and BPB is > 16, and
    # protocol is then changed to AXI3, validate_*.C_M_AXI_PROTOCOL
    # procedure appears to be run first (producing an error message),
    # and range_value is not updated (i.e. this procedure is not called).
    # So update the range when validate_*.BPB is called as well.
    set beats [get_property value ${PARAM_VALUE.BEATS_PER_BURST}]
    set protocol [get_property value ${PARAM_VALUE.C_M_AXI_PROTOCOL}]
    if {$protocol == "AXI3"} {
        if {$beats > 16} {
            set beats 16
        }
        set_property range_value "$beats,1,2,4,8,16" ${PARAM_VALUE.BEATS_PER_BURST}
    } else {
        # AXI4
        set_property range_value "$beats,1,2,4,8,16,32,64,128,256" ${PARAM_VALUE.BEATS_PER_BURST}
        # Note: Could restrict beats_per_burst choices based on
        # memory_width_lanes as well.
        # i.e. mwl=32 (1024 bits, 128 bytes) => max 4096/128 = 32 beats.
        #      mwl=16 => max 64 beats
        #      mwl=8  => max 128 beats
        #      mwl<=4 => max 256 beats
        # However, enforcing this in drop-down menu may be confusing to user
        # (vs. generating an error message explaining why BPB must be reduced.)
    }
}

proc update_PARAM_VALUE.BEATS_PER_BURST { PARAM_VALUE.BEATS_PER_BURST PARAM_VALUE.C_M_AXI_PROTOCOL } {
    common_update_range_BPB ${PARAM_VALUE.BEATS_PER_BURST} ${PARAM_VALUE.C_M_AXI_PROTOCOL}
}

proc validate_PARAM_VALUE.BEATS_PER_BURST { PARAM_VALUE.BEATS_PER_BURST PARAM_VALUE.MEMORY_WIDTH_LANES PARAM_VALUE.C_M_AXI_PROTOCOL} {

    common_update_range_BPB ${PARAM_VALUE.BEATS_PER_BURST} ${PARAM_VALUE.C_M_AXI_PROTOCOL}

    set r [common_validate_BPB_MWL ${PARAM_VALUE.BEATS_PER_BURST} \
               ${PARAM_VALUE.MEMORY_WIDTH_LANES} \
               ${PARAM_VALUE.BEATS_PER_BURST}]
    if {!$r} {
        return $r
    }

    set r [common_validate_BPB_PROTOCOL ${PARAM_VALUE.BEATS_PER_BURST} \
               ${PARAM_VALUE.C_M_AXI_PROTOCOL} \
               ${PARAM_VALUE.BEATS_PER_BURST}]
    return $r
}

proc update_PARAM_VALUE.MULFXP_HALF_FRACTION_BITS { PARAM_VALUE.MULFXP_HALF_FRACTION_BITS } {
}

proc validate_PARAM_VALUE.MULFXP_HALF_FRACTION_BITS { PARAM_VALUE.MULFXP_HALF_FRACTION_BITS } {
    return true
}

proc update_PARAM_VALUE.MULFXP_WORD_FRACTION_BITS { PARAM_VALUE.MULFXP_WORD_FRACTION_BITS } {
}

proc validate_PARAM_VALUE.MULFXP_WORD_FRACTION_BITS { PARAM_VALUE.MULFXP_WORD_FRACTION_BITS } {
    return true
}

proc update_PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS { PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS } {
}

proc validate_PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS { PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS } {
    return true
}

proc update_PARAM_VALUE.MULFXP_WORD_FORMAT { PARAM_VALUE.MULFXP_WORD_FORMAT PARAM_VALUE.MULFXP_WORD_FRACTION_BITS } {
    set word_qn [get_property value ${PARAM_VALUE.MULFXP_WORD_FRACTION_BITS}]
    if {($word_qn > 0 ) && ($word_qn < 32)} {
        set s [format "Q%d.%d" [expr 32-$word_qn] $word_qn]
    } else {
        set s "Q?.?"
    }
    set_property value $s ${PARAM_VALUE.MULFXP_WORD_FORMAT}
}

proc validate_PARAM_VALUE.MULFXP_WORD_FORMAT { PARAM_VALUE.MULFXP_WORD_FORMAT } {
    return true
}

proc update_PARAM_VALUE.MULFXP_HALF_FORMAT { PARAM_VALUE.MULFXP_HALF_FORMAT PARAM_VALUE.MULFXP_HALF_FRACTION_BITS } {
    set half_qn [get_property value ${PARAM_VALUE.MULFXP_HALF_FRACTION_BITS}]
    if {($half_qn > 0 ) && ($half_qn < 16)} {
        set s [format "Q%d.%d" [expr 16-$half_qn] $half_qn]
    } else {
        set s "Q?.?"
    }
    set_property value $s ${PARAM_VALUE.MULFXP_HALF_FORMAT}
}

proc validate_PARAM_VALUE.MULFXP_HALF_FORMAT { PARAM_VALUE.MULFXP_HALF_FORMAT } {
    return true
}

proc update_PARAM_VALUE.MULFXP_BYTE_FORMAT { PARAM_VALUE.MULFXP_BYTE_FORMAT PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS } {
    set byte_qn [get_property value ${PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS}]
    if {($byte_qn > 0 ) && ($byte_qn < 8)} {
        set s [format "Q%d.%d" [expr 8-$byte_qn] $byte_qn]
    } else {
        set s "Q?.?"
    }
    set_property value $s ${PARAM_VALUE.MULFXP_BYTE_FORMAT}
}

proc validate_PARAM_VALUE.MULFXP_BYTE_FORMAT { PARAM_VALUE.MULFXP_BYTE_FORMAT } {
    return true
}

# Make dependent on VECTOR_LANES as well, because if MEMORY_WIDTH_LANES fails
# validation, C_M_AXI_DATA_WIDTH won't get updated. If VECTOR_LANES is then
# changed so that MEMORY_WIDTH_LANES is valid, C_M_AXI_DATA_WIDTH isn't
# updated unless VECTOR_LANES is in dependency list.
proc update_PARAM_VALUE.C_M_AXI_DATA_WIDTH { PARAM_VALUE.C_M_AXI_DATA_WIDTH PARAM_VALUE.MEMORY_WIDTH_LANES PARAM_VALUE.VECTOR_LANES } {
    set val [expr [get_property value ${PARAM_VALUE.MEMORY_WIDTH_LANES}]*32]
    set_property value $val ${PARAM_VALUE.C_M_AXI_DATA_WIDTH}
}

proc validate_PARAM_VALUE.C_M_AXI_DATA_WIDTH { PARAM_VALUE.C_M_AXI_DATA_WIDTH } {
    return true
}

# VECTOR_LANES is a dependency for the same reason as for
# update_PARAM_VALUE.C_M_AXI_DATA_WIDTH.
proc update_PARAM_VALUE.BURSTLENGTH_BYTES { PARAM_VALUE.BURSTLENGTH_BYTES PARAM_VALUE.BEATS_PER_BURST PARAM_VALUE.MEMORY_WIDTH_LANES PARAM_VALUE.VECTOR_LANES } {
    set val [expr [get_property value ${PARAM_VALUE.BEATS_PER_BURST}] * \
                 [get_property value ${PARAM_VALUE.MEMORY_WIDTH_LANES}] * 32/8]
    set_property value $val ${PARAM_VALUE.BURSTLENGTH_BYTES}
}

proc validate_PARAM_VALUE.BURSTLENGTH_BYTES { PARAM_VALUE.BURSTLENGTH_BYTES } {
    return true
}

proc update_PARAM_VALUE.C_M_AXI_PROTOCOL { PARAM_VALUE.C_M_AXI_PROTOCOL } {}

proc validate_PARAM_VALUE.C_M_AXI_PROTOCOL { PARAM_VALUE.C_M_AXI_PROTOCOL PARAM_VALUE.BEATS_PER_BURST } {
    set r [common_validate_BPB_PROTOCOL ${PARAM_VALUE.BEATS_PER_BURST} \
               ${PARAM_VALUE.C_M_AXI_PROTOCOL} \
               ${PARAM_VALUE.C_M_AXI_PROTOCOL}]
    return $r
}

#Generate VCI processes procedurally
for {set vci 0} {$vci < 16} {incr vci} {
    set vci_procs_template {
	proc update_PARAM_VALUE.VCI_<<VCI>>_LANES { PARAM_VALUE.VCI_<<VCI>>_LANES PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS } {
	    set vector_custom_instructions [get_property value ${PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS}]
	    if {$vector_custom_instructions > <<VCI>>} {
#		set_property enabled true ${PARAM_VALUE.VCI_<<VCI>>_LANES}
	    } else {
#		set_property enabled false ${PARAM_VALUE.VCI_<<VCI>>_LANES}
	    }
	}
	proc validate_PARAM_VALUE.VCI_<<VCI>>_LANES { PARAM_VALUE.VCI_<<VCI>>_LANES PARAM_VALUE.VECTOR_LANES } {
	    set vci_<<VCI>>_lanes [get_property value ${PARAM_VALUE.VCI_<<VCI>>_LANES}]
	    set vector_lanes [get_property value ${PARAM_VALUE.VECTOR_LANES}]
	    if {$vci_<<VCI>>_lanes > $vector_lanes} {
		return false;
	    } 
	    return true
	}
	proc update_PARAM_VALUE.VCI_<<VCI>>_OPCODE_START { PARAM_VALUE.VCI_<<VCI>>_OPCODE_START PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS } {
	    set vector_custom_instructions [get_property value ${PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS}]
	    if {$vector_custom_instructions > <<VCI>>} {
#		set_property enabled true ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_START}
	    } else {
#		set_property enabled false ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_START}
	    }
	}
	proc validate_PARAM_VALUE.VCI_<<VCI>>_OPCODE_START { PARAM_VALUE.VCI_<<VCI>>_OPCODE_START PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS } {
	    set opcode_start [get_property value ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_START}]
	    set functions [get_property value ${PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}]
	    set opcode_end [expr $opcode_start + $functions - 1]
	    if {$opcode_end > 15} {
		return false;
	    } 
	    return true
	}
	proc update_PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS { PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS IPINST } {
	    set vector_custom_instructions [get_property value ${PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS}]
	    if {$vector_custom_instructions > <<VCI>>} {
#		set_property enabled true ${PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}
	    } else {
#		set_property enabled false ${PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}
	    }
	}
	proc validate_PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS { PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS PARAM_VALUE.VCI_<<VCI>>_OPCODE_START } {
	    set opcode_start [get_property value ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_START}]
	    set functions [get_property value ${PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}]
	    set opcode_end [expr $opcode_start + $functions - 1]
	    if {$opcode_end > 15} {
		return false;
	    } 
	    return true
	}
	proc update_PARAM_VALUE.VCI_<<VCI>>_OPCODE_END { PARAM_VALUE.VCI_<<VCI>>_OPCODE_END PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS PARAM_VALUE.VCI_<<VCI>>_OPCODE_START PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS } {
	    set opcode_start [get_property value ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_START}]
	    set functions [get_property value ${PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}]
	    set opcode_end [expr $opcode_start + $functions - 1]
	    set_property value $opcode_end ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_END}

#	    set_property enabled false ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_END}
	}
	proc validate_PARAM_VALUE.VCI_<<VCI>>_OPCODE_END { PARAM_VALUE.VCI_<<VCI>>_OPCODE_END } {
	    return true
	}
	proc update_PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR { PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS } {
	    set vector_custom_instructions [get_property value ${PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS}]
	    if {$vector_custom_instructions > <<VCI>>} {
#		set_property enabled true ${PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR}
	    } else {
#		set_property enabled false ${PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR}
	    }
	}
	proc validate_PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR { PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR } {
	    return true
	}
    }
    set vci_procs [regsub -all "<<VCI>>" $vci_procs_template $vci]
    namespace eval [namespace current] $vci_procs
}

#Generate VCUSTOM opcode processes procedurally
for {set opcode 0} {$opcode < 16} {incr opcode} {
    set opcode_procs_template {
	proc update_PARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH { PARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH } {
	}
	proc validate_PARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH { PARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH } {
	    return true
	}
    }
    set opcode_procs [regsub -all "<<OPCODE>>" $opcode_procs_template $opcode]
    namespace eval [namespace current] $opcode_procs
}


###########################################################################

proc generate_remap01_model_procs { direct_model_params } {
  set direct_model_template {
    proc update_<<MP>> {<<MP>> <<P>>} {
      set p [get_property value [set <<P>>]]
      if {$p == 0} { set p 1 }
      set_property value $p [set <<MP>>]
    }
  }
  foreach {p mp} $direct_model_params {
    set c [regsub -all "<<P>>" $direct_model_template $p]
    set c [regsub -all "<<MP>>" $c $mp]
    namespace eval [namespace current] $c
  }
}

generate_remap01_model_procs { PARAM_VALUE.ID_WIDTH MODELPARAM_VALUE.C_S_AXI_INSTR_ID_WIDTH }

###########################################################################
# Procedures called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

proc update_MODELPARAM_VALUE.VECTOR_LANES { MODELPARAM_VALUE.VECTOR_LANES PARAM_VALUE.VECTOR_LANES } {
    set_property value [get_property value ${PARAM_VALUE.VECTOR_LANES}] ${MODELPARAM_VALUE.VECTOR_LANES}
}

proc update_MODELPARAM_VALUE.SCRATCHPAD_KB { MODELPARAM_VALUE.SCRATCHPAD_KB PARAM_VALUE.SCRATCHPAD_KB } {
    set_property value [get_property value ${PARAM_VALUE.SCRATCHPAD_KB}] ${MODELPARAM_VALUE.SCRATCHPAD_KB}
}

proc update_MODELPARAM_VALUE.BURSTLENGTH_BYTES { MODELPARAM_VALUE.BURSTLENGTH_BYTES PARAM_VALUE.BURSTLENGTH_BYTES } {
    set_property value [get_property value ${PARAM_VALUE.BURSTLENGTH_BYTES}] ${MODELPARAM_VALUE.BURSTLENGTH_BYTES}
}

proc update_MODELPARAM_VALUE.MIN_MULTIPLIER_HW { MODELPARAM_VALUE.MIN_MULTIPLIER_HW PARAM_VALUE.MIN_MULTIPLIER_HW } {
    set_property value [get_property value ${PARAM_VALUE.MIN_MULTIPLIER_HW}] ${MODELPARAM_VALUE.MIN_MULTIPLIER_HW}
}

proc update_MODELPARAM_VALUE.MULFXP_WORD_FRACTION_BITS { MODELPARAM_VALUE.MULFXP_WORD_FRACTION_BITS PARAM_VALUE.MULFXP_WORD_FRACTION_BITS } {
    set_property value [get_property value ${PARAM_VALUE.MULFXP_WORD_FRACTION_BITS}] ${MODELPARAM_VALUE.MULFXP_WORD_FRACTION_BITS}
}

proc update_MODELPARAM_VALUE.MULFXP_HALF_FRACTION_BITS { MODELPARAM_VALUE.MULFXP_HALF_FRACTION_BITS PARAM_VALUE.MULFXP_HALF_FRACTION_BITS } {
    set_property value [get_property value ${PARAM_VALUE.MULFXP_HALF_FRACTION_BITS}] ${MODELPARAM_VALUE.MULFXP_HALF_FRACTION_BITS}
}

proc update_MODELPARAM_VALUE.MULFXP_BYTE_FRACTION_BITS { MODELPARAM_VALUE.MULFXP_BYTE_FRACTION_BITS PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS } {
    set_property value [get_property value ${PARAM_VALUE.MULFXP_BYTE_FRACTION_BITS}] ${MODELPARAM_VALUE.MULFXP_BYTE_FRACTION_BITS}
}

proc update_MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH PARAM_VALUE.C_M_AXI_DATA_WIDTH} {
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH}
}

# proc update_MODELPARAM_VALUE.C_S_AXI_INSTR_ID_WIDTH { MODELPARAM_VALUE.C_S_AXI_INSTR_ID_WIDTH } {
#     set_property value [get_property value ${PARAM_VALUE.C_S_AXI_INSTR_ID_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_INSTR_ID_WIDTH}
# }

proc update_MODELPARAM_VALUE.C_M_AXI_LEN_WIDTH { MODELPARAM_VALUE.C_M_AXI_LEN_WIDTH PARAM_VALUE.C_M_AXI_PROTOCOL } {
    array set map {AXI4 8 AXI3 4}
    set p [get_property value ${PARAM_VALUE.C_M_AXI_PROTOCOL}]
    set_property value $map($p) ${MODELPARAM_VALUE.C_M_AXI_LEN_WIDTH}
}

proc update_MODELPARAM_VALUE.C_INSTR_PORT_TYPE { MODELPARAM_VALUE.C_INSTR_PORT_TYPE PARAM_VALUE.C_INSTR_PORT_TYPE } {
    set_property value [get_property value ${PARAM_VALUE.C_INSTR_PORT_TYPE}] \
        ${MODELPARAM_VALUE.C_INSTR_PORT_TYPE}
}

proc update_MODELPARAM_VALUE.MASK_PARTITIONS { MODELPARAM_VALUE.MASK_PARTITIONS PARAM_VALUE.MASK_PARTITIONS } {
    set_property value [get_property value ${PARAM_VALUE.MASK_PARTITIONS}] ${MODELPARAM_VALUE.MASK_PARTITIONS}
}

proc update_MODELPARAM_VALUE.MAX_MASKED_WAVES { MODELPARAM_VALUE.MAX_MASKED_WAVES PARAM_VALUE.MAX_MASKED_WAVES } {
    set_property value [get_property value ${PARAM_VALUE.MAX_MASKED_WAVES}] ${MODELPARAM_VALUE.MAX_MASKED_WAVES}
}

proc update_MODELPARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS { MODELPARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS IPINST } {
    set_property value [get_property value ${PARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS}] ${MODELPARAM_VALUE.VECTOR_CUSTOM_INSTRUCTIONS}
}

#Generate VCI processes procedurally
for {set vci 0} {$vci < 16} {incr vci} {
    set vci_procs_template {
	proc update_MODELPARAM_VALUE.VCI_<<VCI>>_LANES { MODELPARAM_VALUE.VCI_<<VCI>>_LANES PARAM_VALUE.VCI_<<VCI>>_LANES } {
	    set_property value [get_property value ${PARAM_VALUE.VCI_<<VCI>>_LANES}] ${MODELPARAM_VALUE.VCI_<<VCI>>_LANES}
	}
	proc update_MODELPARAM_VALUE.VCI_<<VCI>>_OPCODE_START { MODELPARAM_VALUE.VCI_<<VCI>>_OPCODE_START PARAM_VALUE.VCI_<<VCI>>_OPCODE_START } {
	    set_property value [get_property value ${PARAM_VALUE.VCI_<<VCI>>_OPCODE_START}] ${MODELPARAM_VALUE.VCI_<<VCI>>_OPCODE_START}
	}
	proc update_MODELPARAM_VALUE.VCI_<<VCI>>_FUNCTIONS { MODELPARAM_VALUE.VCI_<<VCI>>_FUNCTIONS PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS } {
	    set_property value [get_property value ${PARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}] ${MODELPARAM_VALUE.VCI_<<VCI>>_FUNCTIONS}
	}
	proc update_MODELPARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR { MODELPARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR } {
	    set_property value [get_property value ${PARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR}] ${MODELPARAM_VALUE.VCI_<<VCI>>_MODIFIES_DEST_ADDR}
	}
    }
    set vci_procs [regsub -all "<<VCI>>" $vci_procs_template $vci]
    namespace eval [namespace current] $vci_procs
}

#Generate VCUSTOM opcode processes procedurally
for {set opcode 0} {$opcode < 16} {incr opcode} {
    set opcode_procs_template {
	proc update_MODELPARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH { MODELPARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH PARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH } {
	    set_property value [get_property value ${PARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH}] ${MODELPARAM_VALUE.VCUSTOM<<OPCODE>>_DEPTH}
	}
    }
    set opcode_procs [regsub -all "<<OPCODE>>" $opcode_procs_template $opcode]
    namespace eval [namespace current] $opcode_procs
}

###########################################################################
# There is no corresponding user parameter named
# "C_S_AXI_ADDR_WIDTH".
# "C_S_AXI_DATA_WIDTH".
# "C_S_AXI_INSTR_ADDR_WIDTH".
# "C_S_AXI_INSTR_DATA_WIDTH".
# "C_M_AXI_ADDR_WIDTH".
# Setting updated value from the model parameter.

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
    set_property value 32 ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH } {
    set_property value 32 ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_INSTR_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_INSTR_ADDR_WIDTH } {
    set_property value 32 ${MODELPARAM_VALUE.C_S_AXI_INSTR_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_INSTR_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_INSTR_DATA_WIDTH } {
    set_property value 32 ${MODELPARAM_VALUE.C_S_AXI_INSTR_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH } {
    set_property value 32 ${MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH}
}

###########################################################################
