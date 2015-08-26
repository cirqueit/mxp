
DEFAULT_CROSS_COMPILE := arm-altera-eabi-

ALT_INCLUDE_DIRS += $(dir $(lastword $(MAKEFILE_LIST)))
#THESE SHOULD BE PREDEFINED IN TOPLEVEL MAKEFILE
ALT_INCLUDE_DIRS += $(VBXAPI_DIR)
ALT_INCLUDE_DIRS += $(VBXWARE_DIR)

ALT_INCLUDE_DIRS += $(QUARTUS_ROOTDIR)/../embedded/ip/altera/hps/altera_hps/hwlib/include/
ALT_CFLAGS += -mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -DARM_ALT_STANDALONE -std=gnu99
ALT_CXXFLAGS += -std=gnu++11
AVOID_NIOS2_GCC3_OPTIONS := true

BSP_LINKER_SCRIPT := $(dir $(lastword $(MAKEFILE_LIST)))/link.ld

INCLUDE_VBXAPI := true

HWLIB_PATH = $(QUARTUS_ROOTDIR)/../embedded/ip/altera/hps/altera_hps/hwlib/src/hwmgr/
HWLIB_SRCS += $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/io.c)
HWLIB_SRCS += $(HWLIB_PATH)/alt_timers.c
HWLIB_SRCS += $(HWLIB_PATH)/alt_globaltmr.c
HWLIB_SRCS += $(HWLIB_PATH)/alt_cache.c
HWLIB_SRCS += $(HWLIB_PATH)/alt_mmu.c
HWLIB_SRCS += $(HWLIB_PATH)/alt_clock_manager.c
HWLIB_SRCS += $(HWLIB_PATH)/alt_watchdog.c

HPS=true
