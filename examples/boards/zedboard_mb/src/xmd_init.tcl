connect arm hw
stop
rst -srst
fpga -f SDK/SDK_Export/hw/download.bit
source SDK/SDK_Export/hw/ps7_init.tcl
ps7_init
ps7_post_config
