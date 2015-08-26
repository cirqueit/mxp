
SRC_LIB:=libvbxsim_linux.a

ifdef ComSpec
SRC_LIB=libvbxsim_windows.a
endif
ifdef COMSPEC
SRC_LIB=libvbxsim_windows.a
endif
LIB = libvbxsim.a

.PHONY:$(LIB) clean
$(LIB):$(SRC_LIB)
	cp $^ $@
clean:
	rm $(LIB)
