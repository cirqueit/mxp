This directory contains the design files necessary to recreate the
VectorBlox MXP demonstration system for the Terasic Veek evaluation kit.

The source code for the TERASIC_MULTI_TOUCH IP core is encrypted and requires
the license file license_multi_touch.dat that is included in this directory.
Add this file to your LM_LICENSE_FILE environment variable. (Use colons to
separate multiple entries in LM_LICENSE_FILE.)

It is assumed that the VectorBlox MXP distribution has been installed
in a location within the Qsys IP search path (e.g. in
$QUARTUS_ROOTDIR/../ip/vectorblox) and that the MXP license file has been
correctly installed.

If you have trouble loading this example design, it is recommended that
you first try copying this directory to a location outside of the IP
search path.

To get started:

- Run Qsys and open the vblox1.qsys file.
- Find the VectorBlox MXP instance and configure it as follows:
  - Number of Vector Lanes: 8
  - Number of Memory Lanes: 1
  - Maximum Burst Size in Beats: 8
  - Scratchpad Size: 64 kBytes
  - Multiplier Granularity: Byte
  - Runs synchronously to the Nios II core: Check.
  - All other parameters can be left at their default values.
- Click on the Generation tab.
- Set the options as follows:
  - Create simulation model: None
  - Create testbench Qsys sytem: None
  - Create HDL design files for synthesis: checked
  - Output Directory Path: a subdirectory called "vblox1"
- Click Generate.
- Exit Qsys.
- Run Quartus II.
- Open vblox1.qpf.
- Select Processing->Start Compilation.

Once you have a bitstream, make sure there are no timing violations.

Use the Quartus II Programmer GUI or the quartus_pgm command-line executable
to download the SOF to your board. If you have a full MXP license, the SOF
will be called vblox1.sof and you can download it with

    quartus_pgm -m JTAG -o P\;vblox1.sof

If you have an MXP evaluation license instead of a full license, the
SOF will be called vblox1_time_limited.sof, and the bitstream will
cease to work if you quit quartus_pgm. When you download the
time-limited SOF with

    quartus_pgm -m JTAG -o P\;vblox1_time_limited.sof

you will see a message such as:

File vblox1_time_limited.sof contains one or more time-limited
megafunctions that support the OpenCore Plus feature that will not
work after the hardware evaluation time expires. Refer to the Messages
window for evaluation time details.
Info (210040): SRAM Object File vblox1_time_limited.sof contains
time-limited megafunction that supports OpenCore Plus feature --
Vendor: 0x36F7, Product: 0x0001
[...]
Please enter i for info and q to quit:

In this case, do not quit quartus_pgm. Open a new Nios II command shell to
enter further commands.

---------------------------------------------------------------------------
To compile software for the system, you need to generate a BSP.

An sopcinfo file is required for BSP generation. This file is created when
you generate design files for synthesis in Qsys, but it can also be created
from the command-line:
  ip-generate --report-file=sopcinfo:vblox1.sopcinfo \
              --component-file=vblox1.qsys

The BSP can then be generated from the included settings.bsp file, which
references the sopcinfo file.

To generate the BSP, run:
  mkdir bsp
  nios2-bsp-generate-files --settings=settings.bsp --bsp-dir=bsp

To re-compile one of the test programs, you must tell make where the
BSP is located. e.g.
  cd ../../../software/bmark/vbw_mtx_sobel
  make BSP_ROOT_DIR=`pwd`/../../../boards/veek_no_vga/src/bsp
(Note that BSP_ROOT_DIR is specified as an absolute path; this ensures
that there won't be any problems if make is called recursively in other
directories.)

(Note: if you are using the Nios II Command Shell under Windows, you may need
to use this command for make:
  make BSP_ROOT_DIR=`cygpath -wa ../../../boards/veek_no_vga/src/bsp`
Cygpath converts between Cygwin Unix-style paths and Windows-style paths.)

Note:
- This system includes the vci_divide, vci_sqrt, and vci_particle_full custom
instructions.
- The vci_particle_full custom instruction requires an even number of logical
custom instruction lanes, so at least two MXP vector lanes are required.
