# +-----------------------------------
# |
# | Copyright (C) 2012-2015 VectorBlox Computing, Inc.
# |
# +-----------------------------------

if {[catch {package require -exact qsys 12.0}]} {
    if {[catch {package require -exact qsys 11.1}]} {
        package require -exact sopc 11.0
    }
}

set_module_property NAME vectorblox_ncs_shim
set_module_property VERSION 1.0
set_module_property DISPLAY_NAME "Custom Instruction Slave Shim"
set_module_property DESCRIPTION \
    [concat "Nios II Custom Instruction Slave Shim for connecting a " \
         "VectorBlox MXP core to a Nios II core. Connect the shim's " \
         "custom instruction slave interface to the custom instruction " \
         "master interface of a Nios II core, then connect the shim's " \
         "instruction conduit interface to the instruction conduit " \
         "interface of a VectorBlox MXP core."]
set_module_property INTERNAL false
set_module_property GROUP "VectorBlox Computing Inc."
set_module_property AUTHOR "VectorBlox Computing Inc."
set_module_property ICON_PATH vectorblox.png

# +-----------------------------------
# | documentation links
# |
add_documentation_link "Web Site" http://vectorblox.com
# |
# +-----------------------------------

add_fileset fileset_synth       QUARTUS_SYNTH fileset_synth_callback
add_fileset fileset_sim_verilog SIM_VERILOG   fileset_sim_verilog_callback
add_fileset fileset_sim_vhdl    SIM_VHDL      fileset_sim_vhdl_callback

set_fileset_property fileset_synth       TOP_LEVEL vectorblox_ncs_shim
set_fileset_property fileset_sim_verilog TOP_LEVEL vectorblox_ncs_shim
set_fileset_property fileset_sim_vhdl    TOP_LEVEL vectorblox_ncs_shim

###########################################################################
# Assumes all required VHDL source files are alreayd in tmp_output_dir.
proc ipfs_gen {entity_name fileset dest_subdir tmp_output_dir} {

    if {$fileset == "SIM_VERILOG"} {
        set lang VERILOG
        set ext vo
    } elseif {$fileset == "SIM_VHDL"} {
        set lang VHDL
        set ext vho
    }

    send_message Info "Generating $lang IP Functional Simulation model"

    set saved_wd [pwd]
    cd $tmp_output_dir

    set cmd [list quartus_map $entity_name \
                 --simgen \
                 --simgen_parameter=CBX_HDL_LANGUAGE=$lang]

    foreach f [glob *.vhd] {
        lappend cmd --source $f
    }
    puts $cmd
    eval exec $cmd

    # Expected name of generated .vo/.vho IPFS model.
    set ipfs_model $entity_name.$ext

    if {[file exists $tmp_output_dir/$ipfs_model]} {
        send_message Info "Generated simulation model $ipfs_model"
    }

    # Add the IPFS model to the fileset.
    add_fileset_file $dest_subdir/$ipfs_model $lang PATH \
        $tmp_output_dir/$ipfs_model

    cd $saved_wd
}

###########################################################################
proc fileset_synth_callback {entity_name} {
    common_add_files $entity_name QUARTUS_SYNTH
}

###########################################################################
proc fileset_sim_verilog_callback {entity_name} {
    common_add_files $entity_name SIM_VERILOG
}

###########################################################################
proc fileset_sim_vhdl_callback {entity_name} {
    common_add_files $entity_name SIM_VHDL
}

###########################################################################
proc common_add_files {entity_name fileset} {

    set tmp_output_dir [ add_fileset_file dummy.txt OTHER TEMP "" ]

    # Copy all files in Filelist to tmp output dir, where they can
    # be added to the fileset, or used for IPFS model generation.
    # Note that files have to be added to the simulation fileset in
    # dependency order for ModelSim compilation.
    set vhd_files [list]
    set f [open Filelist]
    while {[gets $f line] >= 0} {
        set line [string trim $line]
        if {[string index $line 0] != "#"} {
            lappend vhd_files $line
        }
    }
    close $f

    foreach f $vhd_files {
        file copy $f $tmp_output_dir
    }

    set ocp_files [glob -nocomplain *.ocp]
    foreach f $ocp_files {
        file copy $f $tmp_output_dir
    }

    # Files get copied to a subdirectory of synthesis/submodules or
    # simulation/submodules.
    set dest_subdir vbx/ncs_shim

    if {($fileset == "QUARTUS_SYNTH") || ($fileset == "SIM_VHDL")} {
        # Add VHDL sources
        foreach f $vhd_files {
            add_fileset_file $dest_subdir/$f VHDL PATH $tmp_output_dir/$f
        }
    } else {
        # Generate IPFS model for SIM_VERILOG.
        ipfs_gen $entity_name $fileset $dest_subdir $tmp_output_dir
    }

    if {$fileset == "QUARTUS_SYNTH"} {
        foreach f $ocp_files {
            add_fileset_file $dest_subdir/$f OTHER PATH $tmp_output_dir/$f
        }
    }
}

###########################################################################
# Nios II Custom Instruction Slave interface
add_interface ncs nios_custom_instruction slave
set_interface_property ncs clockCycle 0
set_interface_property ncs operands 2

set_interface_property ncs ENABLED true

add_interface_port ncs ncs_clk clk Input 1
add_interface_port ncs ncs_clk_en clk_en Input 1
add_interface_port ncs ncs_reset reset Input 1
add_interface_port ncs ncs_start start Input 1
add_interface_port ncs ncs_done done Output 1
add_interface_port ncs ncs_dataa dataa Input 32
add_interface_port ncs ncs_datab datab Input 32
add_interface_port ncs ncs_writerc writerc Input 1
add_interface_port ncs ncs_result result Output 32

###########################################################################
# VectorBlox MXP instruction interface conduit

add_interface instr_conduit conduit end

set_interface_property instr_conduit ENABLED true

add_interface_port instr_conduit coe_clk export Output 1
add_interface_port instr_conduit coe_clk_en export Output 1
add_interface_port instr_conduit coe_reset export Output 1
add_interface_port instr_conduit coe_start export Output 1
add_interface_port instr_conduit coe_done export Input 1
add_interface_port instr_conduit coe_dataa export Output 32
add_interface_port instr_conduit coe_datab export Output 32
add_interface_port instr_conduit coe_writerc export Output 1
add_interface_port instr_conduit coe_result export Input 32

###########################################################################
