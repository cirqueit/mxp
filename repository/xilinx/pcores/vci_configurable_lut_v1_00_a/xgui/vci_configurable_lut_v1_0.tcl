
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/vci_configurable_lut_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 0" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
	set BASE_SHIFT [ipgui::add_param $IPINST -parent $Page0 -name BASE_SHIFT]
	set DOUBLE_CLOCKED [ipgui::add_param $IPINST -parent $Page0 -name DOUBLE_CLOCKED -widget comboBox]
	set LUT_DEPTH [ipgui::add_param $IPINST -parent $Page0 -name LUT_DEPTH]
	set DATA_WIDTH_BITS [ipgui::add_param $IPINST -parent $Page0 -name DATA_WIDTH_BITS]
	set BRAM_ADDRESS_WIDTH_LIMIT [ipgui::add_param $IPINST -parent $Page0 -name BRAM_ADDRESS_WIDTH_LIMIT]
	set OPERAND_SIZE_BYTES [ipgui::add_param $IPINST -parent $Page0 -name OPERAND_SIZE_BYTES -widget comboBox]
	set VCI_LANES [ipgui::add_param $IPINST -parent $Page0 -name VCI_LANES]
}

proc update_PARAM_VALUE.BASE_SHIFT { PARAM_VALUE.BASE_SHIFT PARAM_VALUE.LUT_DEPTH PARAM_VALUE.OPERAND_SIZE_BYTES } {
	# Procedure called to update BASE_SHIFT when any of the dependent parameters in the arguments change
	
	set BASE_SHIFT ${PARAM_VALUE.BASE_SHIFT}
	set LUT_DEPTH ${PARAM_VALUE.LUT_DEPTH}
	set OPERAND_SIZE_BYTES ${PARAM_VALUE.OPERAND_SIZE_BYTES}
	set values(LUT_DEPTH) [get_property value $LUT_DEPTH]
	set values(OPERAND_SIZE_BYTES) [get_property value $OPERAND_SIZE_BYTES]
	set_property value [gen_USERPARAMETER_BASE_SHIFT_VALUE $values(LUT_DEPTH) $values(OPERAND_SIZE_BYTES)] $BASE_SHIFT
}

proc validate_PARAM_VALUE.BASE_SHIFT { PARAM_VALUE.BASE_SHIFT } {
	# Procedure called to validate BASE_SHIFT
	return true
}

proc update_PARAM_VALUE.DOUBLE_CLOCKED { PARAM_VALUE.DOUBLE_CLOCKED } {
	# Procedure called to update DOUBLE_CLOCKED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DOUBLE_CLOCKED { PARAM_VALUE.DOUBLE_CLOCKED } {
	# Procedure called to validate DOUBLE_CLOCKED
	return true
}

proc update_PARAM_VALUE.LUT_DEPTH { PARAM_VALUE.LUT_DEPTH } {
	# Procedure called to update LUT_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LUT_DEPTH { PARAM_VALUE.LUT_DEPTH } {
	# Procedure called to validate LUT_DEPTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH_BITS { PARAM_VALUE.DATA_WIDTH_BITS } {
	# Procedure called to update DATA_WIDTH_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH_BITS { PARAM_VALUE.DATA_WIDTH_BITS } {
	# Procedure called to validate DATA_WIDTH_BITS
	return true
}

proc update_PARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT { PARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT } {
	# Procedure called to update BRAM_ADDRESS_WIDTH_LIMIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT { PARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT } {
	# Procedure called to validate BRAM_ADDRESS_WIDTH_LIMIT
	return true
}

proc update_PARAM_VALUE.OPERAND_SIZE_BYTES { PARAM_VALUE.OPERAND_SIZE_BYTES } {
	# Procedure called to update OPERAND_SIZE_BYTES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OPERAND_SIZE_BYTES { PARAM_VALUE.OPERAND_SIZE_BYTES } {
	# Procedure called to validate OPERAND_SIZE_BYTES
	return true
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

proc update_MODELPARAM_VALUE.OPERAND_SIZE_BYTES { MODELPARAM_VALUE.OPERAND_SIZE_BYTES PARAM_VALUE.OPERAND_SIZE_BYTES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OPERAND_SIZE_BYTES}] ${MODELPARAM_VALUE.OPERAND_SIZE_BYTES}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH_BITS { MODELPARAM_VALUE.DATA_WIDTH_BITS PARAM_VALUE.DATA_WIDTH_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH_BITS}] ${MODELPARAM_VALUE.DATA_WIDTH_BITS}
}

proc update_MODELPARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT { MODELPARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT PARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT}] ${MODELPARAM_VALUE.BRAM_ADDRESS_WIDTH_LIMIT}
}

proc update_MODELPARAM_VALUE.LUT_DEPTH { MODELPARAM_VALUE.LUT_DEPTH PARAM_VALUE.LUT_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LUT_DEPTH}] ${MODELPARAM_VALUE.LUT_DEPTH}
}

proc update_MODELPARAM_VALUE.DOUBLE_CLOCKED { MODELPARAM_VALUE.DOUBLE_CLOCKED PARAM_VALUE.DOUBLE_CLOCKED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOUBLE_CLOCKED}] ${MODELPARAM_VALUE.DOUBLE_CLOCKED}
}

