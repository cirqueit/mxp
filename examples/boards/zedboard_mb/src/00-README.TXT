This directory contains the XPS project files for a VectorBlox MXP
demonstration system for ZedBoard.

In order to open this project in XPS, you will need to have the
parameterizable RTL version of the VectorBlox MXP core or a
Zynq fixed netlist version installed in the XPS search path.

To get started:

- Install the VectorBlox pcores, drivers, and sw_services directories
  as described in the Quickstart Guide.

- Run XPS and open the system.xmp file.

- If you have a parameterizable version of the VectorBlox MXP core, find the
  vectorblox_mxp instance in the system and configure it as follows:
  - Number of Vector Lanes: 2
  - Number of Memory Lanes: 2
  - Maximum Burst Size in Beats: 16
  - Scratchpad Size: 64 kBytes
  - Multiplier Granularity: Byte
  - All other parameters can be left at their default values.

- If you have fixed netlist version of the VectorBlox MXP core,
  there are no configurable options.

- Select Hardware -> Generate Bitstream.

To compile software for the system, you need to export an XML hardware
specification and generate a BSP.

Follow the procedure in the Quickstart guide.

To compile the test programs in ../../../software/bmark, you must update
../../../software/common/xil_vars.mk with the locations of
the BSP and the XML hardware specification.
