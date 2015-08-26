proc init_gui { IPINST } {

  set Page0 [ ipgui::add_page $IPINST  -name "Page0" -layout vertical]
  set Component_Name [ ipgui::add_param  $IPINST  -parent  $Page0  -name Component_Name ]

  set VCI_LANES [ipgui::add_param $IPINST -parent $vci_group -name VCI_LANES]
}

# proc update_PARAM_VALUE.VCI_LANES { PARAM_VALUE.VCI_LANES } {}

proc validate_PARAM_VALUE.VCI_LANES { PARAM_VALUE.VCI_LANES } {
    return true
}

proc update_MODELPARAM_VALUE.VCI_LANES { MODELPARAM_VALUE.VCI_LANES PARAM_VALUE.VCI_LANES } {
    set_property value [get_property value ${PARAM_VALUE.VCI_LANES}] ${MODELPARAM_VALUE.VCI_LANES}
}
