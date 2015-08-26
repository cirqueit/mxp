proc init_gui { IPINST } {

  set Page0 [ ipgui::add_page $IPINST  -name "Page0" -layout vertical]
  set Component_Name [ ipgui::add_param  $IPINST  -parent  $Page0  -name Component_Name ]

  set ADDR_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name ADDR_WIDTH]
  set DATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name DATA_WIDTH]
  set_property visible false $ADDR_WIDTH
  set_property visible false $DATA_WIDTH
}


proc update_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
}

proc validate_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
    return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
    return true
}

proc update_MODELPARAM_VALUE.C_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_AXI_ADDR_WIDTH PARAM_VALUE.ADDR_WIDTH } {
    set_property value [get_property value ${PARAM_VALUE.ADDR_WIDTH}] ${MODELPARAM_VALUE.C_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_AXI_DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
    set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.C_AXI_DATA_WIDTH}
}
