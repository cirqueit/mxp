proc log_out {out_str} {
	set chan [open log.txt a]
	set timestamp [clock format [clock seconds]]
	puts $chan "$timestamp $out_str"
	close $chan
}

proc generate {drv_handle} {
	 set slave [get_cells $drv_handle]
	 set vlnv [get_property "VLNV" $slave]

	 set first_index [string length "config."]

	 foreach p  [list_property $slave] {
		  set val [get_property $p $slave]
 		  if { ! [string is integer -strict $val ] } {
				continue;
		  }

		  set strlen [string length $p]
		  set dt_node [string tolower [string  range "$p" $first_index [string length $p]]]
		  set dt_node "vblx,$dt_node"
		  #log_out $dt_node
		  hsm::utils::add_new_property $drv_handle $dt_node int $val
	 }
	 set dt_node "vblx,clock_freq_hz"
	 set core_clk_freq [get_property CLK_FREQ [get_pins -of_objects $slave "core_clk"]]
	 hsm::utils::add_new_property $drv_handle $dt_node int $core_clk_freq
}
