##############################################################################
#
# Copyright (C) 2012-2015 VectorBlox Computing, Inc.
#
###########################################################################

proc generate {drv_handle} {

	 set tcl_library "tcl_library"
	 set tcl_library [set ::$tcl_library]
	 if { [string match -nocase *ISE* $tcl_library] } {
		  set xps true
		  set vivado_version 0
	 } else {
		  set xps false
		  regexp {SDK/([0-9]*\.[1-4])/} "$tcl_library" matched vivado_version
	 }
	 set drv_name "vectorblox_mxp"

    # Generate XPAR_<instance_name>_<param_name> macros in xparameters.h.
    xdefine_include_file $drv_handle "xparameters.h" $drv_name \
        "NUM_INSTANCES" \
        "DEVICE_ID" \
        "C_S_AXI_BASEADDR" \
        "C_S_AXI_HIGHADDR" \
        "VECTOR_LANES" \
        "MAX_MASKED_WAVES" \
        "MASK_PARTITIONS" \
        "SCRATCHPAD_KB" \
        "C_M_AXI_DATA_WIDTH" \
        "MULFXP_WORD_FRACTION_BITS" \
        "MULFXP_HALF_FRACTION_BITS" \
        "MULFXP_BYTE_FRACTION_BITS" \
        "C_S_AXI_INSTR_BASEADDR" \
        "VECTOR_CUSTOM_INSTRUCTIONS" \
        "VCI_0_LANES" \
        "VCI_0_OPCODE_START" \
        "VCI_0_FUNCTIONS" \
        "VCI_1_LANES" \
        "VCI_1_OPCODE_START" \
        "VCI_1_FUNCTIONS" \
        "VCI_2_LANES" \
        "VCI_2_OPCODE_START" \
        "VCI_2_FUNCTIONS" \
        "VCI_3_LANES" \
        "VCI_3_OPCODE_START" \
        "VCI_3_FUNCTIONS" \
        "VCI_4_LANES" \
        "VCI_4_OPCODE_START" \
        "VCI_4_FUNCTIONS" \
        "VCI_5_LANES" \
        "VCI_5_OPCODE_START" \
        "VCI_5_FUNCTIONS" \
        "VCI_6_LANES" \
        "VCI_6_OPCODE_START" \
        "VCI_6_FUNCTIONS" \
        "VCI_7_LANES" \
        "VCI_7_OPCODE_START" \
        "VCI_7_FUNCTIONS" \
        "VCI_8_LANES" \
        "VCI_8_OPCODE_START" \
        "VCI_8_FUNCTIONS" \
        "VCI_9_LANES" \
        "VCI_9_OPCODE_START" \
        "VCI_9_FUNCTIONS" \
        "VCI_10_LANES" \
        "VCI_10_OPCODE_START" \
        "VCI_10_FUNCTIONS" \
        "VCI_11_LANES" \
        "VCI_11_OPCODE_START" \
        "VCI_11_FUNCTIONS" \
        "VCI_12_LANES" \
        "VCI_12_OPCODE_START" \
        "VCI_12_FUNCTIONS" \
        "VCI_13_LANES" \
        "VCI_13_OPCODE_START" \
        "VCI_13_FUNCTIONS" \
        "VCI_14_LANES" \
        "VCI_14_OPCODE_START" \
        "VCI_14_FUNCTIONS" \
        "VCI_15_LANES" \
        "VCI_15_OPCODE_START" \
        "VCI_15_FUNCTIONS" 

    # Generate macros with canonical name prefix in xparameters.h
    # i.e. XPAR_<driver_name>_<device_id>_<param_name>.
    # NOTE: if instance names already match canonical names
    # (<instance_name> = <device_name>_<device_id>), no new macros are
    # generated.
    xdefine_canonical_xpars $drv_handle "xparameters.h" $drv_name \
        "DEVICE_ID" \
        "C_S_AXI_BASEADDR" \
        "C_S_AXI_HIGHADDR" \
        "VECTOR_LANES" \
        "MAX_MASKED_WAVES" \
        "MASK_PARTITIONS" \
        "SCRATCHPAD_KB" \
        "C_M_AXI_DATA_WIDTH" \
        "MULFXP_WORD_FRACTION_BITS" \
        "MULFXP_HALF_FRACTION_BITS" \
        "MULFXP_BYTE_FRACTION_BITS" \
        "C_S_AXI_INSTR_BASEADDR" \
        "VECTOR_CUSTOM_INSTRUCTIONS" \
        "VCI_0_LANES" \
        "VCI_0_OPCODE_START" \
        "VCI_0_FUNCTIONS" \
        "VCI_1_LANES" \
        "VCI_1_OPCODE_START" \
        "VCI_1_FUNCTIONS" \
        "VCI_2_LANES" \
        "VCI_2_OPCODE_START" \
        "VCI_2_FUNCTIONS" \
        "VCI_3_LANES" \
        "VCI_3_OPCODE_START" \
        "VCI_3_FUNCTIONS" \
        "VCI_4_LANES" \
        "VCI_4_OPCODE_START" \
        "VCI_4_FUNCTIONS" \
        "VCI_5_LANES" \
        "VCI_5_OPCODE_START" \
        "VCI_5_FUNCTIONS" \
        "VCI_6_LANES" \
        "VCI_6_OPCODE_START" \
        "VCI_6_FUNCTIONS" \
        "VCI_7_LANES" \
        "VCI_7_OPCODE_START" \
        "VCI_7_FUNCTIONS" \
        "VCI_8_LANES" \
        "VCI_8_OPCODE_START" \
        "VCI_8_FUNCTIONS" \
        "VCI_9_LANES" \
        "VCI_9_OPCODE_START" \
        "VCI_9_FUNCTIONS" \
        "VCI_10_LANES" \
        "VCI_10_OPCODE_START" \
        "VCI_10_FUNCTIONS" \
        "VCI_11_LANES" \
        "VCI_11_OPCODE_START" \
        "VCI_11_FUNCTIONS" \
        "VCI_12_LANES" \
        "VCI_12_OPCODE_START" \
        "VCI_12_FUNCTIONS" \
        "VCI_13_LANES" \
        "VCI_13_OPCODE_START" \
        "VCI_13_FUNCTIONS" \
        "VCI_14_LANES" \
        "VCI_14_OPCODE_START" \
        "VCI_14_FUNCTIONS" \
        "VCI_15_LANES" \
        "VCI_15_OPCODE_START" \
        "VCI_15_FUNCTIONS" 

    # Define clock frequency macros
	 if { $vivado_version <= 2014.4 } {
		  set file_handle [xopen_include_file "xparameters.h"]
	 } else {
		  set file_handle [hsi::utils::open_include_file xparameters.h]
	 }
    puts $file_handle "/* Clock frequency for vectorblox_mxp instances */"
	 if { $vivado_version <= 2013.4} {
		  set periphs [xget_periphs $drv_handle]
	 } elseif { $vivado_version < 2015.1 } {
		  set periphs [xget_sw_iplist_for_driver $drv_handle]
	 } else {
		  set periphs [hsi::utils::get_common_driver_ips $drv_handle]
	 }

    foreach periph $periphs {
        if { $vivado_version <= 2013.4 } {
            set freq [xget_freq $periph]
        } elseif {$vivado_version <= 2014.2} {
            set freq [xget_ip_clk_pin_freq  $periph "core_clk"]
        } else {
            set freq [::hsm::utils::get_clk_pin_freq  $periph "core_clk"]
        }
		  if {$vivado_version < 2015.1 } {
				puts $file_handle "#define [xget_name $periph CLOCK_FREQ_HZ] $freq"
		  } else {
				puts $file_handle "#define [hsi::utils::get_ip_param_name $periph CLOCK_FREQ_HZ] $freq"
		  }
    }
    puts $file_handle \
        "\n/**************************************************************/\n"
    close $file_handle

    # Define and initialize an array of VectorBlox_MXP_Config structs.
    # NOTE: order of peripheral/driver parameters must match
    # order of VectorBlox_MXP_Config fields.
    # The case of the drv_string parameter matters: it must match
    # the case used for the <drv_string>_Config data type.
    # i.e. drv_string must be VectorBlox_MXP because the data type is called
    # VectorBlox_MXP_Config.
    xdefine_config_file $drv_handle "vectorblox_mxp_g.c" "VectorBlox_MXP" \
        "DEVICE_ID" \
        "C_S_AXI_BASEADDR" \
        "C_S_AXI_HIGHADDR" \
        "VECTOR_LANES" \
        "MAX_MASKED_WAVES" \
        "MASK_PARTITIONS" \
        "SCRATCHPAD_KB" \
        "C_M_AXI_DATA_WIDTH" \
        "MULFXP_WORD_FRACTION_BITS" \
        "MULFXP_HALF_FRACTION_BITS" \
        "MULFXP_BYTE_FRACTION_BITS" \
        "CLOCK_FREQ_HZ" \
        "C_S_AXI_INSTR_BASEADDR" \
        "VECTOR_CUSTOM_INSTRUCTIONS" \
        "VCI_0_LANES" \
        "VCI_0_OPCODE_START" \
        "VCI_0_FUNCTIONS" \
        "VCI_1_LANES" \
        "VCI_1_OPCODE_START" \
        "VCI_1_FUNCTIONS" \
        "VCI_2_LANES" \
        "VCI_2_OPCODE_START" \
        "VCI_2_FUNCTIONS" \
        "VCI_3_LANES" \
        "VCI_3_OPCODE_START" \
        "VCI_3_FUNCTIONS" \
        "VCI_4_LANES" \
        "VCI_4_OPCODE_START" \
        "VCI_4_FUNCTIONS" \
        "VCI_5_LANES" \
        "VCI_5_OPCODE_START" \
        "VCI_5_FUNCTIONS" \
        "VCI_6_LANES" \
        "VCI_6_OPCODE_START" \
        "VCI_6_FUNCTIONS" \
        "VCI_7_LANES" \
        "VCI_7_OPCODE_START" \
        "VCI_7_FUNCTIONS" \
        "VCI_8_LANES" \
        "VCI_8_OPCODE_START" \
        "VCI_8_FUNCTIONS" \
        "VCI_9_LANES" \
        "VCI_9_OPCODE_START" \
        "VCI_9_FUNCTIONS" \
        "VCI_10_LANES" \
        "VCI_10_OPCODE_START" \
        "VCI_10_FUNCTIONS" \
        "VCI_11_LANES" \
        "VCI_11_OPCODE_START" \
        "VCI_11_FUNCTIONS" \
        "VCI_12_LANES" \
        "VCI_12_OPCODE_START" \
        "VCI_12_FUNCTIONS" \
        "VCI_13_LANES" \
        "VCI_13_OPCODE_START" \
        "VCI_13_FUNCTIONS" \
        "VCI_14_LANES" \
        "VCI_14_OPCODE_START" \
        "VCI_14_FUNCTIONS" \
        "VCI_15_LANES" \
        "VCI_15_OPCODE_START" \
        "VCI_15_FUNCTIONS" 

    # Value of C_S_AXI_INSTR_BASEADDR is not valid when instruction port
    # interface is Direct FSL or AXI4-Stream.

    # MEMORY_WIDTH_LANES aka dma_alignment_bytes is derived from
    # C_M_AXI_DATA_WIDTH.

    # Note that CLOCK_FREQ_HZ isn't an RTL parameter;
    # it's a macro that was generated above.


}

###########################################################################
# NOTE: This has been modified to handle Direct FSL interfaces instead of
# FSL interfaces; i.e. MPD has
# BUS_INTERFACE BUS = FSL_SRC, BUS_STD = XIL_DRFSL, BUS_TYPE = INITIATOR (output from MXP)
# BUS_INTERFACE BUS = FSL_SINK, BUS_STD = XIL_DWFSL, BUS_TYPE = TARGET (input to MXP)
# instead of
# BUS_INTERFACE BUS = MFSL, BUS_STD = FSL, BUS_TYPE = MASTER (output from MXP)
# BUS_INTERFACE BUS = SFSL, BUS_STD = FSL, BUS_TYPE = SLAVE (input to MXP)
#
proc fsl_defines {inst_name file_handle} {

    set inst_name_upper [string toupper $inst_name]

    if {[string compare -nocase "none" $inst_name] != 0} {
        set sw_prochandle [xget_libgen_proc_handle]
        set ip_handle \
            [xget_sw_ipinst_handle_from_processor $sw_prochandle $inst_name]
        # ip_name is e.g. vectorblox_mxp
        # set ip_name [xget_value $ip_handle value]
        # puts "ip_name = $ip_name"
        set mhs_handle [xget_handle $ip_handle "parent"]

        # link_name is e.g. microblaze_0_DWFSL0
        set dwfsl_link_name [xget_value $ip_handle "BUS_INTERFACE" "FSL_SINK"]
        # puts "dwfsl_link_name = $dwfsl_link_name"
        if {$dwfsl_link_name != ""} {
            set dwfsl_handle [xget_hw_connected_busifs_handle $mhs_handle \
                                  $dwfsl_link_name "initiator"]
            # e.g. DWFSL0
            set dwfsl_name [xget_value $dwfsl_handle "NAME"]
            # puts "dwfsl_name = $dwfsl_name"
            set dwfsl_name [string toupper $dwfsl_name]
            set dwfsl_index [string map {DWFSL ""} $dwfsl_name]
            set macro_def \
                "#define XPAR_FSL_${inst_name_upper}_OUTPUT_SLOT_ID ${dwfsl_index}"
            puts $file_handle $macro_def
            # puts $macro_def
        }

        # e.g. vbx_mxp_0_FSL_SRC
        set drfsl_link_name [xget_value $ip_handle "BUS_INTERFACE" "FSL_SRC"]
        # puts "drfsl_link_name = $drfsl_link_name"
        if {$drfsl_link_name != ""} {
            set drfsl_handle [xget_hw_connected_busifs_handle $mhs_handle \
                                  $drfsl_link_name "target"]
            # e.g. DRFSL0
            set drfsl_name [xget_value $drfsl_handle "NAME"]
            # puts "drfsl_name = $drfsl_name"
            set drfsl_name [string toupper $drfsl_name]
            set drfsl_index [string map {DRFSL ""} $drfsl_name]
            set macro_def \
                "#define XPAR_FSL_${inst_name_upper}_INPUT_SLOT_ID ${drfsl_index}"
            puts $file_handle $macro_def
            # puts $macro_def
        }
    }
}

###########################################################################
proc xget_freq {periph} {
    set freq ""

    set port_name "core_clk"

    set clkhandle [xget_hw_port_handle $periph $port_name]
    if { [string compare -nocase $clkhandle ""] != 0 } {
        set freq [xget_hw_subproperty_value $clkhandle "CLK_FREQ_HZ"]
    }

    return $freq
}

###########################################################################
