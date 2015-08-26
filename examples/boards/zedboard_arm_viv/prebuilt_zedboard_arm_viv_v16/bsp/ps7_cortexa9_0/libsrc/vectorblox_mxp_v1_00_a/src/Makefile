##############################################################################
## Description:       Microprocessor Driver Makefile
## (Based on version from Create and Import Peripheral Wizard)
##############################################################################

COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

INCLUDEFILES=*.h *.hpp
LIB_C_SOURCES=*.c
LIB_CXX_SOURCES=*.cpp
OUTS = *.o

libs:
	echo "Compiling vectorblox_mxp"
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS)  -DXILINX_STANDALONE_BSP=1 $(INCLUDES) $(LIB_C_SOURCES)
	$(COMPILER) -xc++ $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) -DXILINX_STANDALONE_BSP=1 $(INCLUDES) $(LIB_CXX_SOURCES)
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${OUTS}
	$(MAKE) clean

include:
	${CP} $(INCLUDEFILES) $(INCLUDEDIR)

clean:
	rm -rf ${OUTS}
