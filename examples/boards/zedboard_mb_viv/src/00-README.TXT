This directory contains the Vivado project files for a VectorBlox MXP
demonstration system for ZedBoard.

To get started:

- With Vivado, open the project file project_1/project_1.xpr

- In the IP Integrator block diagram, find the vectorblox_mxp instance and
  configure it as follows:
  - Number of Vector Lanes: 2
  - Number of Memory Lanes: 2
  - Maximum Burst Size in Beats: 16
  - Scratchpad Size: 64 kBytes
  - Multiplier Granularity: Byte
  - All other parameters can be left at their default values.

- Generate Bitstream.

To compile software for the system, you need to export a hardware
specification and generate a BSP as described in the Quickstart Guide.

To compile the sample programs provided with this distribution, you must update
examples/software/common/xil_vars.mk with the location of the BSP .
