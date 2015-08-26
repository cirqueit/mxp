#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20 [get_ports CLOCK_50]
create_clock -period 20 [get_ports CLOCK2_50]
create_clock -period 20 [get_ports CLOCK3_50]
create_clock -period 10.416 CAMERA_PIXCLK
create_clock -period 100000 I2C_CCD_Config:u8|mI2C_CTRL_CLK
#create_clock -period 100000 vblox1:qsys_system|TERASIC_MULTI_TOUCH:multi_touch|i2c_touch_config:i2c_touch_config_inst|step_i2c_clk
#create_clock -period 100000 vblox1:qsys_system|TERASIC_MULTI_TOUCH:multi_touch|i2c_touch_config:i2c_touch_config_inst|step_i2c_clk_out

#Opencores unconstrained problem
create_clock -name altera_reserved_tck -period 100.000 [get_ports {altera_reserved_tck}]
set_false_path -from [get_clocks {altera_reserved_tck}] -to [get_clocks {altera_reserved_tck}]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks

# set core_clk    {qsys_system|altpll_0|sd1|pll7|clk[0]}
# set core_clk_2x {qsys_system|altpll_0|sd1|pll7|clk[1]}
# set sdram_clk   {qsys_system|altpll_0|sd1|pll7|clk[2]}
set clk_40   {qsys_system|altpll_0|sd1|pll7|clk[3]}
set clk_25   {qsys_system|altpll_xclk|sd1|pll7|clk[0]}

#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************
#set_output_delay -clock { qsys_system|altpll_0|sd1|pll7|clk[3] } -min 10 [get_ports  HC_DEN]
#set_output_delay -clock { qsys_system|altpll_0|sd1|pll7|clk[3] } -max 15 [get_ports  HC_DEN]
#set_output_delay -clock { qsys_system|altpll_0|sd1|pll7|clk[3] } -min 10 [get_ports {HC_R[*] HC_G[*] HC_B[*]}]
#set_output_delay -clock { qsys_system|altpll_0|sd1|pll7|clk[3] } -max 15 [get_ports {HC_R[*] HC_G[*] HC_B[*]}]
#set_output_delay -clock { qsys_system|altpll_0|sd1|pll7|clk[3] } -min  7.5 [get_ports {VGA_BLANK_N VGA_SYNC_N VGA_HS VGA_VS VGA_R[*] VGA_G[*] VGA_B[*]}]
#set_output_delay -clock { qsys_system|altpll_0|sd1|pll7|clk[3] } -max 17.5 [get_ports {VGA_BLANK_N VGA_SYNC_N VGA_HS VGA_VS VGA_R[*] VGA_G[*] VGA_B[*]}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks $clk_40]
set_clock_groups -asynchronous -group [get_clocks $clk_25]

#**************************************************************
# Set False Path
#**************************************************************
#set_false_path -to [get_keepers {*vbvip_planar2is:*|dcfifo:*}]
set_false_path -from {vblox1:qsys_system|vbvip_planar2is:*|WR_OVFLW}
set_false_path -from [get_keepers {*Reset_Delay:*|oRST*}]
set_false_path -to {vblox1:qsys_system|altera_reset_controller:rst_controller|altera_reset_synchronizer:alt_rst_sync_uq1|*}
#set_false_path -from {vblox1:qsys_system|altera_reset_controller:rst_controller|altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}
set_false_path -from {vblox1:qsys_system|altera_reset_controller:rst_controller*|altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out} -to {vblox1:qsys_system|vbvip_planar2is:*|*}
set_false_path -from vblox1:qsys_system|alt_vipitc120_IS2Vid:alt_vip_itc*|rst_vid_clk_reg

#Not sure what's going on in Nios here to make this necessary
set_false_path -from [get_keepers {vblox1:qsys_system|altera_reset_controller:rst_controller_001|altera_reset_synchronizer:alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}] -to [get_keepers {vblox1:qsys_system|vblox1_cpu:cpu|Mn_rot_step2*}]

#Resets to the vbvip_planar2is
set_false_path -from [get_registers {*reset_controller*r_sync_rst}] -to [get_registers {*vbvip_planar2is*VID_RST*}]
set_false_path -from [get_registers {*vbvip_planar2is*VID_RST*}] -to [get_keepers {*vbvip_planar2is*uFIFO*}]
#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



