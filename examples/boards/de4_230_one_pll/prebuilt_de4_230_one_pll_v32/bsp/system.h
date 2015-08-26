/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'vblox1'
 * SOPC Builder design path: ../../../vblox1.sopcinfo
 *
 * Generated: Fri Jul 17 17:51:22 PDT 2015
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
#define ALT_CPU_BREAK_ADDR 0x41040820
#define ALT_CPU_CPU_FREQ 187963000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1f
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 4096
#define ALT_CPU_EXCEPTION_ADDR 0x00000020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 187963000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 1
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 8192
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1f
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x00000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x41040820
#define NIOS2_CPU_FREQ 187963000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1f
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 4096
#define NIOS2_EXCEPTION_ADDR 0x00000020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 1
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 8192
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1f
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x00000000


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_VECTORBLOX_NCS_SHIM_0(A,B) __builtin_custom_inii(ALT_CI_VECTORBLOX_NCS_SHIM_0_N,(A),(B))
#define ALT_CI_VECTORBLOX_NCS_SHIM_0_N 0x0
#define BURSTLENGTH_BYTES 2048
#define CORE_FREQ 187963000
#define MASK_PARTITIONS 1
#define MAX_MASKED_VECTOR_LENGTH 32768
#define MEMORY_WIDTH_LANES 32
#define MULFXP_BYTE_FRACTION_BITS 4
#define MULFXP_HALF_FRACTION_BITS 15
#define MULFXP_WORD_FRACTION_BITS 16
#define SCRATCHPAD_KB 64
#define VCUSTOM0_LANES 0
#define VCUSTOM10_LANES 0
#define VCUSTOM11_LANES 0
#define VCUSTOM12_LANES 0
#define VCUSTOM13_LANES 0
#define VCUSTOM14_LANES 0
#define VCUSTOM15_LANES 0
#define VCUSTOM1_LANES 0
#define VCUSTOM2_LANES 0
#define VCUSTOM3_LANES 0
#define VCUSTOM4_LANES 0
#define VCUSTOM5_LANES 0
#define VCUSTOM6_LANES 0
#define VCUSTOM7_LANES 0
#define VCUSTOM8_LANES 0
#define VCUSTOM9_LANES 0
#define VECTOR_CUSTOM_INSTRUCTIONS 0
#define VECTOR_LANES 32


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_TIMER
#define __ALTERA_MEM_IF_DDR2_EMIF
#define __ALTERA_NIOS2_QSYS
#define __VECTORBLOX_MXP


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Stratix IV"
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
#define ALT_STDERR_BASE 0x40000b00
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x40000b00
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x40000b00
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "vblox1"


/*
 * button configuration
 *
 */

#define ALT_MODULE_CLASS_button altera_avalon_pio
#define BUTTON_BASE 0x40000a00
#define BUTTON_BIT_CLEARING_EDGE_REGISTER 0
#define BUTTON_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUTTON_CAPTURE 0
#define BUTTON_DATA_WIDTH 4
#define BUTTON_DO_TEST_BENCH_WIRING 0
#define BUTTON_DRIVEN_SIM_VALUE 0
#define BUTTON_EDGE_TYPE "NONE"
#define BUTTON_FREQ 50000000
#define BUTTON_HAS_IN 1
#define BUTTON_HAS_OUT 0
#define BUTTON_HAS_TRI 0
#define BUTTON_IRQ -1
#define BUTTON_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BUTTON_IRQ_TYPE "NONE"
#define BUTTON_NAME "/dev/button"
#define BUTTON_RESET_VALUE 0
#define BUTTON_SPAN 512
#define BUTTON_TYPE "altera_avalon_pio"


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
#define JTAG_UART_BASE 0x40000b00
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 256
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * led configuration
 *
 */

#define ALT_MODULE_CLASS_led altera_avalon_pio
#define LED_BASE 0x40000900
#define LED_BIT_CLEARING_EDGE_REGISTER 0
#define LED_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_CAPTURE 0
#define LED_DATA_WIDTH 8
#define LED_DO_TEST_BENCH_WIRING 0
#define LED_DRIVEN_SIM_VALUE 0
#define LED_EDGE_TYPE "NONE"
#define LED_FREQ 50000000
#define LED_HAS_IN 0
#define LED_HAS_OUT 1
#define LED_HAS_TRI 0
#define LED_IRQ -1
#define LED_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LED_IRQ_TYPE "NONE"
#define LED_NAME "/dev/led"
#define LED_RESET_VALUE 0
#define LED_SPAN 512
#define LED_TYPE "altera_avalon_pio"


/*
 * mem_if_ddr2_emif_0 configuration
 *
 */

#define ALT_MODULE_CLASS_mem_if_ddr2_emif_0 altera_mem_if_ddr2_emif
#define MEM_IF_DDR2_EMIF_0_BASE 0x0
#define MEM_IF_DDR2_EMIF_0_IRQ -1
#define MEM_IF_DDR2_EMIF_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MEM_IF_DDR2_EMIF_0_NAME "/dev/mem_if_ddr2_emif_0"
#define MEM_IF_DDR2_EMIF_0_SPAN 1073741824
#define MEM_IF_DDR2_EMIF_0_TYPE "altera_mem_if_ddr2_emif"


/*
 * slide_switch configuration
 *
 */

#define ALT_MODULE_CLASS_slide_switch altera_avalon_pio
#define SLIDE_SWITCH_BASE 0x40000800
#define SLIDE_SWITCH_BIT_CLEARING_EDGE_REGISTER 0
#define SLIDE_SWITCH_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SLIDE_SWITCH_CAPTURE 0
#define SLIDE_SWITCH_DATA_WIDTH 4
#define SLIDE_SWITCH_DO_TEST_BENCH_WIRING 0
#define SLIDE_SWITCH_DRIVEN_SIM_VALUE 0
#define SLIDE_SWITCH_EDGE_TYPE "NONE"
#define SLIDE_SWITCH_FREQ 50000000
#define SLIDE_SWITCH_HAS_IN 1
#define SLIDE_SWITCH_HAS_OUT 0
#define SLIDE_SWITCH_HAS_TRI 0
#define SLIDE_SWITCH_IRQ -1
#define SLIDE_SWITCH_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SLIDE_SWITCH_IRQ_TYPE "NONE"
#define SLIDE_SWITCH_NAME "/dev/slide_switch"
#define SLIDE_SWITCH_RESET_VALUE 0
#define SLIDE_SWITCH_SPAN 512
#define SLIDE_SWITCH_TYPE "altera_avalon_pio"


/*
 * sys_clk_timer configuration
 *
 */

#define ALT_MODULE_CLASS_sys_clk_timer altera_avalon_timer
#define SYS_CLK_TIMER_ALWAYS_RUN 0
#define SYS_CLK_TIMER_BASE 0x40000500
#define SYS_CLK_TIMER_COUNTER_SIZE 32
#define SYS_CLK_TIMER_FIXED_PERIOD 0
#define SYS_CLK_TIMER_FREQ 50000000
#define SYS_CLK_TIMER_IRQ 4
#define SYS_CLK_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SYS_CLK_TIMER_LOAD_VALUE 499999
#define SYS_CLK_TIMER_MULT 0.0010
#define SYS_CLK_TIMER_NAME "/dev/sys_clk_timer"
#define SYS_CLK_TIMER_PERIOD 10
#define SYS_CLK_TIMER_PERIOD_UNITS "ms"
#define SYS_CLK_TIMER_RESET_OUTPUT 0
#define SYS_CLK_TIMER_SNAPSHOT 1
#define SYS_CLK_TIMER_SPAN 1024
#define SYS_CLK_TIMER_TICKS_PER_SEC 100.0
#define SYS_CLK_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define SYS_CLK_TIMER_TYPE "altera_avalon_timer"


/*
 * timestamp_timer configuration
 *
 */

#define ALT_MODULE_CLASS_timestamp_timer altera_avalon_timer
#define TIMESTAMP_TIMER_ALWAYS_RUN 0
#define TIMESTAMP_TIMER_BASE 0x40000600
#define TIMESTAMP_TIMER_COUNTER_SIZE 64
#define TIMESTAMP_TIMER_FIXED_PERIOD 0
#define TIMESTAMP_TIMER_FREQ 50000000
#define TIMESTAMP_TIMER_IRQ 1
#define TIMESTAMP_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMESTAMP_TIMER_LOAD_VALUE 49999
#define TIMESTAMP_TIMER_MULT 0.0010
#define TIMESTAMP_TIMER_NAME "/dev/timestamp_timer"
#define TIMESTAMP_TIMER_PERIOD 1
#define TIMESTAMP_TIMER_PERIOD_UNITS "ms"
#define TIMESTAMP_TIMER_RESET_OUTPUT 0
#define TIMESTAMP_TIMER_SNAPSHOT 1
#define TIMESTAMP_TIMER_SPAN 2048
#define TIMESTAMP_TIMER_TICKS_PER_SEC 1000.0
#define TIMESTAMP_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMESTAMP_TIMER_TYPE "altera_avalon_timer"


/*
 * vbx1 configuration
 *
 */

#define ALT_MODULE_CLASS_vbx1 vectorblox_mxp
#define VBX1_BASE 0x41000000
#define VBX1_BURSTLENGTH_BYTES 2048
#define VBX1_CORE_FREQ 187963000
#define VBX1_IRQ -1
#define VBX1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VBX1_MASK_PARTITIONS 1
#define VBX1_MAX_MASKED_VECTOR_LENGTH 32768
#define VBX1_MEMORY_WIDTH_LANES 32
#define VBX1_MULFXP_BYTE_FRACTION_BITS 4
#define VBX1_MULFXP_HALF_FRACTION_BITS 15
#define VBX1_MULFXP_WORD_FRACTION_BITS 16
#define VBX1_NAME "/dev/vbx1"
#define VBX1_SCRATCHPAD_KB 64
#define VBX1_SPAN 65536
#define VBX1_TYPE "vectorblox_mxp"
#define VBX1_VCUSTOM0_LANES 0
#define VBX1_VCUSTOM10_LANES 0
#define VBX1_VCUSTOM11_LANES 0
#define VBX1_VCUSTOM12_LANES 0
#define VBX1_VCUSTOM13_LANES 0
#define VBX1_VCUSTOM14_LANES 0
#define VBX1_VCUSTOM15_LANES 0
#define VBX1_VCUSTOM1_LANES 0
#define VBX1_VCUSTOM2_LANES 0
#define VBX1_VCUSTOM3_LANES 0
#define VBX1_VCUSTOM4_LANES 0
#define VBX1_VCUSTOM5_LANES 0
#define VBX1_VCUSTOM6_LANES 0
#define VBX1_VCUSTOM7_LANES 0
#define VBX1_VCUSTOM8_LANES 0
#define VBX1_VCUSTOM9_LANES 0
#define VBX1_VECTOR_CUSTOM_INSTRUCTIONS 0
#define VBX1_VECTOR_LANES 32

#endif /* __SYSTEM_H_ */
