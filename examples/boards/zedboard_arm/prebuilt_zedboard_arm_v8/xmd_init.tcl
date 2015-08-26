connect arm hw
rst -srst
fpga -f SDK/SDK_Export/hw/system.bit
source SDK/SDK_Export/hw/ps7_init.tcl
ps7_init
ps7_post_config
