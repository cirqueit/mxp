# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 0" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
	set VCI_LANES [ipgui::add_param $IPINST -parent $Page0 -name VCI_LANES]
	set PRECISION [ipgui::add_param $IPINST -parent $Page0 -name PRECISION]
}

proc update_PARAM_VALUE.VCI_LANES { PARAM_VALUE.VCI_LANES } {
	# Procedure called to update VCI_LANES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VCI_LANES { PARAM_VALUE.VCI_LANES } {
	# Procedure called to validate VCI_LANES
	return true
}


proc update_MODELPARAM_VALUE.VCI_LANES { MODELPARAM_VALUE.VCI_LANES PARAM_VALUE.VCI_LANES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VCI_LANES}] ${MODELPARAM_VALUE.VCI_LANES}
}

proc update_PARAM_VALUE.PRECISION { PARAM_VALUE.PRECISION } {
	# Procedure called to update PRECISION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PRECISION { PARAM_VALUE.PRECISION } {
	# Procedure called to validate PRECISION
	return true
}


proc update_MODELPARAM_VALUE.PRECISION { MODELPARAM_VALUE.PRECISION PARAM_VALUE.PRECISION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PRECISION}] ${MODELPARAM_VALUE.PRECISION}
}

