# Get directory where this file resides
MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

PROJ_ROOT ?= ../../../boards/zedboard_arm_viv/prebuilt_zedboard_arm_viv_v16/
CPU_TARGET := NIOS
ifneq ($(PROJ_ROOT),)
ifneq ("$(wildcard $(PROJ_ROOT)/bsp/bsp_vars.mk)","")
CPU_TARGET := XIL
else
BSP_ROOT_DIR=$(PROJ_ROOT)/bsp
endif
endif

ifeq ($(CPU_TARGET),XIL)
	include $(MAKEFILE_DIR)/Makefile.xil
else
	include $(MAKEFILE_DIR)/Makefile.nios
endif
