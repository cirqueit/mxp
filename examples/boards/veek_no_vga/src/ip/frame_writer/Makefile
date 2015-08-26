#Note, at this point this is just to do a quick compile and look at any warnings/errors
#The testbench has been removed and only the SOPC system builder is used

VERILOGS = $(wildcard *.v)

all : clean modelsim

modelsim : work/_vmake

#Just use one dependency for all compiled Verilog.  Good enough for Canada.
work/_vmake : $(VERILOGS)
	if [ ! -e work/_info ]; then vlib work; fi
	vlog -pedanticerrors $(VERILOGS)

clean :
	@rm -f *~
	@rm -f *.mti
	@rm -f schedule.*
	@rm -f vsim.wlf
	@rm -f wlft*
	@rm -f transcript
	@rm -rf work
	@rm -rf work_tb
	@echo Target cleaned.
