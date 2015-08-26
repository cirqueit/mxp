###############################################################################
#
# Based on Xilinx's axi2axi_connector
#
###############################################################################


#***--------------------------------***-----------------------------------***
#
#			     IPLEVEL_UPDATE_VALUE_PROC
#
#***--------------------------------***-----------------------------------***

#
# update parameter C_M_AXI_PROTOCOL
#
proc iplevel_update_protocol { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set s_proto [xget_hw_parameter_value $mhsinst "C_S_AXI_PROTOCOL"]
  return $s_proto
}

#
# update parameter C_M_AXI_SUPPORTS_USER_SIGNALS
#
proc iplevel_update_user_sig { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set s_sug [xget_hw_parameter_value $mhsinst "C_S_AXI_SUPPORTS_USER_SIGNALS"]
  return $s_sug 
}

#
# update USER_SIGNAL_WIDTH parameters
#
proc iplevel_update_usig_width { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set m_sug [xget_hw_parameter_value $mhsinst "C_M_AXI_SUPPORTS_USER_SIGNALS"]
  if { $m_sug == 1 } {
    set mpname [xget_hw_name $param_handle]
    set	spname [string replace $mpname 0 2 C_S]   
    set s_usig_width [xget_hw_parameter_value $mhsinst $spname]
    return $s_usig_width
  } else {
    return 1
  }
}

#
# update parameter C_M_AXI_WRITE_ACCEPTANCE
#
proc iplevel_update_acceptance { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set proto [xget_hw_parameter_value $mhsinst "C_S_AXI_PROTOCOL"]
  set lproto [string tolower $proto]
  if { [string compare $lproto "axi4lite"] == 0 } {
      return 1
  } else {
      return 8
  }
}

#
# update parameter C_M_AXI_WRITE_ISSUING
#
proc iplevel_update_write_issuing { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set s_acc [xget_hw_parameter_value $mhsinst "C_INTERCONNECT_S_AXI_WRITE_ACCEPTANCE"]
  return $s_acc
}

#
# update parameter C_M_AXI_READ_ISSUING
#
proc iplevel_update_read_issuing { param_handle } {
  set mhsinst [xget_hw_parent_handle $param_handle]
  set s_acc [xget_hw_parameter_value $mhsinst "C_INTERCONNECT_S_AXI_READ_ACCEPTANCE"]
  return $s_acc
}

