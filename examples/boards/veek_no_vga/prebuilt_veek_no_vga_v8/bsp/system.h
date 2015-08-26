/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'vblox1'
 * SOPC Builder design path: ../../../vblox1.sopcinfo
 *
 * Generated: Fri Jul 17 11:46:55 PDT 2015
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x08080020
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1d
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 4096
#define ALT_CPU_EXCEPTION_ADDR 0x00000020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 8192
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1d
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x10000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x08080020
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1d
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 4096
#define NIOS2_EXCEPTION_ADDR 0x00000020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 8192
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1d
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x10000000


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_VECTORBLOX_NCS_SHIM_0(A,B) __builtin_custom_inii(ALT_CI_VECTORBLOX_NCS_SHIM_0_N,(A),(B))
#define ALT_CI_VECTORBLOX_NCS_SHIM_0_N 0x0
#define BURSTLENGTH_BYTES 128
#define CORE_FREQ 100000000
#define MASK_PARTITIONS 1
#define MAX_MASKED_VECTOR_LENGTH 8192
#define MEMORY_WIDTH_LANES 1
#define MULFXP_BYTE_FRACTION_BITS 4
#define MULFXP_HALF_FRACTION_BITS 15
#define MULFXP_WORD_FRACTION_BITS 16
#define SCRATCHPAD_KB 64
#define VCUSTOM0_LANES 2
#define VCUSTOM10_LANES 0
#define VCUSTOM11_LANES 0
#define VCUSTOM12_LANES 0
#define VCUSTOM13_LANES 0
#define VCUSTOM14_LANES 0
#define VCUSTOM15_LANES 0
#define VCUSTOM1_LANES 2
#define VCUSTOM2_LANES 0
#define VCUSTOM3_LANES 2
#define VCUSTOM4_LANES 0
#define VCUSTOM5_LANES 0
#define VCUSTOM6_LANES 0
#define VCUSTOM7_LANES 0
#define VCUSTOM8_LANES 0
#define VCUSTOM9_LANES 0
#define VECTOR_CUSTOM_INSTRUCTIONS 3
#define VECTOR_LANES 8


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_TIMER
#define __ALTERA_GENERIC_TRISTATE_CONTROLLER
#define __ALTERA_NIOS2_QSYS
#define __ALTPLL
#define __ALT_VIP_VFR
#define __AUDIO_AVALON_CONTROLLER
#define __FRAME_WRITER
#define __TERASIC_MULTI_TOUCH
#define __VECTORBLOX_MXP


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x10800160
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x10800160
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x10800160
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "vblox1"


/*
 * alt_vip_vfr_0 configuration
 *
 */

#define ALT_MODULE_CLASS_alt_vip_vfr_0 alt_vip_vfr
#define ALT_VIP_VFR_0_BASE 0x8080800
#define ALT_VIP_VFR_0_IRQ 6
#define ALT_VIP_VFR_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define ALT_VIP_VFR_0_NAME "/dev/alt_vip_vfr_0"
#define ALT_VIP_VFR_0_SPAN 128
#define ALT_VIP_VFR_0_TYPE "alt_vip_vfr"


/*
 * altpll_xclk configuration
 *
 */

#define ALTPLL_XCLK_BASE 0x10800180
#define ALTPLL_XCLK_IRQ -1
#define ALTPLL_XCLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ALTPLL_XCLK_NAME "/dev/altpll_xclk"
#define ALTPLL_XCLK_SPAN 16
#define ALTPLL_XCLK_TYPE "altpll"
#define ALT_MODULE_CLASS_altpll_xclk altpll


/*
 * audio_avalon_controller configuration
 *
 */

#define ALT_MODULE_CLASS_audio_avalon_controller audio_avalon_controller
#define AUDIO_AVALON_CONTROLLER_BASE 0x108000c0
#define AUDIO_AVALON_CONTROLLER_IRQ 5
#define AUDIO_AVALON_CONTROLLER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define AUDIO_AVALON_CONTROLLER_NAME "/dev/audio_avalon_controller"
#define AUDIO_AVALON_CONTROLLER_SPAN 32
#define AUDIO_AVALON_CONTROLLER_TYPE "audio_avalon_controller"


/*
 * av_i2c_clk_pio configuration
 *
 */

#define ALT_MODULE_CLASS_av_i2c_clk_pio altera_avalon_pio
#define AV_I2C_CLK_PIO_BASE 0x10800130
#define AV_I2C_CLK_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define AV_I2C_CLK_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AV_I2C_CLK_PIO_CAPTURE 0
#define AV_I2C_CLK_PIO_DATA_WIDTH 1
#define AV_I2C_CLK_PIO_DO_TEST_BENCH_WIRING 0
#define AV_I2C_CLK_PIO_DRIVEN_SIM_VALUE 0
#define AV_I2C_CLK_PIO_EDGE_TYPE "NONE"
#define AV_I2C_CLK_PIO_FREQ 40000000
#define AV_I2C_CLK_PIO_HAS_IN 0
#define AV_I2C_CLK_PIO_HAS_OUT 1
#define AV_I2C_CLK_PIO_HAS_TRI 0
#define AV_I2C_CLK_PIO_IRQ -1
#define AV_I2C_CLK_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AV_I2C_CLK_PIO_IRQ_TYPE "NONE"
#define AV_I2C_CLK_PIO_NAME "/dev/av_i2c_clk_pio"
#define AV_I2C_CLK_PIO_RESET_VALUE 0
#define AV_I2C_CLK_PIO_SPAN 16
#define AV_I2C_CLK_PIO_TYPE "altera_avalon_pio"


/*
 * av_i2c_data_pio configuration
 *
 */

#define ALT_MODULE_CLASS_av_i2c_data_pio altera_avalon_pio
#define AV_I2C_DATA_PIO_BASE 0x10800120
#define AV_I2C_DATA_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define AV_I2C_DATA_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AV_I2C_DATA_PIO_CAPTURE 0
#define AV_I2C_DATA_PIO_DATA_WIDTH 1
#define AV_I2C_DATA_PIO_DO_TEST_BENCH_WIRING 1
#define AV_I2C_DATA_PIO_DRIVEN_SIM_VALUE 0
#define AV_I2C_DATA_PIO_EDGE_TYPE "NONE"
#define AV_I2C_DATA_PIO_FREQ 40000000
#define AV_I2C_DATA_PIO_HAS_IN 0
#define AV_I2C_DATA_PIO_HAS_OUT 0
#define AV_I2C_DATA_PIO_HAS_TRI 1
#define AV_I2C_DATA_PIO_IRQ -1
#define AV_I2C_DATA_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AV_I2C_DATA_PIO_IRQ_TYPE "NONE"
#define AV_I2C_DATA_PIO_NAME "/dev/av_i2c_data_pio"
#define AV_I2C_DATA_PIO_RESET_VALUE 0
#define AV_I2C_DATA_PIO_SPAN 16
#define AV_I2C_DATA_PIO_TYPE "altera_avalon_pio"


/*
 * cfi_flash configuration
 *
 */

#define ALT_MODULE_CLASS_cfi_flash altera_generic_tristate_controller
#define CFI_FLASH_BASE 0x10000000
#define CFI_FLASH_HOLD_VALUE 60
#define CFI_FLASH_IRQ -1
#define CFI_FLASH_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CFI_FLASH_NAME "/dev/cfi_flash"
#define CFI_FLASH_SETUP_VALUE 60
#define CFI_FLASH_SIZE 8388608u
#define CFI_FLASH_SPAN 8388608
#define CFI_FLASH_TIMING_UNITS "ns"
#define CFI_FLASH_TYPE "altera_generic_tristate_controller"
#define CFI_FLASH_WAIT_VALUE 160


/*
 * frame_writer_0 configuration
 *
 */

#define ALT_MODULE_CLASS_frame_writer_0 frame_writer
#define FRAME_WRITER_0_BASE 0x8080880
#define FRAME_WRITER_0_IRQ 7
#define FRAME_WRITER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define FRAME_WRITER_0_NAME "/dev/frame_writer_0"
#define FRAME_WRITER_0_SPAN 16
#define FRAME_WRITER_0_TYPE "frame_writer"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK SYS_CLK_TIMER
#define ALT_TIMESTAMP_CLK TIMESTAMP_TIMER


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x10800160
#define JTAG_UART_IRQ 1
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 256
#define JTAG_UART_READ_THRESHOLD 4
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 256
#define JTAG_UART_WRITE_THRESHOLD 4


/*
 * led_pio configuration
 *
 */

#define ALT_MODULE_CLASS_led_pio altera_avalon_pio
#define LED_PIO_BASE 0x10800140
#define LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_PIO_CAPTURE 0
#define LED_PIO_DATA_WIDTH 8
#define LED_PIO_DO_TEST_BENCH_WIRING 0
#define LED_PIO_DRIVEN_SIM_VALUE 0
#define LED_PIO_EDGE_TYPE "NONE"
#define LED_PIO_FREQ 40000000
#define LED_PIO_HAS_IN 0
#define LED_PIO_HAS_OUT 1
#define LED_PIO_HAS_TRI 0
#define LED_PIO_IRQ -1
#define LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LED_PIO_IRQ_TYPE "NONE"
#define LED_PIO_NAME "/dev/led_pio"
#define LED_PIO_RESET_VALUE 0
#define LED_PIO_SPAN 16
#define LED_PIO_TYPE "altera_avalon_pio"


/*
 * multi_touch configuration
 *
 */

#define ALT_MODULE_CLASS_multi_touch TERASIC_MULTI_TOUCH
#define MULTI_TOUCH_BASE 0x10800000
#define MULTI_TOUCH_IRQ 2
#define MULTI_TOUCH_IRQ_INTERRUPT_CONTROLLER_ID 0
#define MULTI_TOUCH_NAME "/dev/multi_touch"
#define MULTI_TOUCH_SPAN 128
#define MULTI_TOUCH_TYPE "TERASIC_MULTI_TOUCH"


/*
 * sdram configuration
 *
 */

#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x0
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/sdram"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 32
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 1
#define SDRAM_SPAN 134217728
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * switch_pio configuration
 *
 */

#define ALT_MODULE_CLASS_switch_pio altera_avalon_pio
#define SWITCH_PIO_BASE 0x10800150
#define SWITCH_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define SWITCH_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SWITCH_PIO_CAPTURE 0
#define SWITCH_PIO_DATA_WIDTH 18
#define SWITCH_PIO_DO_TEST_BENCH_WIRING 1
#define SWITCH_PIO_DRIVEN_SIM_VALUE 179951
#define SWITCH_PIO_EDGE_TYPE "NONE"
#define SWITCH_PIO_FREQ 40000000
#define SWITCH_PIO_HAS_IN 1
#define SWITCH_PIO_HAS_OUT 0
#define SWITCH_PIO_HAS_TRI 0
#define SWITCH_PIO_IRQ -1
#define SWITCH_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SWITCH_PIO_IRQ_TYPE "NONE"
#define SWITCH_PIO_NAME "/dev/switch_pio"
#define SWITCH_PIO_RESET_VALUE 0
#define SWITCH_PIO_SPAN 16
#define SWITCH_PIO_TYPE "altera_avalon_pio"


/*
 * sys_clk_timer configuration
 *
 */

#define ALT_MODULE_CLASS_sys_clk_timer altera_avalon_timer
#define SYS_CLK_TIMER_ALWAYS_RUN 0
#define SYS_CLK_TIMER_BASE 0x108000e0
#define SYS_CLK_TIMER_COUNTER_SIZE 32
#define SYS_CLK_TIMER_FIXED_PERIOD 0
#define SYS_CLK_TIMER_FREQ 40000000
#define SYS_CLK_TIMER_IRQ 0
#define SYS_CLK_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SYS_CLK_TIMER_LOAD_VALUE 399999
#define SYS_CLK_TIMER_MULT 0.0010
#define SYS_CLK_TIMER_NAME "/dev/sys_clk_timer"
#define SYS_CLK_TIMER_PERIOD 10.0
#define SYS_CLK_TIMER_PERIOD_UNITS "ms"
#define SYS_CLK_TIMER_RESET_OUTPUT 0
#define SYS_CLK_TIMER_SNAPSHOT 1
#define SYS_CLK_TIMER_SPAN 32
#define SYS_CLK_TIMER_TICKS_PER_SEC 100.0
#define SYS_CLK_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define SYS_CLK_TIMER_TYPE "altera_avalon_timer"


/*
 * td_reset_pio configuration
 *
 */

#define ALT_MODULE_CLASS_td_reset_pio altera_avalon_pio
#define TD_RESET_PIO_BASE 0x10800110
#define TD_RESET_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define TD_RESET_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TD_RESET_PIO_CAPTURE 0
#define TD_RESET_PIO_DATA_WIDTH 1
#define TD_RESET_PIO_DO_TEST_BENCH_WIRING 0
#define TD_RESET_PIO_DRIVEN_SIM_VALUE 0
#define TD_RESET_PIO_EDGE_TYPE "NONE"
#define TD_RESET_PIO_FREQ 40000000
#define TD_RESET_PIO_HAS_IN 0
#define TD_RESET_PIO_HAS_OUT 1
#define TD_RESET_PIO_HAS_TRI 0
#define TD_RESET_PIO_IRQ -1
#define TD_RESET_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TD_RESET_PIO_IRQ_TYPE "NONE"
#define TD_RESET_PIO_NAME "/dev/td_reset_pio"
#define TD_RESET_PIO_RESET_VALUE 0
#define TD_RESET_PIO_SPAN 16
#define TD_RESET_PIO_TYPE "altera_avalon_pio"


/*
 * timestamp_timer configuration
 *
 */

#define ALT_MODULE_CLASS_timestamp_timer altera_avalon_timer
#define TIMESTAMP_TIMER_ALWAYS_RUN 0
#define TIMESTAMP_TIMER_BASE 0x10800080
#define TIMESTAMP_TIMER_COUNTER_SIZE 64
#define TIMESTAMP_TIMER_FIXED_PERIOD 0
#define TIMESTAMP_TIMER_FREQ 40000000
#define TIMESTAMP_TIMER_IRQ 8
#define TIMESTAMP_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMESTAMP_TIMER_LOAD_VALUE 39999
#define TIMESTAMP_TIMER_MULT 0.0010
#define TIMESTAMP_TIMER_NAME "/dev/timestamp_timer"
#define TIMESTAMP_TIMER_PERIOD 1
#define TIMESTAMP_TIMER_PERIOD_UNITS "ms"
#define TIMESTAMP_TIMER_RESET_OUTPUT 0
#define TIMESTAMP_TIMER_SNAPSHOT 1
#define TIMESTAMP_TIMER_SPAN 64
#define TIMESTAMP_TIMER_TICKS_PER_SEC 1000.0
#define TIMESTAMP_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMESTAMP_TIMER_TYPE "altera_avalon_timer"


/*
 * vbx1 configuration
 *
 */

#define ALT_MODULE_CLASS_vbx1 vectorblox_mxp
#define VBX1_BASE 0x8000000
#define VBX1_BURSTLENGTH_BYTES 128
#define VBX1_CORE_FREQ 100000000
#define VBX1_IRQ -1
#define VBX1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VBX1_MASK_PARTITIONS 1
#define VBX1_MAX_MASKED_VECTOR_LENGTH 8192
#define VBX1_MEMORY_WIDTH_LANES 1
#define VBX1_MULFXP_BYTE_FRACTION_BITS 4
#define VBX1_MULFXP_HALF_FRACTION_BITS 15
#define VBX1_MULFXP_WORD_FRACTION_BITS 16
#define VBX1_NAME "/dev/vbx1"
#define VBX1_SCRATCHPAD_KB 64
#define VBX1_SPAN 65536
#define VBX1_TYPE "vectorblox_mxp"
#define VBX1_VCUSTOM0_LANES 2
#define VBX1_VCUSTOM10_LANES 0
#define VBX1_VCUSTOM11_LANES 0
#define VBX1_VCUSTOM12_LANES 0
#define VBX1_VCUSTOM13_LANES 0
#define VBX1_VCUSTOM14_LANES 0
#define VBX1_VCUSTOM15_LANES 0
#define VBX1_VCUSTOM1_LANES 2
#define VBX1_VCUSTOM2_LANES 0
#define VBX1_VCUSTOM3_LANES 2
#define VBX1_VCUSTOM4_LANES 0
#define VBX1_VCUSTOM5_LANES 0
#define VBX1_VCUSTOM6_LANES 0
#define VBX1_VCUSTOM7_LANES 0
#define VBX1_VCUSTOM8_LANES 0
#define VBX1_VCUSTOM9_LANES 0
#define VBX1_VECTOR_CUSTOM_INSTRUCTIONS 3
#define VBX1_VECTOR_LANES 8

#endif /* __SYSTEM_H_ */
