# Get directory where this file resides
MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(realpath $(MAKEFILE_DIR)/xil_vars.mk)

# Included lib public.mk files append to these vars, e.g.
# ALT_INCLUDE_DIRS = ../../lib/vbxtest
# ALT_LIBRARY_DIRS = ../../lib/vbxint ../../lib/vbxtest
# ALT_LIBRARY_NAMES = vbxint vbxtest
# ALT_LDDEPS = ../../lib/vbxint/libvbxint.a ../../lib/vbxtest/libvbxtest.a
# MAKEABLE_LIBRARY_ROOT_DIRS = ../../lib/vbxint ../../lib/vbxtest

INC_DIRS := $(ALT_INCLUDE_DIRS) $(BSP_INC_DIR) $(APP_INCLUDE_DIRS)
LIB_DIRS := $(ALT_LIBRARY_DIRS) $(BSP_LIB_DIR)

INC_DIR_FLAGS := $(addprefix -I,$(INC_DIRS))
LIB_DIR_FLAGS := $(addprefix -L,$(LIB_DIRS))

LIBS := $(addprefix -l, $(ALT_LIBRARY_NAMES)) $(LIBS)

ifndef ELF
ELF := test.elf
endif
ELFSIZE := $(ELF).size
ELFCHECK := $(ELF).elfcheck

###########################################################################

# All Target
all: libs $(ELF) secondary-outputs

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

.PHONY: print_vars
print_vars:
	@echo "ALT_LIBRARY_ROOT_DIR=$(ALT_LIBRARY_ROOT_DIR)"
	@echo "ALT_LIBRARY_DIRS=$(ALT_LIBRARY_DIRS)"
	@echo "ALT_LIBRARY_NAMES=$(ALT_LIBRARY_NAMES)"
	@echo "ALT_LDDEPS=$(ALT_LDDEPS)"
	@echo "MAKEABLE_LIBRARY_ROOT_DIRS=$(MAKEABLE_LIBRARY_ROOT_DIRS)"
	@echo "LIBS=$(LIBS)"
	@echo "INC_DIRS=$(INC_DIRS)"
	@echo "INC_DIR_FLAGS=$(INC_DIR_FLAGS)"
	@echo "LIB_DIRS=$(LIB_DIRS)"
	@echo "LIB_DIR_FLAGS=$(LIB_DIR_FLAGS)"
	@echo "LIB_TARGETS=$(LIB_TARGETS)"
	@echo "OBJS=$(OBJS)"
	@echo "C_DEPS=$(C_DEPS)"
	@echo "MAKEFILE_DIR=$(MAKEFILE_DIR)"
	@echo "HW_PLATFORM_XML=$(HW_PLATFORM_XML)"
	@echo "PROCESSOR_TYPE=$(PROCESSOR_TYPE)"
	@echo "PROCESSOR_INSTANCE=$(PROCESSOR_INSTANCE)"
	@echo "CPU_FLAGS=$(CPU_FLAGS)"

# ALT_LIBRARY_DIRS = ../../lib/vbxint ../../lib/vbxtest
# ALT_LIBRARY_NAMES = vbxint vbxtest
# ALT_LDDEPS = ../../lib/vbxint/libvbxint.a ../../lib/vbxtest/libvbxtest.a
# MAKEABLE_LIBRARY_ROOT_DIRS = ../../lib/vbxint ../../lib/vbxtest

vpath %.c $(sort $(dir $(C_SRCS)))
vpath %.cpp $(sort $(dir $(CXX_SRCS)))

$(OBJ_DIR)/%.o: %.c
	@echo Building file: $<
	@echo Invoking: gcc compiler
	@$(MKDIR) -p $(@D)
	$(CC) $(OPT_FLAGS) $(CC_FLAGS)  $(INC_DIR_FLAGS) $(CPU_FLAGS) -MD  -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '
$(OBJ_DIR)/%.o: %.cpp
	@echo Building file: $<
	@echo Invoking: gcc compiler
	@$(MKDIR) -p $(@D)
	$(CXX) $(OPT_FLAGS) $(CXX_FLAGS)  $(INC_DIR_FLAGS) $(CPU_FLAGS) \
	    -MD  -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '

$(ELF): $(OBJS) $(LD_SCRIPT) libs
	@echo Building target: $@
	@echo Invoking: gcc linker
	$(LD) $(LD_FLAGS) $(LIB_DIR_FLAGS) $(CPU_FLAGS) -o"$@" $(OBJS) $(LIBS)
	@echo Finished building target: $@
	@echo ' '

$(ELFSIZE): $(ELF)
	@echo Invoking: Print Size
	$(SZ) "$<" | tee "$@"
	@echo Finished building: $@
	@echo ' '

$(ELFCHECK): $(ELF)
	@echo Invoking: Xilinx ELF Check
	elfcheck "$<" -hw $(HW_PLATFORM_XML) -pe $(PROCESSOR_INSTANCE) | tee "$@"
	@echo Finished building: $@
	@echo ' '

# Load FPGA bitstream
.PHONY: pgm
ifeq ($(PROCESSOR_TYPE), microblaze)
# cd $(PROJ_ROOT) && $(MAKE) -f system.make download
# cd $(PROJ_ROOT) && impact -batch etc/download.cmd
pgm:
	cd $(PROJ_ROOT) && xmd -tcl xmd_init.tcl
else
pgm:
	cd $(PROJ_ROOT) && xmd -tcl xmd_init.tcl
endif

IP_ADDRESS=192.168.10.133
# Download ELF and execute
.PHONY: run
ifeq ($(OS_TARGET),LINUX)
run: $(ELF)
	scp $(ELF) "root@$(IP_ADDRESS):."  && ssh root@$(IP_ADDRESS) ./$(ELF)
else
ifeq ($(PROCESSOR_TYPE), microblaze)
run: $(ELF)
	xmd -tcl $(MAKEFILE_DIR)/xmd_mb.tcl
else
run: $(ELF)
	xmd -tcl $(MAKEFILE_DIR)/xmd_arm.tcl
endif
endif
# Other Targets
clean:
	-$(RM) $(OBJS) $(C_DEPS) $(ELFSIZE) $(ELFCHECK) $(ELF)
	-$(RM) $(OBJ_ROOT_DIR)
	-@echo ' '

# $(ELFCHECK) removed because elfcheck does not exist in Vivado > 2013.4
secondary-outputs: $(ELFSIZE)

.PHONY: all clean
.SECONDARY:

###########################################################################
LIB_TARGETS := $(patsubst %,%-recurs-make-lib,$(MAKEABLE_LIBRARY_ROOT_DIRS))

.PHONY : libs
libs : $(LIB_TARGETS)

ifneq ($(strip $(LIB_TARGETS)),)
$(LIB_TARGETS): %-recurs-make-lib:
	@echo Info: Building $*
	$(MAKE) --no-print-directory -C $* CPU_TARGET=XIL
endif

ifneq ($(strip $(APP_LDDEPS)),)
$(APP_LDDEPS): libs
	@true
endif

###########################################################################
LIB_CLEAN_TARGETS := $(patsubst %,%-recurs-make-clean-lib,$(MAKEABLE_LIBRARY_ROOT_DIRS))

.PHONY : clean_libs
clean_libs : $(LIB_CLEAN_TARGETS)

ifneq ($(strip $(LIB_CLEAN_TARGETS)),)
$(LIB_CLEAN_TARGETS): %-recurs-make-clean-lib:
	@echo Info: Cleaning $*
	$(MAKE) --no-print-directory -C $* CPU_TARGET=XIL clean
endif

###########################################################################
.PHONY : clean_all
clean_all : clean clean_libs

###########################################################################
