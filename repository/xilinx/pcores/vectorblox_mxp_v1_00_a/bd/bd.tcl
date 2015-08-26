proc init {cellpath otherInfo} {
    set cell [get_bd_cells $cellpath]

    # Make fields non-editable in GUI (marked "Auto").
    bd::mark_propagate_only $cell [list ID_WIDTH]

    # bd::mark_propagate_overrideable $cell {C_M_AXI_SUPPORTS_NARROW_BURST}
}

proc post_config_ip {cellpath undefined_params} {
    set busif [get_bd_intf_pins $cellpath/S_AXI_INSTR]
    if {$busif != ""} {
        set_property CONFIG.ID_WIDTH.VALUE_SRC "DEFAULT" $busif
        # otherwise is "USER"
    }
}

proc propagate {cell_name args} {
	 #to support versions >=2014.3
	 #make these functions the same
	 post_propagate $cell_name $args
}
proc post_propagate {cellpath undefined_params} {
    set ip [get_bd_cells $cellpath]
    set busif [get_bd_intf_pins $cellpath/S_AXI_INSTR]

    if {$busif != ""} {
        set id_wid [get_property CONFIG.ID_WIDTH $busif]
        set_property CONFIG.ID_WIDTH $id_wid $ip
    }
}
