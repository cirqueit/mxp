----------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 13.0sp1
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2013 Altera Corporation.  All rights reserved.    
-- Your use of  Altera  Corporation's design tools,  logic functions and other 
-- software and tools,  and its AMPP  partner logic functions, and  any output 
-- files  any of the  foregoing  device programming or simulation files),  and 
-- any associated  documentation or information are expressly subject  to  the 
-- terms and conditions  of the Altera Program License Subscription Agreement, 
-- Altera  MegaCore  Function  License  Agreement, or other applicable license 
-- agreement,  including,  without limitation,  that your use  is for the sole 
-- purpose of  programming  logic  devices  manufactured by Altera and sold by 
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable 
-- agreement for further details.
----------------------------------------------------------------------------- 

-- VHDL created from Galaxy_dut_prim
-- VHDL created on Thu Sep 12 13:44:37 2013


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.hcc_package.all;
use work.math_package.all;
use work.fpc_library_package.all;
use work.dspba_library_package.all;
USE work.Galaxy_dut_safe_path.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

-- Text written from /build/swbuild/SJ/nightly/13.0sp1/232/l64/p4/ip/aion/src/mip_common/hw_model.cpp:1303
entity Galaxy_dut_prim is
    port (
        valid : in std_logic_vector(0 downto 0);
        channel : in std_logic_vector(7 downto 0);
        ref_px : in std_logic_vector(31 downto 0);
        px : in std_logic_vector(31 downto 0);
        ref_py : in std_logic_vector(31 downto 0);
        py : in std_logic_vector(31 downto 0);
        ref_gm : in std_logic_vector(31 downto 0);
        m : in std_logic_vector(31 downto 0);
        start : in std_logic_vector(0 downto 0);
        vout : out std_logic_vector(0 downto 0);
        cout : out std_logic_vector(7 downto 0);
        result_x : out std_logic_vector(31 downto 0);
        result_y : out std_logic_vector(31 downto 0);
        clk : in std_logic;
        areset : in std_logic
        );
end;

architecture normal of Galaxy_dut_prim is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name NOT_GATE_PUSH_BACK OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410";

    signal GND_q : std_logic_vector (0 downto 0);
    signal VCC_q : std_logic_vector (0 downto 0);
    signal Add_add_f_reset : std_logic;
    signal Add_add_f_add_sub : std_logic_vector (0 downto 0);
    signal Add_add_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Add_add_f_a_real : REAL;
    signal Add_add_f_b_real : REAL;
    signal Add_add_f_q_real : REAL;
    -- synopsys translate on
    signal Add_add_f_p : std_logic_vector (0 downto 0);
    signal Add_add_f_n : std_logic_vector (0 downto 0);
    signal Mult_f_reset : std_logic;
    signal Mult_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult_f_a_real : REAL;
    signal Mult_f_b_real : REAL;
    signal Mult_f_q_real : REAL;
    -- synopsys translate on
    signal Mult1_f_reset : std_logic;
    signal Mult1_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult1_f_a_real : REAL;
    signal Mult1_f_b_real : REAL;
    signal Mult1_f_q_real : REAL;
    -- synopsys translate on
    signal Mult2_f_reset : std_logic;
    signal Mult2_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult2_f_a_real : REAL;
    signal Mult2_f_b_real : REAL;
    signal Mult2_f_q_real : REAL;
    -- synopsys translate on
    signal Mult3_f_reset : std_logic;
    signal Mult3_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult3_f_a_real : REAL;
    signal Mult3_f_b_real : REAL;
    signal Mult3_f_q_real : REAL;
    -- synopsys translate on
    signal Mult4_f_reset : std_logic;
    signal Mult4_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult4_f_a_real : REAL;
    signal Mult4_f_b_real : REAL;
    signal Mult4_f_q_real : REAL;
    -- synopsys translate on
    signal Mult5_f_reset : std_logic;
    signal Mult5_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult5_f_a_real : REAL;
    signal Mult5_f_b_real : REAL;
    signal Mult5_f_q_real : REAL;
    -- synopsys translate on
    signal Mult6_f_reset : std_logic;
    signal Mult6_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult6_f_a_real : REAL;
    signal Mult6_f_b_real : REAL;
    signal Mult6_f_q_real : REAL;
    -- synopsys translate on
    signal Mult7_f_reset : std_logic;
    signal Mult7_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult7_f_a_real : REAL;
    signal Mult7_f_b_real : REAL;
    signal Mult7_f_q_real : REAL;
    -- synopsys translate on
    signal Sub_R_sub_f_reset : std_logic;
    signal Sub_R_sub_f_add_sub : std_logic_vector (0 downto 0);
    signal Sub_R_sub_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Sub_R_sub_f_a_real : REAL;
    signal Sub_R_sub_f_b_real : REAL;
    signal Sub_R_sub_f_q_real : REAL;
    -- synopsys translate on
    signal Sub_R_sub_f_p : std_logic_vector (0 downto 0);
    signal Sub_R_sub_f_n : std_logic_vector (0 downto 0);
    signal Sub1_R_sub_f_reset : std_logic;
    signal Sub1_R_sub_f_add_sub : std_logic_vector (0 downto 0);
    signal Sub1_R_sub_f_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Sub1_R_sub_f_a_real : REAL;
    signal Sub1_R_sub_f_b_real : REAL;
    signal Sub1_R_sub_f_q_real : REAL;
    -- synopsys translate on
    signal Sub1_R_sub_f_p : std_logic_vector (0 downto 0);
    signal Sub1_R_sub_f_n : std_logic_vector (0 downto 0);
    signal Acc_0_cast_reset : std_logic;
    signal Acc_0_cast_a : std_logic_vector (44 downto 0);
    signal Acc_0_cast_q : std_logic_vector (31 downto 0);
    -- synopsys translate off
    signal Acc_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Acc1_0_cast_reset : std_logic;
    signal Acc1_0_cast_a : std_logic_vector (44 downto 0);
    signal Acc1_0_cast_q : std_logic_vector (31 downto 0);
    -- synopsys translate off
    signal Acc1_0_cast_q_real : REAL;
    -- synopsys translate on
    signal RecipSqRt_0_cast_reset : std_logic;
    signal RecipSqRt_0_cast_a : std_logic_vector (44 downto 0);
    signal RecipSqRt_0_cast_q : std_logic_vector (31 downto 0);
    -- synopsys translate off
    signal RecipSqRt_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult_f_0_cast_reset : std_logic;
    signal Mult_f_0_cast_a : std_logic_vector (44 downto 0);
    signal Mult_f_0_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult_f_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult1_f_0_cast_reset : std_logic;
    signal Mult1_f_0_cast_a : std_logic_vector (44 downto 0);
    signal Mult1_f_0_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult1_f_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult3_f_0_cast_reset : std_logic;
    signal Mult3_f_0_cast_a : std_logic_vector (31 downto 0);
    signal Mult3_f_0_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult3_f_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult3_f_1_cast_reset : std_logic;
    signal Mult3_f_1_cast_a : std_logic_vector (44 downto 0);
    signal Mult3_f_1_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult3_f_1_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult4_f_1_cast_reset : std_logic;
    signal Mult4_f_1_cast_a : std_logic_vector (44 downto 0);
    signal Mult4_f_1_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult4_f_1_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult5_f_1_cast_reset : std_logic;
    signal Mult5_f_1_cast_a : std_logic_vector (44 downto 0);
    signal Mult5_f_1_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult5_f_1_cast_q_real : REAL;
    -- synopsys translate on
    signal Mult6_f_1_cast_reset : std_logic;
    signal Mult6_f_1_cast_a : std_logic_vector (44 downto 0);
    signal Mult6_f_1_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Mult6_f_1_cast_q_real : REAL;
    -- synopsys translate on
    signal Sub_R_sub_f_0_cast_reset : std_logic;
    signal Sub_R_sub_f_0_cast_a : std_logic_vector (31 downto 0);
    signal Sub_R_sub_f_0_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Sub_R_sub_f_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Sub_R_sub_f_1_cast_reset : std_logic;
    signal Sub_R_sub_f_1_cast_a : std_logic_vector (31 downto 0);
    signal Sub_R_sub_f_1_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Sub_R_sub_f_1_cast_q_real : REAL;
    -- synopsys translate on
    signal Sub1_R_sub_f_0_cast_reset : std_logic;
    signal Sub1_R_sub_f_0_cast_a : std_logic_vector (31 downto 0);
    signal Sub1_R_sub_f_0_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Sub1_R_sub_f_0_cast_q_real : REAL;
    -- synopsys translate on
    signal Sub1_R_sub_f_1_cast_reset : std_logic;
    signal Sub1_R_sub_f_1_cast_a : std_logic_vector (31 downto 0);
    signal Sub1_R_sub_f_1_cast_q : std_logic_vector (44 downto 0);
    -- synopsys translate off
    signal Sub1_R_sub_f_1_cast_q_real : REAL;
    -- synopsys translate on
    signal expLTLSBA_uid69_Acc_q : std_logic_vector (7 downto 0);
    signal expGTMaxMSBX_uid71_Acc_q : std_logic_vector (7 downto 0);
    signal rShiftConstant_uid73_Acc_q : std_logic_vector (8 downto 0);
    signal padConst_uid75_Acc_q : std_logic_vector (37 downto 0);
    signal accumulator_uid82_Acc_a : std_logic_vector(50 downto 0);
    signal accumulator_uid82_Acc_b : std_logic_vector(50 downto 0);
    signal accumulator_uid82_Acc_i : std_logic_vector (50 downto 0);
    signal accumulator_uid82_Acc_o : std_logic_vector (50 downto 0);
    signal accumulator_uid82_Acc_cin : std_logic_vector (0 downto 0);
    signal accumulator_uid82_Acc_c : std_logic_vector (0 downto 0);
    signal accumulator_uid82_Acc_q : std_logic_vector (48 downto 0);
    signal ShiftedOutComparator_uid95_Acc_q : std_logic_vector (5 downto 0);
    signal expRBias_uid98_Acc_q : std_logic_vector (8 downto 0);
    signal zeroExponent_uid99_Acc_q : std_logic_vector (7 downto 0);
    signal accumulator_uid138_Acc1_a : std_logic_vector(50 downto 0);
    signal accumulator_uid138_Acc1_b : std_logic_vector(50 downto 0);
    signal accumulator_uid138_Acc1_i : std_logic_vector (50 downto 0);
    signal accumulator_uid138_Acc1_o : std_logic_vector (50 downto 0);
    signal accumulator_uid138_Acc1_cin : std_logic_vector (0 downto 0);
    signal accumulator_uid138_Acc1_c : std_logic_vector (0 downto 0);
    signal accumulator_uid138_Acc1_q : std_logic_vector (48 downto 0);
    signal maxCount_uid182_Convert_q : std_logic_vector (5 downto 0);
    signal inIsZero_uid183_Convert_a : std_logic_vector(5 downto 0);
    signal inIsZero_uid183_Convert_b : std_logic_vector(5 downto 0);
    signal inIsZero_uid183_Convert_q_i : std_logic_vector(0 downto 0);
    signal inIsZero_uid183_Convert_q : std_logic_vector(0 downto 0);
    signal msbIn_uid184_Convert_q : std_logic_vector (7 downto 0);
    signal expInf_uid192_Convert_q : std_logic_vector (7 downto 0);
    signal fracZ_uid195_Convert_q : std_logic_vector (22 downto 0);
    signal inIsZero_uid213_Convert1_a : std_logic_vector(5 downto 0);
    signal inIsZero_uid213_Convert1_b : std_logic_vector(5 downto 0);
    signal inIsZero_uid213_Convert1_q_i : std_logic_vector(0 downto 0);
    signal inIsZero_uid213_Convert1_q : std_logic_vector(0 downto 0);
    signal inIsZero_uid243_Convert2_a : std_logic_vector(5 downto 0);
    signal inIsZero_uid243_Convert2_b : std_logic_vector(5 downto 0);
    signal inIsZero_uid243_Convert2_q_i : std_logic_vector(0 downto 0);
    signal inIsZero_uid243_Convert2_q : std_logic_vector(0 downto 0);
    signal inIsZero_uid273_Convert3_a : std_logic_vector(5 downto 0);
    signal inIsZero_uid273_Convert3_b : std_logic_vector(5 downto 0);
    signal inIsZero_uid273_Convert3_q_i : std_logic_vector(0 downto 0);
    signal inIsZero_uid273_Convert3_q : std_logic_vector(0 downto 0);
    signal inIsZero_uid303_Convert4_a : std_logic_vector(5 downto 0);
    signal inIsZero_uid303_Convert4_b : std_logic_vector(5 downto 0);
    signal inIsZero_uid303_Convert4_q_i : std_logic_vector(0 downto 0);
    signal inIsZero_uid303_Convert4_q : std_logic_vector(0 downto 0);
    signal inIsZero_uid333_Convert5_a : std_logic_vector(5 downto 0);
    signal inIsZero_uid333_Convert5_b : std_logic_vector(5 downto 0);
    signal inIsZero_uid333_Convert5_q_i : std_logic_vector(0 downto 0);
    signal inIsZero_uid333_Convert5_q : std_logic_vector(0 downto 0);
    signal ovf_uid364_Convert7_a : std_logic_vector(10 downto 0);
    signal ovf_uid364_Convert7_b : std_logic_vector(10 downto 0);
    signal ovf_uid364_Convert7_o : std_logic_vector (10 downto 0);
    signal ovf_uid364_Convert7_cin : std_logic_vector (0 downto 0);
    signal ovf_uid364_Convert7_n : std_logic_vector (0 downto 0);
    signal udfExpVal_uid365_Convert7_q : std_logic_vector (7 downto 0);
    signal udf_uid366_Convert7_a : std_logic_vector(10 downto 0);
    signal udf_uid366_Convert7_b : std_logic_vector(10 downto 0);
    signal udf_uid366_Convert7_o : std_logic_vector (10 downto 0);
    signal udf_uid366_Convert7_cin : std_logic_vector (0 downto 0);
    signal udf_uid366_Convert7_n : std_logic_vector (0 downto 0);
    signal ovfExpVal_uid367_Convert7_q : std_logic_vector (7 downto 0);
    signal d0_uid376_Convert7_q : std_logic_vector (2 downto 0);
    signal maxPosValueS_uid382_Convert7_q : std_logic_vector (31 downto 0);
    signal maxNegValueS_uid383_Convert7_q : std_logic_vector (31 downto 0);
    signal maxNegValueU_uid387_Convert7_q : std_logic_vector (31 downto 0);
    signal ovf_uid397_Convert8_a : std_logic_vector(10 downto 0);
    signal ovf_uid397_Convert8_b : std_logic_vector(10 downto 0);
    signal ovf_uid397_Convert8_o : std_logic_vector (10 downto 0);
    signal ovf_uid397_Convert8_cin : std_logic_vector (0 downto 0);
    signal ovf_uid397_Convert8_n : std_logic_vector (0 downto 0);
    signal udf_uid399_Convert8_a : std_logic_vector(10 downto 0);
    signal udf_uid399_Convert8_b : std_logic_vector(10 downto 0);
    signal udf_uid399_Convert8_o : std_logic_vector (10 downto 0);
    signal udf_uid399_Convert8_cin : std_logic_vector (0 downto 0);
    signal udf_uid399_Convert8_n : std_logic_vector (0 downto 0);
    signal cstNaNWF_uid425_RecipSqRt_q : std_logic_vector (22 downto 0);
    signal cst3BiasM1o2M1_uid427_RecipSqRt_q : std_logic_vector (7 downto 0);
    signal cst3BiasP1o2M1_uid428_RecipSqRt_q : std_logic_vector (7 downto 0);
    signal wIntCst_uid473_alignmentShifter_uid75_Acc_q : std_logic_vector (5 downto 0);
    signal rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q : std_logic_vector (15 downto 0);
    signal rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q : std_logic_vector (47 downto 0);
    signal rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q : std_logic_vector (3 downto 0);
    signal rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q : std_logic_vector (11 downto 0);
    signal rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q : std_logic_vector (1 downto 0);
    signal rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q : std_logic_vector (2 downto 0);
    signal zeroOutCst_uid508_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal mO_uid514_zeroCounter_uid94_Acc_q : std_logic_vector (17 downto 0);
    signal vCount_uid539_zeroCounter_uid94_Acc_a : std_logic_vector(1 downto 0);
    signal vCount_uid539_zeroCounter_uid94_Acc_b : std_logic_vector(1 downto 0);
    signal vCount_uid539_zeroCounter_uid94_Acc_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid539_zeroCounter_uid94_Acc_q : std_logic_vector(0 downto 0);
    signal vCount_uid648_zeroCounter_uid150_Acc1_a : std_logic_vector(1 downto 0);
    signal vCount_uid648_zeroCounter_uid150_Acc1_b : std_logic_vector(1 downto 0);
    signal vCount_uid648_zeroCounter_uid150_Acc1_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid648_zeroCounter_uid150_Acc1_q : std_logic_vector(0 downto 0);
    signal vCount_uid697_lzcShifterZ1_uid181_Convert_a : std_logic_vector(15 downto 0);
    signal vCount_uid697_lzcShifterZ1_uid181_Convert_b : std_logic_vector(15 downto 0);
    signal vCount_uid697_lzcShifterZ1_uid181_Convert_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid697_lzcShifterZ1_uid181_Convert_q : std_logic_vector(0 downto 0);
    signal vCount_uid744_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(15 downto 0);
    signal vCount_uid744_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(15 downto 0);
    signal vCount_uid744_lzcShifterZ1_uid211_Convert1_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid744_lzcShifterZ1_uid211_Convert1_q : std_logic_vector(0 downto 0);
    signal vCount_uid791_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(15 downto 0);
    signal vCount_uid791_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(15 downto 0);
    signal vCount_uid791_lzcShifterZ1_uid241_Convert2_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid791_lzcShifterZ1_uid241_Convert2_q : std_logic_vector(0 downto 0);
    signal vCount_uid838_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(15 downto 0);
    signal vCount_uid838_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(15 downto 0);
    signal vCount_uid838_lzcShifterZ1_uid271_Convert3_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid838_lzcShifterZ1_uid271_Convert3_q : std_logic_vector(0 downto 0);
    signal vCount_uid885_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(15 downto 0);
    signal vCount_uid885_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(15 downto 0);
    signal vCount_uid885_lzcShifterZ1_uid301_Convert4_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid885_lzcShifterZ1_uid301_Convert4_q : std_logic_vector(0 downto 0);
    signal vCount_uid932_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(15 downto 0);
    signal vCount_uid932_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(15 downto 0);
    signal vCount_uid932_lzcShifterZ1_uid331_Convert5_q_i : std_logic_vector(0 downto 0);
    signal vCount_uid932_lzcShifterZ1_uid331_Convert5_q : std_logic_vector(0 downto 0);
    signal rightShiftStage0Idx3_uid981_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(32 downto 0);
    signal rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(32 downto 0);
    signal rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(32 downto 0);
    signal rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(32 downto 0);
    signal rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(11 downto 0);
    signal rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(11 downto 0);
    signal rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(11 downto 0);
    signal rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(11 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(2 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(2 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_q_i : std_logic_vector(2 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(2 downto 0);
    signal rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(32 downto 0);
    signal rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(32 downto 0);
    signal rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(32 downto 0);
    signal rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(32 downto 0);
    signal rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(3 downto 0);
    signal rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(7 downto 0);
    signal rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(11 downto 0);
    signal rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(11 downto 0);
    signal rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(11 downto 0);
    signal rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(11 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(0 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(1 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(2 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(2 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_q_i : std_logic_vector(2 downto 0);
    signal rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(2 downto 0);
    signal prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_a : std_logic_vector (12 downto 0);
    signal prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_b : std_logic_vector (11 downto 0);
    signal prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_s1 : std_logic_vector (24 downto 0);
    signal prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_reset : std_logic;
    signal prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_q : std_logic_vector (23 downto 0);
    signal prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a : std_logic_vector (15 downto 0);
    signal prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_b : std_logic_vector (22 downto 0);
    signal prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_s1 : std_logic_vector (38 downto 0);
    signal prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_reset : std_logic;
    signal prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_q : std_logic_vector (37 downto 0);
    signal memoryC0_uid1056_invSqrtTabGen_lutmem_reset0 : std_logic;
    signal memoryC0_uid1056_invSqrtTabGen_lutmem_ia : std_logic_vector (29 downto 0);
    signal memoryC0_uid1056_invSqrtTabGen_lutmem_aa : std_logic_vector (8 downto 0);
    signal memoryC0_uid1056_invSqrtTabGen_lutmem_ab : std_logic_vector (8 downto 0);
    signal memoryC0_uid1056_invSqrtTabGen_lutmem_iq : std_logic_vector (29 downto 0);
    signal memoryC0_uid1056_invSqrtTabGen_lutmem_q : std_logic_vector (29 downto 0);
    signal memoryC1_uid1057_invSqrtTabGen_lutmem_reset0 : std_logic;
    signal memoryC1_uid1057_invSqrtTabGen_lutmem_ia : std_logic_vector (20 downto 0);
    signal memoryC1_uid1057_invSqrtTabGen_lutmem_aa : std_logic_vector (8 downto 0);
    signal memoryC1_uid1057_invSqrtTabGen_lutmem_ab : std_logic_vector (8 downto 0);
    signal memoryC1_uid1057_invSqrtTabGen_lutmem_iq : std_logic_vector (20 downto 0);
    signal memoryC1_uid1057_invSqrtTabGen_lutmem_q : std_logic_vector (20 downto 0);
    signal memoryC2_uid1058_invSqrtTabGen_lutmem_reset0 : std_logic;
    signal memoryC2_uid1058_invSqrtTabGen_lutmem_ia : std_logic_vector (11 downto 0);
    signal memoryC2_uid1058_invSqrtTabGen_lutmem_aa : std_logic_vector (8 downto 0);
    signal memoryC2_uid1058_invSqrtTabGen_lutmem_ab : std_logic_vector (8 downto 0);
    signal memoryC2_uid1058_invSqrtTabGen_lutmem_iq : std_logic_vector (11 downto 0);
    signal memoryC2_uid1058_invSqrtTabGen_lutmem_q : std_logic_vector (11 downto 0);
    signal reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2_q : std_logic_vector (31 downto 0);
    signal reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3_q : std_logic_vector (31 downto 0);
    signal reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1_q : std_logic_vector (5 downto 0);
    signal reg_fracRnd_uid186_Convert_0_to_expFracRnd_uid187_uid187_Convert_0_q : std_logic_vector (23 downto 0);
    signal reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q : std_logic_vector (9 downto 0);
    signal reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2_q : std_logic_vector (22 downto 0);
    signal reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2_q : std_logic_vector (7 downto 0);
    signal reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2_q : std_logic_vector (31 downto 0);
    signal reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3_q : std_logic_vector (31 downto 0);
    signal reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1_q : std_logic_vector (5 downto 0);
    signal reg_fracRnd_uid216_Convert1_0_to_expFracRnd_uid217_uid217_Convert1_0_q : std_logic_vector (23 downto 0);
    signal reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q : std_logic_vector (9 downto 0);
    signal reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2_q : std_logic_vector (22 downto 0);
    signal reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2_q : std_logic_vector (7 downto 0);
    signal reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2_q : std_logic_vector (31 downto 0);
    signal reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3_q : std_logic_vector (31 downto 0);
    signal reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1_q : std_logic_vector (5 downto 0);
    signal reg_fracRnd_uid246_Convert2_0_to_expFracRnd_uid247_uid247_Convert2_0_q : std_logic_vector (23 downto 0);
    signal reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q : std_logic_vector (9 downto 0);
    signal reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2_q : std_logic_vector (22 downto 0);
    signal reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2_q : std_logic_vector (7 downto 0);
    signal reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2_q : std_logic_vector (31 downto 0);
    signal reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3_q : std_logic_vector (31 downto 0);
    signal reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1_q : std_logic_vector (5 downto 0);
    signal reg_fracRnd_uid276_Convert3_0_to_expFracRnd_uid277_uid277_Convert3_0_q : std_logic_vector (23 downto 0);
    signal reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q : std_logic_vector (9 downto 0);
    signal reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2_q : std_logic_vector (22 downto 0);
    signal reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2_q : std_logic_vector (7 downto 0);
    signal reg_yT1_uid1059_invSqrtPolyEval_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_0_q : std_logic_vector (11 downto 0);
    signal reg_memoryC2_uid1058_invSqrtTabGen_lutmem_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_1_q : std_logic_vector (11 downto 0);
    signal reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q : std_logic_vector (14 downto 0);
    signal reg_s1_uid1061_uid1064_invSqrtPolyEval_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_1_q : std_logic_vector (22 downto 0);
    signal reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2_q : std_logic_vector (31 downto 0);
    signal reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3_q : std_logic_vector (31 downto 0);
    signal reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1_q : std_logic_vector (5 downto 0);
    signal reg_fracRnd_uid306_Convert4_0_to_expFracRnd_uid307_uid307_Convert4_0_q : std_logic_vector (23 downto 0);
    signal reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q : std_logic_vector (9 downto 0);
    signal reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2_q : std_logic_vector (22 downto 0);
    signal reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2_q : std_logic_vector (7 downto 0);
    signal reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2_q : std_logic_vector (31 downto 0);
    signal reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3_q : std_logic_vector (31 downto 0);
    signal reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1_q : std_logic_vector (5 downto 0);
    signal reg_fracRnd_uid336_Convert5_0_to_expFracRnd_uid337_uid337_Convert5_0_q : std_logic_vector (23 downto 0);
    signal reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q : std_logic_vector (9 downto 0);
    signal reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2_q : std_logic_vector (22 downto 0);
    signal reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2_q : std_logic_vector (7 downto 0);
    signal reg_extendedAlignedShiftedFrac_uid79_Acc_0_to_onesComplementExtendedFrac_uid80_Acc_1_q : std_logic_vector (38 downto 0);
    signal reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1_q : std_logic_vector (15 downto 0);
    signal reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3_q : std_logic_vector (15 downto 0);
    signal reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2_q : std_logic_vector (1 downto 0);
    signal reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3_q : std_logic_vector (1 downto 0);
    signal reg_vCount_uid533_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_2_q : std_logic_vector (0 downto 0);
    signal reg_vCount_uid527_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_3_q : std_logic_vector (0 downto 0);
    signal reg_vCount_uid521_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_4_q : std_logic_vector (0 downto 0);
    signal reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_q : std_logic_vector (0 downto 0);
    signal reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q : std_logic_vector (47 downto 0);
    signal reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3_q : std_logic_vector (47 downto 0);
    signal reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4_q : std_logic_vector (47 downto 0);
    signal reg_rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_1_q : std_logic_vector (1 downto 0);
    signal reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2_q : std_logic_vector (32 downto 0);
    signal reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3_q : std_logic_vector (32 downto 0);
    signal reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4_q : std_logic_vector (32 downto 0);
    signal reg_rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_1_q : std_logic_vector (1 downto 0);
    signal reg_rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_1_q : std_logic_vector (1 downto 0);
    signal reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2_q : std_logic_vector (0 downto 0);
    signal reg_sPostRndFullMSBU_uid380_Convert7_0_to_rndOvf_uid381_Convert7_1_q : std_logic_vector (0 downto 0);
    signal reg_sPostRndFullMSBU_uid379_Convert7_0_to_rndOvf_uid381_Convert7_2_q : std_logic_vector (0 downto 0);
    signal reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2_q : std_logic_vector (31 downto 0);
    signal reg_extendedAlignedShiftedFrac_uid135_Acc1_0_to_onesComplementExtendedFrac_uid136_Acc1_1_q : std_logic_vector (38 downto 0);
    signal reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1_q : std_logic_vector (15 downto 0);
    signal reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3_q : std_logic_vector (15 downto 0);
    signal reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2_q : std_logic_vector (1 downto 0);
    signal reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3_q : std_logic_vector (1 downto 0);
    signal reg_vCount_uid642_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_2_q : std_logic_vector (0 downto 0);
    signal reg_vCount_uid636_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_3_q : std_logic_vector (0 downto 0);
    signal reg_vCount_uid630_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_4_q : std_logic_vector (0 downto 0);
    signal reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q : std_logic_vector (0 downto 0);
    signal reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q : std_logic_vector (47 downto 0);
    signal reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3_q : std_logic_vector (47 downto 0);
    signal reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4_q : std_logic_vector (47 downto 0);
    signal reg_rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_1_q : std_logic_vector (1 downto 0);
    signal reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2_q : std_logic_vector (32 downto 0);
    signal reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3_q : std_logic_vector (32 downto 0);
    signal reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4_q : std_logic_vector (32 downto 0);
    signal reg_rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_1_q : std_logic_vector (1 downto 0);
    signal reg_rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_1_q : std_logic_vector (1 downto 0);
    signal reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2_q : std_logic_vector (0 downto 0);
    signal reg_sPostRndFullMSBU_uid413_Convert8_0_to_rndOvf_uid414_Convert8_1_q : std_logic_vector (0 downto 0);
    signal reg_sPostRndFullMSBU_uid412_Convert8_0_to_rndOvf_uid414_Convert8_2_q : std_logic_vector (0 downto 0);
    signal reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2_q : std_logic_vector (31 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_q : std_logic_vector (0 downto 0);
    signal ld_accumulatorSign_uid86_Acc_b_to_R_uid104_Acc_c_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_q : std_logic_vector (0 downto 0);
    signal ld_muxXOverflowFeedbackSignal_uid108_Acc_q_to_oRXOverflowFlagFeedback_uid109_Acc_a_q : std_logic_vector (0 downto 0);
    signal ld_muxXUnderflowFeedbackSignal_uid112_Acc_q_to_oRXUnderflowFlagFeedback_uid113_Acc_a_q : std_logic_vector (0 downto 0);
    signal ld_muxAccOverflowFeedbackSignal_uid116_Acc_q_to_oRAccOverflowFlagFeedback_uid117_Acc_a_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b_q : std_logic_vector (0 downto 0);
    signal ld_accumulatorSign_uid142_Acc1_b_to_R_uid160_Acc1_c_q : std_logic_vector (0 downto 0);
    signal ld_muxXOverflowFeedbackSignal_uid164_Acc1_q_to_oRXOverflowFlagFeedback_uid165_Acc1_a_q : std_logic_vector (0 downto 0);
    signal ld_muxXUnderflowFeedbackSignal_uid168_Acc1_q_to_oRXUnderflowFlagFeedback_uid169_Acc1_a_q : std_logic_vector (0 downto 0);
    signal ld_muxAccOverflowFeedbackSignal_uid172_Acc1_q_to_oRAccOverflowFlagFeedback_uid173_Acc1_a_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid177_Convert_b_to_outRes_uid204_Convert_c_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid207_Convert1_b_to_outRes_uid234_Convert1_c_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid237_Convert2_b_to_outRes_uid264_Convert2_c_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid267_Convert3_b_to_outRes_uid294_Convert3_c_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid297_Convert4_b_to_outRes_uid324_Convert4_c_q : std_logic_vector (0 downto 0);
    signal ld_signX_uid327_Convert5_b_to_outRes_uid354_Convert5_c_q : std_logic_vector (0 downto 0);
    signal ld_ovf_uid364_Convert7_n_to_ovfPostRnd_uid384_Convert7_a_q : std_logic_vector (0 downto 0);
    signal ld_udf_uid366_Convert7_n_to_muxSelConc_uid385_Convert7_b_q : std_logic_vector (0 downto 0);
    signal ld_reg_signX_uid362_Convert7_0_to_muxSelConc_uid385_Convert7_2_q_to_muxSelConc_uid385_Convert7_c_q : std_logic_vector (0 downto 0);
    signal ld_ovf_uid397_Convert8_n_to_ovfPostRnd_uid417_Convert8_a_q : std_logic_vector (0 downto 0);
    signal ld_udf_uid399_Convert8_n_to_muxSelConc_uid418_Convert8_b_q : std_logic_vector (0 downto 0);
    signal ld_reg_signX_uid395_Convert8_0_to_muxSelConc_uid418_Convert8_2_q_to_muxSelConc_uid418_Convert8_c_q : std_logic_vector (0 downto 0);
    signal ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_q : std_logic_vector (1 downto 0);
    signal ld_X31dto0_uid550_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_b_q : std_logic_vector (31 downto 0);
    signal ld_X15dto0_uid553_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_b_q : std_logic_vector (15 downto 0);
    signal ld_reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_c_q : std_logic_vector (47 downto 0);
    signal ld_reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q_to_r_uid655_zeroCounter_uid150_Acc1_f_q : std_logic_vector (0 downto 0);
    signal ld_X31dto0_uid659_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_b_q : std_logic_vector (31 downto 0);
    signal ld_X15dto0_uid662_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_b_q : std_logic_vector (15 downto 0);
    signal ld_reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_c_q : std_logic_vector (47 downto 0);
    signal ld_vCount_uid692_lzcShifterZ1_uid181_Convert_q_to_vCount_uid730_lzcShifterZ1_uid181_Convert_f_q : std_logic_vector (0 downto 0);
    signal ld_vCount_uid739_lzcShifterZ1_uid211_Convert1_q_to_vCount_uid777_lzcShifterZ1_uid211_Convert1_f_q : std_logic_vector (0 downto 0);
    signal ld_vCount_uid786_lzcShifterZ1_uid241_Convert2_q_to_vCount_uid824_lzcShifterZ1_uid241_Convert2_f_q : std_logic_vector (0 downto 0);
    signal ld_vCount_uid833_lzcShifterZ1_uid271_Convert3_q_to_vCount_uid871_lzcShifterZ1_uid271_Convert3_f_q : std_logic_vector (0 downto 0);
    signal ld_vCount_uid880_lzcShifterZ1_uid301_Convert4_q_to_vCount_uid918_lzcShifterZ1_uid301_Convert4_f_q : std_logic_vector (0 downto 0);
    signal ld_vCount_uid927_lzcShifterZ1_uid331_Convert5_q_to_vCount_uid965_lzcShifterZ1_uid331_Convert5_f_q : std_logic_vector (0 downto 0);
    signal ld_vCount_uid513_zeroCounter_uid94_Acc_q_to_reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_a_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_outputreg_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_outputreg_q : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_reset0 : std_logic;
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_ia : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_aa : std_logic_vector (3 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_ab : std_logic_vector (3 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_iq : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_q : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_q : std_logic_vector(3 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i : unsigned(3 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_eq : std_logic;
    signal ld_ChannelIn_channel_to_ChannelOut_cout_replace_wrreg_q : std_logic_vector (3 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_reset0 : std_logic;
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_ia : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_aa : std_logic_vector (4 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_ab : std_logic_vector (4 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_iq : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_q : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_q : std_logic_vector(4 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i : unsigned(4 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_eq : std_logic;
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_wrreg_q : std_logic_vector (4 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_mem_top_q : std_logic_vector (5 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmpReg_q : std_logic_vector (0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena_q : std_logic_vector (0 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_reset0 : std_logic;
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_ia : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_aa : std_logic_vector (2 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_ab : std_logic_vector (2 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_iq : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_q : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_q : std_logic_vector(2 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i : unsigned(2 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_eq : std_logic;
    signal ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg_q : std_logic_vector (2 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_reset0 : std_logic;
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_ia : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_aa : std_logic_vector (3 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_ab : std_logic_vector (3 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_iq : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_q : std_logic_vector (44 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_q : std_logic_vector(3 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i : unsigned(3 downto 0);
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_eq : std_logic;
    signal ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_wrreg_q : std_logic_vector (3 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_reset0 : std_logic;
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_ia : std_logic_vector (44 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_aa : std_logic_vector (5 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_ab : std_logic_vector (5 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_iq : std_logic_vector (44 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_q : std_logic_vector (44 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_q : std_logic_vector(5 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i : unsigned(5 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_eq : std_logic;
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg_q : std_logic_vector (5 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_mem_top_q : std_logic_vector (6 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_cmpReg_q : std_logic_vector (0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena_q : std_logic_vector (0 downto 0);
    signal ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_reset0 : std_logic;
    signal ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_ia : std_logic_vector (44 downto 0);
    signal ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_aa : std_logic_vector (5 downto 0);
    signal ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_ab : std_logic_vector (5 downto 0);
    signal ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_iq : std_logic_vector (44 downto 0);
    signal ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_q : std_logic_vector (44 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg_q : std_logic_vector (0 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_reset0 : std_logic;
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_ia : std_logic_vector (22 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_aa : std_logic_vector (0 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_ab : std_logic_vector (0 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_iq : std_logic_vector (22 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_q : std_logic_vector (22 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_q : std_logic_vector(0 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_i : unsigned(0 downto 0);
    signal ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_wrreg_q : std_logic_vector (0 downto 0);
    signal ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_inputreg_q : std_logic_vector (1 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_inputreg_q : std_logic_vector (7 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_reset0 : std_logic;
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_ia : std_logic_vector (7 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_aa : std_logic_vector (3 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_ab : std_logic_vector (3 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_iq : std_logic_vector (7 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_q : std_logic_vector (7 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_q : std_logic_vector(3 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i : unsigned(3 downto 0);
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_eq : std_logic;
    signal ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_wrreg_q : std_logic_vector (3 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_reset0 : std_logic;
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_ia : std_logic_vector (14 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_aa : std_logic_vector (1 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_ab : std_logic_vector (1 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_iq : std_logic_vector (14 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_q : std_logic_vector (14 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_q : std_logic_vector(1 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_i : unsigned(1 downto 0);
    signal ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_wrreg_q : std_logic_vector (1 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_outputreg_q : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_reset0 : std_logic;
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_ia : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_aa : std_logic_vector (2 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_ab : std_logic_vector (2 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_iq : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_q : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_outputreg_q : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_reset0 : std_logic;
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_ia : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_aa : std_logic_vector (1 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_ab : std_logic_vector (1 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_iq : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_q : std_logic_vector (8 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_q : std_logic_vector(1 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i : unsigned(1 downto 0);
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_eq : std_logic;
    signal ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_wrreg_q : std_logic_vector (1 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_reset0 : std_logic;
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_ia : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_aa : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_ab : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_iq : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q : std_logic_vector(5 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_i : unsigned(5 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg_q : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_mem_top_q : std_logic_vector (6 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena_q : std_logic_vector (0 downto 0);
    attribute preserve : boolean;
    attribute preserve of ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena_q : signal is true;
    signal ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_reset0 : std_logic;
    signal ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_ia : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_aa : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_ab : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_iq : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_q : std_logic_vector (7 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_reset0 : std_logic;
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_ia : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_aa : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_ab : std_logic_vector (5 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_iq : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena_q : std_logic_vector (0 downto 0);
    attribute preserve of ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena_q : signal is true;
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena_q : std_logic_vector (0 downto 0);
    attribute preserve of ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena_q : signal is true;
    signal ovf_uid191_Convert_a : std_logic_vector(12 downto 0);
    signal ovf_uid191_Convert_b : std_logic_vector(12 downto 0);
    signal ovf_uid191_Convert_o : std_logic_vector (12 downto 0);
    signal ovf_uid191_Convert_cin : std_logic_vector (0 downto 0);
    signal ovf_uid191_Convert_n : std_logic_vector (0 downto 0);
    signal ovf_uid193_Convert_a : std_logic_vector(12 downto 0);
    signal ovf_uid193_Convert_b : std_logic_vector(12 downto 0);
    signal ovf_uid193_Convert_o : std_logic_vector (12 downto 0);
    signal ovf_uid193_Convert_cin : std_logic_vector (0 downto 0);
    signal ovf_uid193_Convert_n : std_logic_vector (0 downto 0);
    signal ovf_uid221_Convert1_a : std_logic_vector(12 downto 0);
    signal ovf_uid221_Convert1_b : std_logic_vector(12 downto 0);
    signal ovf_uid221_Convert1_o : std_logic_vector (12 downto 0);
    signal ovf_uid221_Convert1_cin : std_logic_vector (0 downto 0);
    signal ovf_uid221_Convert1_n : std_logic_vector (0 downto 0);
    signal ovf_uid223_Convert1_a : std_logic_vector(12 downto 0);
    signal ovf_uid223_Convert1_b : std_logic_vector(12 downto 0);
    signal ovf_uid223_Convert1_o : std_logic_vector (12 downto 0);
    signal ovf_uid223_Convert1_cin : std_logic_vector (0 downto 0);
    signal ovf_uid223_Convert1_n : std_logic_vector (0 downto 0);
    signal ovf_uid251_Convert2_a : std_logic_vector(12 downto 0);
    signal ovf_uid251_Convert2_b : std_logic_vector(12 downto 0);
    signal ovf_uid251_Convert2_o : std_logic_vector (12 downto 0);
    signal ovf_uid251_Convert2_cin : std_logic_vector (0 downto 0);
    signal ovf_uid251_Convert2_n : std_logic_vector (0 downto 0);
    signal ovf_uid253_Convert2_a : std_logic_vector(12 downto 0);
    signal ovf_uid253_Convert2_b : std_logic_vector(12 downto 0);
    signal ovf_uid253_Convert2_o : std_logic_vector (12 downto 0);
    signal ovf_uid253_Convert2_cin : std_logic_vector (0 downto 0);
    signal ovf_uid253_Convert2_n : std_logic_vector (0 downto 0);
    signal ovf_uid281_Convert3_a : std_logic_vector(12 downto 0);
    signal ovf_uid281_Convert3_b : std_logic_vector(12 downto 0);
    signal ovf_uid281_Convert3_o : std_logic_vector (12 downto 0);
    signal ovf_uid281_Convert3_cin : std_logic_vector (0 downto 0);
    signal ovf_uid281_Convert3_n : std_logic_vector (0 downto 0);
    signal ovf_uid283_Convert3_a : std_logic_vector(12 downto 0);
    signal ovf_uid283_Convert3_b : std_logic_vector(12 downto 0);
    signal ovf_uid283_Convert3_o : std_logic_vector (12 downto 0);
    signal ovf_uid283_Convert3_cin : std_logic_vector (0 downto 0);
    signal ovf_uid283_Convert3_n : std_logic_vector (0 downto 0);
    signal ovf_uid311_Convert4_a : std_logic_vector(12 downto 0);
    signal ovf_uid311_Convert4_b : std_logic_vector(12 downto 0);
    signal ovf_uid311_Convert4_o : std_logic_vector (12 downto 0);
    signal ovf_uid311_Convert4_cin : std_logic_vector (0 downto 0);
    signal ovf_uid311_Convert4_n : std_logic_vector (0 downto 0);
    signal ovf_uid313_Convert4_a : std_logic_vector(12 downto 0);
    signal ovf_uid313_Convert4_b : std_logic_vector(12 downto 0);
    signal ovf_uid313_Convert4_o : std_logic_vector (12 downto 0);
    signal ovf_uid313_Convert4_cin : std_logic_vector (0 downto 0);
    signal ovf_uid313_Convert4_n : std_logic_vector (0 downto 0);
    signal ovf_uid341_Convert5_a : std_logic_vector(12 downto 0);
    signal ovf_uid341_Convert5_b : std_logic_vector(12 downto 0);
    signal ovf_uid341_Convert5_o : std_logic_vector (12 downto 0);
    signal ovf_uid341_Convert5_cin : std_logic_vector (0 downto 0);
    signal ovf_uid341_Convert5_n : std_logic_vector (0 downto 0);
    signal ovf_uid343_Convert5_a : std_logic_vector(12 downto 0);
    signal ovf_uid343_Convert5_b : std_logic_vector(12 downto 0);
    signal ovf_uid343_Convert5_o : std_logic_vector (12 downto 0);
    signal ovf_uid343_Convert5_cin : std_logic_vector (0 downto 0);
    signal ovf_uid343_Convert5_n : std_logic_vector (0 downto 0);
    signal vCountBig_uid732_lzcShifterZ1_uid181_Convert_a : std_logic_vector(8 downto 0);
    signal vCountBig_uid732_lzcShifterZ1_uid181_Convert_b : std_logic_vector(8 downto 0);
    signal vCountBig_uid732_lzcShifterZ1_uid181_Convert_o : std_logic_vector (8 downto 0);
    signal vCountBig_uid732_lzcShifterZ1_uid181_Convert_cin : std_logic_vector (0 downto 0);
    signal vCountBig_uid732_lzcShifterZ1_uid181_Convert_c : std_logic_vector (0 downto 0);
    signal vCountBig_uid779_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(8 downto 0);
    signal vCountBig_uid779_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(8 downto 0);
    signal vCountBig_uid779_lzcShifterZ1_uid211_Convert1_o : std_logic_vector (8 downto 0);
    signal vCountBig_uid779_lzcShifterZ1_uid211_Convert1_cin : std_logic_vector (0 downto 0);
    signal vCountBig_uid779_lzcShifterZ1_uid211_Convert1_c : std_logic_vector (0 downto 0);
    signal vCountBig_uid826_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(8 downto 0);
    signal vCountBig_uid826_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(8 downto 0);
    signal vCountBig_uid826_lzcShifterZ1_uid241_Convert2_o : std_logic_vector (8 downto 0);
    signal vCountBig_uid826_lzcShifterZ1_uid241_Convert2_cin : std_logic_vector (0 downto 0);
    signal vCountBig_uid826_lzcShifterZ1_uid241_Convert2_c : std_logic_vector (0 downto 0);
    signal vCountBig_uid873_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(8 downto 0);
    signal vCountBig_uid873_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(8 downto 0);
    signal vCountBig_uid873_lzcShifterZ1_uid271_Convert3_o : std_logic_vector (8 downto 0);
    signal vCountBig_uid873_lzcShifterZ1_uid271_Convert3_cin : std_logic_vector (0 downto 0);
    signal vCountBig_uid873_lzcShifterZ1_uid271_Convert3_c : std_logic_vector (0 downto 0);
    signal vCountBig_uid920_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(8 downto 0);
    signal vCountBig_uid920_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(8 downto 0);
    signal vCountBig_uid920_lzcShifterZ1_uid301_Convert4_o : std_logic_vector (8 downto 0);
    signal vCountBig_uid920_lzcShifterZ1_uid301_Convert4_cin : std_logic_vector (0 downto 0);
    signal vCountBig_uid920_lzcShifterZ1_uid301_Convert4_c : std_logic_vector (0 downto 0);
    signal vCountBig_uid967_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(8 downto 0);
    signal vCountBig_uid967_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(8 downto 0);
    signal vCountBig_uid967_lzcShifterZ1_uid331_Convert5_o : std_logic_vector (8 downto 0);
    signal vCountBig_uid967_lzcShifterZ1_uid331_Convert5_cin : std_logic_vector (0 downto 0);
    signal vCountBig_uid967_lzcShifterZ1_uid331_Convert5_c : std_logic_vector (0 downto 0);
    signal onesComplementExtendedFrac_uid80_Acc_a : std_logic_vector(38 downto 0);
    signal onesComplementExtendedFrac_uid80_Acc_b : std_logic_vector(38 downto 0);
    signal onesComplementExtendedFrac_uid80_Acc_q : std_logic_vector(38 downto 0);
    signal onesComplementExtendedFrac_uid136_Acc1_a : std_logic_vector(38 downto 0);
    signal onesComplementExtendedFrac_uid136_Acc1_b : std_logic_vector(38 downto 0);
    signal onesComplementExtendedFrac_uid136_Acc1_q : std_logic_vector(38 downto 0);
    signal udfOrInZero_uid197_Convert_a : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid197_Convert_b : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid197_Convert_q : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid227_Convert1_a : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid227_Convert1_b : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid227_Convert1_q : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid257_Convert2_a : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid257_Convert2_b : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid257_Convert2_q : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid287_Convert3_a : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid287_Convert3_b : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid287_Convert3_q : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid317_Convert4_a : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid317_Convert4_b : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid317_Convert4_q : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid347_Convert5_a : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid347_Convert5_b : std_logic_vector(0 downto 0);
    signal udfOrInZero_uid347_Convert5_q : std_logic_vector(0 downto 0);
    signal rndOvf_uid381_Convert7_a : std_logic_vector(0 downto 0);
    signal rndOvf_uid381_Convert7_b : std_logic_vector(0 downto 0);
    signal rndOvf_uid381_Convert7_q : std_logic_vector(0 downto 0);
    signal ovfPostRnd_uid384_Convert7_a : std_logic_vector(0 downto 0);
    signal ovfPostRnd_uid384_Convert7_b : std_logic_vector(0 downto 0);
    signal ovfPostRnd_uid384_Convert7_q : std_logic_vector(0 downto 0);
    signal rndOvf_uid414_Convert8_a : std_logic_vector(0 downto 0);
    signal rndOvf_uid414_Convert8_b : std_logic_vector(0 downto 0);
    signal rndOvf_uid414_Convert8_q : std_logic_vector(0 downto 0);
    signal ovfPostRnd_uid417_Convert8_a : std_logic_vector(0 downto 0);
    signal ovfPostRnd_uid417_Convert8_b : std_logic_vector(0 downto 0);
    signal ovfPostRnd_uid417_Convert8_q : std_logic_vector(0 downto 0);
    signal vCount_uid521_zeroCounter_uid94_Acc_a : std_logic_vector(15 downto 0);
    signal vCount_uid521_zeroCounter_uid94_Acc_b : std_logic_vector(15 downto 0);
    signal vCount_uid521_zeroCounter_uid94_Acc_q : std_logic_vector(0 downto 0);
    signal vStagei_uid524_zeroCounter_uid94_Acc_s : std_logic_vector (0 downto 0);
    signal vStagei_uid524_zeroCounter_uid94_Acc_q : std_logic_vector (15 downto 0);
    signal vStagei_uid542_zeroCounter_uid94_Acc_s : std_logic_vector (0 downto 0);
    signal vStagei_uid542_zeroCounter_uid94_Acc_q : std_logic_vector (1 downto 0);
    signal vCount_uid630_zeroCounter_uid150_Acc1_a : std_logic_vector(15 downto 0);
    signal vCount_uid630_zeroCounter_uid150_Acc1_b : std_logic_vector(15 downto 0);
    signal vCount_uid630_zeroCounter_uid150_Acc1_q : std_logic_vector(0 downto 0);
    signal vStagei_uid633_zeroCounter_uid150_Acc1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid633_zeroCounter_uid150_Acc1_q : std_logic_vector (15 downto 0);
    signal vStagei_uid651_zeroCounter_uid150_Acc1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid651_zeroCounter_uid150_Acc1_q : std_logic_vector (1 downto 0);
    signal vStagei_uid701_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vStagei_uid701_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCountFinal_uid734_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vCountFinal_uid734_lzcShifterZ1_uid181_Convert_q : std_logic_vector (5 downto 0);
    signal vStagei_uid748_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid748_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (5 downto 0);
    signal vStagei_uid795_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vStagei_uid795_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (5 downto 0);
    signal vStagei_uid842_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vStagei_uid842_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (5 downto 0);
    signal vStagei_uid889_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vStagei_uid889_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (5 downto 0);
    signal vStagei_uid936_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vStagei_uid936_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (5 downto 0);
    signal rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_s : std_logic_vector (1 downto 0);
    signal rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_s : std_logic_vector (1 downto 0);
    signal rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_a : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_a : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_b : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_q : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_a : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_b : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_a : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_b : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_s : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_a : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_b : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_s : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_q : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_a : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_b : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_s : std_logic_vector (0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_q : std_logic_vector (0 downto 0);
    signal signX_uid177_Convert_in : std_logic_vector (31 downto 0);
    signal signX_uid177_Convert_b : std_logic_vector (0 downto 0);
    signal xXorSign_uid178_Convert_a : std_logic_vector(31 downto 0);
    signal xXorSign_uid178_Convert_b : std_logic_vector(31 downto 0);
    signal xXorSign_uid178_Convert_q : std_logic_vector(31 downto 0);
    signal signX_uid207_Convert1_in : std_logic_vector (31 downto 0);
    signal signX_uid207_Convert1_b : std_logic_vector (0 downto 0);
    signal xXorSign_uid208_Convert1_a : std_logic_vector(31 downto 0);
    signal xXorSign_uid208_Convert1_b : std_logic_vector(31 downto 0);
    signal xXorSign_uid208_Convert1_q : std_logic_vector(31 downto 0);
    signal signX_uid237_Convert2_in : std_logic_vector (31 downto 0);
    signal signX_uid237_Convert2_b : std_logic_vector (0 downto 0);
    signal xXorSign_uid238_Convert2_a : std_logic_vector(31 downto 0);
    signal xXorSign_uid238_Convert2_b : std_logic_vector(31 downto 0);
    signal xXorSign_uid238_Convert2_q : std_logic_vector(31 downto 0);
    signal signX_uid267_Convert3_in : std_logic_vector (31 downto 0);
    signal signX_uid267_Convert3_b : std_logic_vector (0 downto 0);
    signal xXorSign_uid268_Convert3_a : std_logic_vector(31 downto 0);
    signal xXorSign_uid268_Convert3_b : std_logic_vector(31 downto 0);
    signal xXorSign_uid268_Convert3_q : std_logic_vector(31 downto 0);
    signal signX_uid297_Convert4_in : std_logic_vector (31 downto 0);
    signal signX_uid297_Convert4_b : std_logic_vector (0 downto 0);
    signal xXorSign_uid298_Convert4_a : std_logic_vector(31 downto 0);
    signal xXorSign_uid298_Convert4_b : std_logic_vector(31 downto 0);
    signal xXorSign_uid298_Convert4_q : std_logic_vector(31 downto 0);
    signal signX_uid327_Convert5_in : std_logic_vector (31 downto 0);
    signal signX_uid327_Convert5_b : std_logic_vector (0 downto 0);
    signal xXorSign_uid328_Convert5_a : std_logic_vector(31 downto 0);
    signal xXorSign_uid328_Convert5_b : std_logic_vector(31 downto 0);
    signal xXorSign_uid328_Convert5_q : std_logic_vector(31 downto 0);
    signal expX_uid65_Acc_in : std_logic_vector (30 downto 0);
    signal expX_uid65_Acc_b : std_logic_vector (7 downto 0);
    signal fracX_uid66_Acc_in : std_logic_vector (22 downto 0);
    signal fracX_uid66_Acc_b : std_logic_vector (22 downto 0);
    signal signX_uid67_Acc_in : std_logic_vector (31 downto 0);
    signal signX_uid67_Acc_b : std_logic_vector (0 downto 0);
    signal expX_uid121_Acc1_in : std_logic_vector (30 downto 0);
    signal expX_uid121_Acc1_b : std_logic_vector (7 downto 0);
    signal fracX_uid122_Acc1_in : std_logic_vector (22 downto 0);
    signal fracX_uid122_Acc1_b : std_logic_vector (22 downto 0);
    signal signX_uid123_Acc1_in : std_logic_vector (31 downto 0);
    signal signX_uid123_Acc1_b : std_logic_vector (0 downto 0);
    signal exp_uid433_RecipSqRt_in : std_logic_vector (30 downto 0);
    signal exp_uid433_RecipSqRt_b : std_logic_vector (7 downto 0);
    signal frac_uid437_RecipSqRt_in : std_logic_vector (22 downto 0);
    signal frac_uid437_RecipSqRt_b : std_logic_vector (22 downto 0);
    signal signX_uid448_RecipSqRt_in : std_logic_vector (31 downto 0);
    signal signX_uid448_RecipSqRt_b : std_logic_vector (0 downto 0);
    signal cmpLT_w8_uid70_Acc_a : std_logic_vector(10 downto 0);
    signal cmpLT_w8_uid70_Acc_b : std_logic_vector(10 downto 0);
    signal cmpLT_w8_uid70_Acc_o : std_logic_vector (10 downto 0);
    signal cmpLT_w8_uid70_Acc_cin : std_logic_vector (0 downto 0);
    signal cmpLT_w8_uid70_Acc_c : std_logic_vector (0 downto 0);
    signal cmpLT_w8_uid126_Acc1_a : std_logic_vector(10 downto 0);
    signal cmpLT_w8_uid126_Acc1_b : std_logic_vector(10 downto 0);
    signal cmpLT_w8_uid126_Acc1_o : std_logic_vector (10 downto 0);
    signal cmpLT_w8_uid126_Acc1_cin : std_logic_vector (0 downto 0);
    signal cmpLT_w8_uid126_Acc1_c : std_logic_vector (0 downto 0);
    signal cmpGT_w8_uid72_Acc_a : std_logic_vector(10 downto 0);
    signal cmpGT_w8_uid72_Acc_b : std_logic_vector(10 downto 0);
    signal cmpGT_w8_uid72_Acc_o : std_logic_vector (10 downto 0);
    signal cmpGT_w8_uid72_Acc_cin : std_logic_vector (0 downto 0);
    signal cmpGT_w8_uid72_Acc_c : std_logic_vector (0 downto 0);
    signal cmpGT_w8_uid128_Acc1_a : std_logic_vector(10 downto 0);
    signal cmpGT_w8_uid128_Acc1_b : std_logic_vector(10 downto 0);
    signal cmpGT_w8_uid128_Acc1_o : std_logic_vector (10 downto 0);
    signal cmpGT_w8_uid128_Acc1_cin : std_logic_vector (0 downto 0);
    signal cmpGT_w8_uid128_Acc1_c : std_logic_vector (0 downto 0);
    signal rightShiftValue_uid74_Acc_a : std_logic_vector(9 downto 0);
    signal rightShiftValue_uid74_Acc_b : std_logic_vector(9 downto 0);
    signal rightShiftValue_uid74_Acc_o : std_logic_vector (9 downto 0);
    signal rightShiftValue_uid74_Acc_q : std_logic_vector (9 downto 0);
    signal rightShiftValue_uid130_Acc1_a : std_logic_vector(9 downto 0);
    signal rightShiftValue_uid130_Acc1_b : std_logic_vector(9 downto 0);
    signal rightShiftValue_uid130_Acc1_o : std_logic_vector (9 downto 0);
    signal rightShiftValue_uid130_Acc1_q : std_logic_vector (9 downto 0);
    signal join_uid83_Acc_q : std_logic_vector (49 downto 0);
    signal expXIsZero_uid434_RecipSqRt_a : std_logic_vector(7 downto 0);
    signal expXIsZero_uid434_RecipSqRt_b : std_logic_vector(7 downto 0);
    signal expXIsZero_uid434_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal join_uid139_Acc1_q : std_logic_vector (49 downto 0);
    signal excSelector_uid194_Convert_a : std_logic_vector(0 downto 0);
    signal excSelector_uid194_Convert_b : std_logic_vector(0 downto 0);
    signal excSelector_uid194_Convert_q : std_logic_vector(0 downto 0);
    signal expPreRnd_uid185_Convert_a : std_logic_vector(8 downto 0);
    signal expPreRnd_uid185_Convert_b : std_logic_vector(8 downto 0);
    signal expPreRnd_uid185_Convert_o : std_logic_vector (8 downto 0);
    signal expPreRnd_uid185_Convert_q : std_logic_vector (8 downto 0);
    signal expPreRnd_uid215_Convert1_a : std_logic_vector(8 downto 0);
    signal expPreRnd_uid215_Convert1_b : std_logic_vector(8 downto 0);
    signal expPreRnd_uid215_Convert1_o : std_logic_vector (8 downto 0);
    signal expPreRnd_uid215_Convert1_q : std_logic_vector (8 downto 0);
    signal expPreRnd_uid245_Convert2_a : std_logic_vector(8 downto 0);
    signal expPreRnd_uid245_Convert2_b : std_logic_vector(8 downto 0);
    signal expPreRnd_uid245_Convert2_o : std_logic_vector (8 downto 0);
    signal expPreRnd_uid245_Convert2_q : std_logic_vector (8 downto 0);
    signal expPreRnd_uid275_Convert3_a : std_logic_vector(8 downto 0);
    signal expPreRnd_uid275_Convert3_b : std_logic_vector(8 downto 0);
    signal expPreRnd_uid275_Convert3_o : std_logic_vector (8 downto 0);
    signal expPreRnd_uid275_Convert3_q : std_logic_vector (8 downto 0);
    signal expPreRnd_uid305_Convert4_a : std_logic_vector(8 downto 0);
    signal expPreRnd_uid305_Convert4_b : std_logic_vector(8 downto 0);
    signal expPreRnd_uid305_Convert4_o : std_logic_vector (8 downto 0);
    signal expPreRnd_uid305_Convert4_q : std_logic_vector (8 downto 0);
    signal expPreRnd_uid335_Convert5_a : std_logic_vector(8 downto 0);
    signal expPreRnd_uid335_Convert5_b : std_logic_vector(8 downto 0);
    signal expPreRnd_uid335_Convert5_o : std_logic_vector (8 downto 0);
    signal expPreRnd_uid335_Convert5_q : std_logic_vector (8 downto 0);
    signal expXIsMax_uid436_RecipSqRt_a : std_logic_vector(7 downto 0);
    signal expXIsMax_uid436_RecipSqRt_b : std_logic_vector(7 downto 0);
    signal expXIsMax_uid436_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal fracRPostExc_uid196_Convert_s : std_logic_vector (0 downto 0);
    signal fracRPostExc_uid196_Convert_q : std_logic_vector (22 downto 0);
    signal fracXIsZero_uid438_RecipSqRt_a : std_logic_vector(22 downto 0);
    signal fracXIsZero_uid438_RecipSqRt_b : std_logic_vector(22 downto 0);
    signal fracXIsZero_uid438_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal excSelector_uid224_Convert1_a : std_logic_vector(0 downto 0);
    signal excSelector_uid224_Convert1_b : std_logic_vector(0 downto 0);
    signal excSelector_uid224_Convert1_q : std_logic_vector(0 downto 0);
    signal excSelector_uid254_Convert2_a : std_logic_vector(0 downto 0);
    signal excSelector_uid254_Convert2_b : std_logic_vector(0 downto 0);
    signal excSelector_uid254_Convert2_q : std_logic_vector(0 downto 0);
    signal excSelector_uid284_Convert3_a : std_logic_vector(0 downto 0);
    signal excSelector_uid284_Convert3_b : std_logic_vector(0 downto 0);
    signal excSelector_uid284_Convert3_q : std_logic_vector(0 downto 0);
    signal excSelector_uid314_Convert4_a : std_logic_vector(0 downto 0);
    signal excSelector_uid314_Convert4_b : std_logic_vector(0 downto 0);
    signal excSelector_uid314_Convert4_q : std_logic_vector(0 downto 0);
    signal excSelector_uid344_Convert5_a : std_logic_vector(0 downto 0);
    signal excSelector_uid344_Convert5_b : std_logic_vector(0 downto 0);
    signal excSelector_uid344_Convert5_q : std_logic_vector(0 downto 0);
    signal leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal shiftedOut_uid474_alignmentShifter_uid75_Acc_a : std_logic_vector(12 downto 0);
    signal shiftedOut_uid474_alignmentShifter_uid75_Acc_b : std_logic_vector(12 downto 0);
    signal shiftedOut_uid474_alignmentShifter_uid75_Acc_o : std_logic_vector (12 downto 0);
    signal shiftedOut_uid474_alignmentShifter_uid75_Acc_cin : std_logic_vector (0 downto 0);
    signal shiftedOut_uid474_alignmentShifter_uid75_Acc_n : std_logic_vector (0 downto 0);
    signal shiftedOut_uid583_alignmentShifter_uid131_Acc1_a : std_logic_vector(12 downto 0);
    signal shiftedOut_uid583_alignmentShifter_uid131_Acc1_b : std_logic_vector(12 downto 0);
    signal shiftedOut_uid583_alignmentShifter_uid131_Acc1_o : std_logic_vector (12 downto 0);
    signal shiftedOut_uid583_alignmentShifter_uid131_Acc1_cin : std_logic_vector (0 downto 0);
    signal shiftedOut_uid583_alignmentShifter_uid131_Acc1_n : std_logic_vector (0 downto 0);
    signal leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_in : std_logic_vector (23 downto 0);
    signal prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_b : std_logic_vector (12 downto 0);
    signal prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_in : std_logic_vector (37 downto 0);
    signal prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_b : std_logic_vector (23 downto 0);
    signal expFracRnd_uid187_uid187_Convert_q : std_logic_vector (32 downto 0);
    signal expFracRnd_uid217_uid217_Convert1_q : std_logic_vector (32 downto 0);
    signal fracRPostExc_uid226_Convert1_s : std_logic_vector (0 downto 0);
    signal fracRPostExc_uid226_Convert1_q : std_logic_vector (22 downto 0);
    signal expFracRnd_uid247_uid247_Convert2_q : std_logic_vector (32 downto 0);
    signal fracRPostExc_uid256_Convert2_s : std_logic_vector (0 downto 0);
    signal fracRPostExc_uid256_Convert2_q : std_logic_vector (22 downto 0);
    signal expFracRnd_uid277_uid277_Convert3_q : std_logic_vector (32 downto 0);
    signal fracRPostExc_uid286_Convert3_s : std_logic_vector (0 downto 0);
    signal fracRPostExc_uid286_Convert3_q : std_logic_vector (22 downto 0);
    signal expFracRnd_uid307_uid307_Convert4_q : std_logic_vector (32 downto 0);
    signal fracRPostExc_uid316_Convert4_s : std_logic_vector (0 downto 0);
    signal fracRPostExc_uid316_Convert4_q : std_logic_vector (22 downto 0);
    signal expFracRnd_uid337_uid337_Convert5_q : std_logic_vector (32 downto 0);
    signal fracRPostExc_uid346_Convert5_s : std_logic_vector (0 downto 0);
    signal fracRPostExc_uid346_Convert5_q : std_logic_vector (22 downto 0);
    signal oRXOverflowFlagFeedback_uid109_Acc_a : std_logic_vector(0 downto 0);
    signal oRXOverflowFlagFeedback_uid109_Acc_b : std_logic_vector(0 downto 0);
    signal oRXOverflowFlagFeedback_uid109_Acc_q : std_logic_vector(0 downto 0);
    signal oRXUnderflowFlagFeedback_uid113_Acc_a : std_logic_vector(0 downto 0);
    signal oRXUnderflowFlagFeedback_uid113_Acc_b : std_logic_vector(0 downto 0);
    signal oRXUnderflowFlagFeedback_uid113_Acc_q : std_logic_vector(0 downto 0);
    signal oRXOverflowFlagFeedback_uid165_Acc1_a : std_logic_vector(0 downto 0);
    signal oRXOverflowFlagFeedback_uid165_Acc1_b : std_logic_vector(0 downto 0);
    signal oRXOverflowFlagFeedback_uid165_Acc1_q : std_logic_vector(0 downto 0);
    signal oRXUnderflowFlagFeedback_uid169_Acc1_a : std_logic_vector(0 downto 0);
    signal oRXUnderflowFlagFeedback_uid169_Acc1_b : std_logic_vector(0 downto 0);
    signal oRXUnderflowFlagFeedback_uid169_Acc1_q : std_logic_vector(0 downto 0);
    signal muxSelConc_uid385_Convert7_q : std_logic_vector (2 downto 0);
    signal muxSelConc_uid418_Convert8_q : std_logic_vector (2 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_a : std_logic_vector(5 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_b : std_logic_vector(5 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_q : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_a : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_b : std_logic_vector(0 downto 0);
    signal ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_q : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_a : std_logic_vector(6 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_b : std_logic_vector(6 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_q : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_a : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_b : std_logic_vector(0 downto 0);
    signal ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_q : std_logic_vector(0 downto 0);
    signal muxXOverflowFeedbackSignal_uid108_Acc_s : std_logic_vector (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid108_Acc_q : std_logic_vector (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid112_Acc_s : std_logic_vector (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid112_Acc_q : std_logic_vector (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid164_Acc1_s : std_logic_vector (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid164_Acc1_q : std_logic_vector (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid168_Acc1_s : std_logic_vector (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid168_Acc1_q : std_logic_vector (0 downto 0);
    signal yPPolyEval_uid454_RecipSqRt_in : std_logic_vector (14 downto 0);
    signal yPPolyEval_uid454_RecipSqRt_b : std_logic_vector (14 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_a : std_logic_vector(6 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_b : std_logic_vector(6 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_a : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_b : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_a : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_b : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_q : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_a : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_b : std_logic_vector(0 downto 0);
    signal ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_q : std_logic_vector(0 downto 0);
    signal excSelector_uid198_Convert_q : std_logic_vector (1 downto 0);
    signal excSelector_uid228_Convert1_q : std_logic_vector (1 downto 0);
    signal excSelector_uid258_Convert2_q : std_logic_vector (1 downto 0);
    signal excSelector_uid288_Convert3_q : std_logic_vector (1 downto 0);
    signal excSelector_uid318_Convert4_q : std_logic_vector (1 downto 0);
    signal excSelector_uid348_Convert5_q : std_logic_vector (1 downto 0);
    signal rVStage_uid526_zeroCounter_uid94_Acc_in : std_logic_vector (15 downto 0);
    signal rVStage_uid526_zeroCounter_uid94_Acc_b : std_logic_vector (7 downto 0);
    signal vStage_uid528_zeroCounter_uid94_Acc_in : std_logic_vector (7 downto 0);
    signal vStage_uid528_zeroCounter_uid94_Acc_b : std_logic_vector (7 downto 0);
    signal rVStage_uid544_zeroCounter_uid94_Acc_in : std_logic_vector (1 downto 0);
    signal rVStage_uid544_zeroCounter_uid94_Acc_b : std_logic_vector (0 downto 0);
    signal rVStage_uid635_zeroCounter_uid150_Acc1_in : std_logic_vector (15 downto 0);
    signal rVStage_uid635_zeroCounter_uid150_Acc1_b : std_logic_vector (7 downto 0);
    signal vStage_uid637_zeroCounter_uid150_Acc1_in : std_logic_vector (7 downto 0);
    signal vStage_uid637_zeroCounter_uid150_Acc1_b : std_logic_vector (7 downto 0);
    signal rVStage_uid653_zeroCounter_uid150_Acc1_in : std_logic_vector (1 downto 0);
    signal rVStage_uid653_zeroCounter_uid150_Acc1_b : std_logic_vector (0 downto 0);
    signal rVStage_uid703_lzcShifterZ1_uid181_Convert_in : std_logic_vector (31 downto 0);
    signal rVStage_uid703_lzcShifterZ1_uid181_Convert_b : std_logic_vector (7 downto 0);
    signal vStage_uid706_lzcShifterZ1_uid181_Convert_in : std_logic_vector (23 downto 0);
    signal vStage_uid706_lzcShifterZ1_uid181_Convert_b : std_logic_vector (23 downto 0);
    signal rVStage_uid750_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (31 downto 0);
    signal rVStage_uid750_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (7 downto 0);
    signal vStage_uid753_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (23 downto 0);
    signal vStage_uid753_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (23 downto 0);
    signal rVStage_uid797_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (31 downto 0);
    signal rVStage_uid797_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (7 downto 0);
    signal vStage_uid800_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (23 downto 0);
    signal vStage_uid800_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (23 downto 0);
    signal rVStage_uid844_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (31 downto 0);
    signal rVStage_uid844_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (7 downto 0);
    signal vStage_uid847_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (23 downto 0);
    signal vStage_uid847_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (23 downto 0);
    signal rVStage_uid891_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (31 downto 0);
    signal rVStage_uid891_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (7 downto 0);
    signal vStage_uid894_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (23 downto 0);
    signal vStage_uid894_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (23 downto 0);
    signal rVStage_uid938_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (31 downto 0);
    signal rVStage_uid938_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (7 downto 0);
    signal vStage_uid941_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (23 downto 0);
    signal vStage_uid941_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (23 downto 0);
    signal RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (28 downto 0);
    signal RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (24 downto 0);
    signal RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (20 downto 0);
    signal RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (28 downto 0);
    signal RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (24 downto 0);
    signal RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (20 downto 0);
    signal yE_uid179_Convert_a : std_logic_vector(33 downto 0);
    signal yE_uid179_Convert_b : std_logic_vector(33 downto 0);
    signal yE_uid179_Convert_o : std_logic_vector (33 downto 0);
    signal yE_uid179_Convert_q : std_logic_vector (32 downto 0);
    signal yE_uid209_Convert1_a : std_logic_vector(33 downto 0);
    signal yE_uid209_Convert1_b : std_logic_vector(33 downto 0);
    signal yE_uid209_Convert1_o : std_logic_vector (33 downto 0);
    signal yE_uid209_Convert1_q : std_logic_vector (32 downto 0);
    signal yE_uid239_Convert2_a : std_logic_vector(33 downto 0);
    signal yE_uid239_Convert2_b : std_logic_vector(33 downto 0);
    signal yE_uid239_Convert2_o : std_logic_vector (33 downto 0);
    signal yE_uid239_Convert2_q : std_logic_vector (32 downto 0);
    signal yE_uid269_Convert3_a : std_logic_vector(33 downto 0);
    signal yE_uid269_Convert3_b : std_logic_vector(33 downto 0);
    signal yE_uid269_Convert3_o : std_logic_vector (33 downto 0);
    signal yE_uid269_Convert3_q : std_logic_vector (32 downto 0);
    signal yE_uid299_Convert4_a : std_logic_vector(33 downto 0);
    signal yE_uid299_Convert4_b : std_logic_vector(33 downto 0);
    signal yE_uid299_Convert4_o : std_logic_vector (33 downto 0);
    signal yE_uid299_Convert4_q : std_logic_vector (32 downto 0);
    signal yE_uid329_Convert5_a : std_logic_vector(33 downto 0);
    signal yE_uid329_Convert5_b : std_logic_vector(33 downto 0);
    signal yE_uid329_Convert5_o : std_logic_vector (33 downto 0);
    signal yE_uid329_Convert5_q : std_logic_vector (32 downto 0);
    signal oFracX_uid68_uid68_Acc_q : std_logic_vector (23 downto 0);
    signal oFracX_uid124_uid124_Acc1_q : std_logic_vector (23 downto 0);
    signal evenOddExp_uid450_RecipSqRt_in : std_logic_vector (0 downto 0);
    signal evenOddExp_uid450_RecipSqRt_b : std_logic_vector (0 downto 0);
    signal expRExt_uid460_RecipSqRt_in : std_logic_vector (7 downto 0);
    signal expRExt_uid460_RecipSqRt_b : std_logic_vector (6 downto 0);
    signal yAddr_uid452_RecipSqRt_in : std_logic_vector (22 downto 0);
    signal yAddr_uid452_RecipSqRt_b : std_logic_vector (7 downto 0);
    signal rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc_in : std_logic_vector (5 downto 0);
    signal rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc_in : std_logic_vector (3 downto 0);
    signal rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc_in : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1_in : std_logic_vector (5 downto 0);
    signal rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1_in : std_logic_vector (3 downto 0);
    signal rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1_in : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1_b : std_logic_vector (1 downto 0);
    signal sum_uid84_Acc_in : std_logic_vector (47 downto 0);
    signal sum_uid84_Acc_b : std_logic_vector (47 downto 0);
    signal InvExpXIsZero_uid444_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal InvExpXIsZero_uid444_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal sum_uid140_Acc1_in : std_logic_vector (47 downto 0);
    signal sum_uid140_Acc1_b : std_logic_vector (47 downto 0);
    signal exc_I_uid439_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal exc_I_uid439_RecipSqRt_b : std_logic_vector(0 downto 0);
    signal exc_I_uid439_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal InvFracXIsZero_uid440_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal InvFracXIsZero_uid440_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal join_uid458_RecipSqRt_q : std_logic_vector (1 downto 0);
    signal lowRangeB_uid1061_invSqrtPolyEval_in : std_logic_vector (0 downto 0);
    signal lowRangeB_uid1061_invSqrtPolyEval_b : std_logic_vector (0 downto 0);
    signal highBBits_uid1062_invSqrtPolyEval_in : std_logic_vector (12 downto 0);
    signal highBBits_uid1062_invSqrtPolyEval_b : std_logic_vector (11 downto 0);
    signal lowRangeB_uid1067_invSqrtPolyEval_in : std_logic_vector (1 downto 0);
    signal lowRangeB_uid1067_invSqrtPolyEval_b : std_logic_vector (1 downto 0);
    signal highBBits_uid1068_invSqrtPolyEval_in : std_logic_vector (23 downto 0);
    signal highBBits_uid1068_invSqrtPolyEval_b : std_logic_vector (21 downto 0);
    signal expFracR_uid188_Convert_a : std_logic_vector(34 downto 0);
    signal expFracR_uid188_Convert_b : std_logic_vector(34 downto 0);
    signal expFracR_uid188_Convert_o : std_logic_vector (34 downto 0);
    signal expFracR_uid188_Convert_q : std_logic_vector (33 downto 0);
    signal expFracR_uid218_Convert1_a : std_logic_vector(34 downto 0);
    signal expFracR_uid218_Convert1_b : std_logic_vector(34 downto 0);
    signal expFracR_uid218_Convert1_o : std_logic_vector (34 downto 0);
    signal expFracR_uid218_Convert1_q : std_logic_vector (33 downto 0);
    signal expFracR_uid248_Convert2_a : std_logic_vector(34 downto 0);
    signal expFracR_uid248_Convert2_b : std_logic_vector(34 downto 0);
    signal expFracR_uid248_Convert2_o : std_logic_vector (34 downto 0);
    signal expFracR_uid248_Convert2_q : std_logic_vector (33 downto 0);
    signal expFracR_uid278_Convert3_a : std_logic_vector(34 downto 0);
    signal expFracR_uid278_Convert3_b : std_logic_vector(34 downto 0);
    signal expFracR_uid278_Convert3_o : std_logic_vector (34 downto 0);
    signal expFracR_uid278_Convert3_q : std_logic_vector (33 downto 0);
    signal expFracR_uid308_Convert4_a : std_logic_vector(34 downto 0);
    signal expFracR_uid308_Convert4_b : std_logic_vector(34 downto 0);
    signal expFracR_uid308_Convert4_o : std_logic_vector (34 downto 0);
    signal expFracR_uid308_Convert4_q : std_logic_vector (33 downto 0);
    signal expFracR_uid338_Convert5_a : std_logic_vector(34 downto 0);
    signal expFracR_uid338_Convert5_b : std_logic_vector(34 downto 0);
    signal expFracR_uid338_Convert5_o : std_logic_vector (34 downto 0);
    signal expFracR_uid338_Convert5_q : std_logic_vector (33 downto 0);
    signal muxSel_uid386_Convert7_q : std_logic_vector(1 downto 0);
    signal muxSel_uid419_Convert8_q : std_logic_vector(1 downto 0);
    signal yT1_uid1059_invSqrtPolyEval_in : std_logic_vector (14 downto 0);
    signal yT1_uid1059_invSqrtPolyEval_b : std_logic_vector (11 downto 0);
    signal expRPostExc_uid203_Convert_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid203_Convert_q : std_logic_vector (7 downto 0);
    signal expRPostExc_uid233_Convert1_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid233_Convert1_q : std_logic_vector (7 downto 0);
    signal expRPostExc_uid263_Convert2_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid263_Convert2_q : std_logic_vector (7 downto 0);
    signal expRPostExc_uid293_Convert3_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid293_Convert3_q : std_logic_vector (7 downto 0);
    signal expRPostExc_uid323_Convert4_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid323_Convert4_q : std_logic_vector (7 downto 0);
    signal expRPostExc_uid353_Convert5_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid353_Convert5_q : std_logic_vector (7 downto 0);
    signal vCount_uid527_zeroCounter_uid94_Acc_a : std_logic_vector(7 downto 0);
    signal vCount_uid527_zeroCounter_uid94_Acc_b : std_logic_vector(7 downto 0);
    signal vCount_uid527_zeroCounter_uid94_Acc_q : std_logic_vector(0 downto 0);
    signal vStagei_uid530_zeroCounter_uid94_Acc_s : std_logic_vector (0 downto 0);
    signal vStagei_uid530_zeroCounter_uid94_Acc_q : std_logic_vector (7 downto 0);
    signal vCount_uid545_zeroCounter_uid94_Acc_a : std_logic_vector(0 downto 0);
    signal vCount_uid545_zeroCounter_uid94_Acc_b : std_logic_vector(0 downto 0);
    signal vCount_uid545_zeroCounter_uid94_Acc_q : std_logic_vector(0 downto 0);
    signal vCount_uid636_zeroCounter_uid150_Acc1_a : std_logic_vector(7 downto 0);
    signal vCount_uid636_zeroCounter_uid150_Acc1_b : std_logic_vector(7 downto 0);
    signal vCount_uid636_zeroCounter_uid150_Acc1_q : std_logic_vector(0 downto 0);
    signal vStagei_uid639_zeroCounter_uid150_Acc1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid639_zeroCounter_uid150_Acc1_q : std_logic_vector (7 downto 0);
    signal vCount_uid654_zeroCounter_uid150_Acc1_a : std_logic_vector(0 downto 0);
    signal vCount_uid654_zeroCounter_uid150_Acc1_b : std_logic_vector(0 downto 0);
    signal vCount_uid654_zeroCounter_uid150_Acc1_q : std_logic_vector(0 downto 0);
    signal vCount_uid704_lzcShifterZ1_uid181_Convert_a : std_logic_vector(7 downto 0);
    signal vCount_uid704_lzcShifterZ1_uid181_Convert_b : std_logic_vector(7 downto 0);
    signal vCount_uid704_lzcShifterZ1_uid181_Convert_q : std_logic_vector(0 downto 0);
    signal cStage_uid707_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCount_uid751_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(7 downto 0);
    signal vCount_uid751_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(7 downto 0);
    signal vCount_uid751_lzcShifterZ1_uid211_Convert1_q : std_logic_vector(0 downto 0);
    signal cStage_uid754_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCount_uid798_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(7 downto 0);
    signal vCount_uid798_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(7 downto 0);
    signal vCount_uid798_lzcShifterZ1_uid241_Convert2_q : std_logic_vector(0 downto 0);
    signal cStage_uid801_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCount_uid845_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(7 downto 0);
    signal vCount_uid845_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(7 downto 0);
    signal vCount_uid845_lzcShifterZ1_uid271_Convert3_q : std_logic_vector(0 downto 0);
    signal cStage_uid848_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCount_uid892_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(7 downto 0);
    signal vCount_uid892_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(7 downto 0);
    signal vCount_uid892_lzcShifterZ1_uid301_Convert4_q : std_logic_vector(0 downto 0);
    signal cStage_uid895_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCount_uid939_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(7 downto 0);
    signal vCount_uid939_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(7 downto 0);
    signal vCount_uid939_lzcShifterZ1_uid331_Convert5_q : std_logic_vector(0 downto 0);
    signal cStage_uid942_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal rightShiftStage1Idx1_uid988_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage1Idx2_uid992_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage1Idx3_uid996_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage1Idx1_uid1030_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal rightShiftStage1Idx2_uid1034_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal rightShiftStage1Idx3_uid1038_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal y_uid180_Convert_in : std_logic_vector (31 downto 0);
    signal y_uid180_Convert_b : std_logic_vector (31 downto 0);
    signal y_uid210_Convert1_in : std_logic_vector (31 downto 0);
    signal y_uid210_Convert1_b : std_logic_vector (31 downto 0);
    signal y_uid240_Convert2_in : std_logic_vector (31 downto 0);
    signal y_uid240_Convert2_b : std_logic_vector (31 downto 0);
    signal y_uid270_Convert3_in : std_logic_vector (31 downto 0);
    signal y_uid270_Convert3_b : std_logic_vector (31 downto 0);
    signal y_uid300_Convert4_in : std_logic_vector (31 downto 0);
    signal y_uid300_Convert4_b : std_logic_vector (31 downto 0);
    signal y_uid330_Convert5_in : std_logic_vector (31 downto 0);
    signal y_uid330_Convert5_b : std_logic_vector (31 downto 0);
    signal rightPaddedIn_uid76_Acc_q : std_logic_vector (61 downto 0);
    signal rightPaddedIn_uid132_Acc1_q : std_logic_vector (61 downto 0);
    signal yAddrPEvenOdd_uid453_RecipSqRt_q : std_logic_vector (8 downto 0);
    signal accumulatorSign_uid86_Acc_in : std_logic_vector (46 downto 0);
    signal accumulatorSign_uid86_Acc_b : std_logic_vector (0 downto 0);
    signal accOverflowBitMSB_uid87_Acc_in : std_logic_vector (47 downto 0);
    signal accOverflowBitMSB_uid87_Acc_b : std_logic_vector (0 downto 0);
    signal accValidRange_uid90_Acc_in : std_logic_vector (46 downto 0);
    signal accValidRange_uid90_Acc_b : std_logic_vector (46 downto 0);
    signal accumulatorSign_uid142_Acc1_in : std_logic_vector (46 downto 0);
    signal accumulatorSign_uid142_Acc1_b : std_logic_vector (0 downto 0);
    signal accOverflowBitMSB_uid143_Acc1_in : std_logic_vector (47 downto 0);
    signal accOverflowBitMSB_uid143_Acc1_b : std_logic_vector (0 downto 0);
    signal accValidRange_uid146_Acc1_in : std_logic_vector (46 downto 0);
    signal accValidRange_uid146_Acc1_b : std_logic_vector (46 downto 0);
    signal InvExc_I_uid443_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal InvExc_I_uid443_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal exc_N_uid441_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal exc_N_uid441_RecipSqRt_b : std_logic_vector(0 downto 0);
    signal exc_N_uid441_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal cstSel_uid459_RecipSqRt_s : std_logic_vector (1 downto 0);
    signal cstSel_uid459_RecipSqRt_q : std_logic_vector (7 downto 0);
    signal sumAHighB_uid1063_invSqrtPolyEval_a : std_logic_vector(21 downto 0);
    signal sumAHighB_uid1063_invSqrtPolyEval_b : std_logic_vector(21 downto 0);
    signal sumAHighB_uid1063_invSqrtPolyEval_o : std_logic_vector (21 downto 0);
    signal sumAHighB_uid1063_invSqrtPolyEval_q : std_logic_vector (21 downto 0);
    signal sumAHighB_uid1069_invSqrtPolyEval_a : std_logic_vector(30 downto 0);
    signal sumAHighB_uid1069_invSqrtPolyEval_b : std_logic_vector(30 downto 0);
    signal sumAHighB_uid1069_invSqrtPolyEval_o : std_logic_vector (30 downto 0);
    signal sumAHighB_uid1069_invSqrtPolyEval_q : std_logic_vector (30 downto 0);
    signal fracR_uid189_Convert_in : std_logic_vector (23 downto 0);
    signal fracR_uid189_Convert_b : std_logic_vector (22 downto 0);
    signal expR_uid190_Convert_in : std_logic_vector (33 downto 0);
    signal expR_uid190_Convert_b : std_logic_vector (9 downto 0);
    signal fracR_uid219_Convert1_in : std_logic_vector (23 downto 0);
    signal fracR_uid219_Convert1_b : std_logic_vector (22 downto 0);
    signal expR_uid220_Convert1_in : std_logic_vector (33 downto 0);
    signal expR_uid220_Convert1_b : std_logic_vector (9 downto 0);
    signal fracR_uid249_Convert2_in : std_logic_vector (23 downto 0);
    signal fracR_uid249_Convert2_b : std_logic_vector (22 downto 0);
    signal expR_uid250_Convert2_in : std_logic_vector (33 downto 0);
    signal expR_uid250_Convert2_b : std_logic_vector (9 downto 0);
    signal fracR_uid279_Convert3_in : std_logic_vector (23 downto 0);
    signal fracR_uid279_Convert3_b : std_logic_vector (22 downto 0);
    signal expR_uid280_Convert3_in : std_logic_vector (33 downto 0);
    signal expR_uid280_Convert3_b : std_logic_vector (9 downto 0);
    signal fracR_uid309_Convert4_in : std_logic_vector (23 downto 0);
    signal fracR_uid309_Convert4_b : std_logic_vector (22 downto 0);
    signal expR_uid310_Convert4_in : std_logic_vector (33 downto 0);
    signal expR_uid310_Convert4_b : std_logic_vector (9 downto 0);
    signal fracR_uid339_Convert5_in : std_logic_vector (23 downto 0);
    signal fracR_uid339_Convert5_b : std_logic_vector (22 downto 0);
    signal expR_uid340_Convert5_in : std_logic_vector (33 downto 0);
    signal expR_uid340_Convert5_b : std_logic_vector (9 downto 0);
    signal finalOut_uid388_Convert7_s : std_logic_vector (1 downto 0);
    signal finalOut_uid388_Convert7_q : std_logic_vector (31 downto 0);
    signal finalOut_uid421_Convert8_s : std_logic_vector (1 downto 0);
    signal finalOut_uid421_Convert8_q : std_logic_vector (31 downto 0);
    signal outRes_uid204_Convert_q : std_logic_vector (31 downto 0);
    signal outRes_uid234_Convert1_q : std_logic_vector (31 downto 0);
    signal outRes_uid264_Convert2_q : std_logic_vector (31 downto 0);
    signal outRes_uid294_Convert3_q : std_logic_vector (31 downto 0);
    signal outRes_uid324_Convert4_q : std_logic_vector (31 downto 0);
    signal outRes_uid354_Convert5_q : std_logic_vector (31 downto 0);
    signal rVStage_uid532_zeroCounter_uid94_Acc_in : std_logic_vector (7 downto 0);
    signal rVStage_uid532_zeroCounter_uid94_Acc_b : std_logic_vector (3 downto 0);
    signal vStage_uid534_zeroCounter_uid94_Acc_in : std_logic_vector (3 downto 0);
    signal vStage_uid534_zeroCounter_uid94_Acc_b : std_logic_vector (3 downto 0);
    signal r_uid546_zeroCounter_uid94_Acc_q : std_logic_vector (5 downto 0);
    signal rVStage_uid641_zeroCounter_uid150_Acc1_in : std_logic_vector (7 downto 0);
    signal rVStage_uid641_zeroCounter_uid150_Acc1_b : std_logic_vector (3 downto 0);
    signal vStage_uid643_zeroCounter_uid150_Acc1_in : std_logic_vector (3 downto 0);
    signal vStage_uid643_zeroCounter_uid150_Acc1_b : std_logic_vector (3 downto 0);
    signal r_uid655_zeroCounter_uid150_Acc1_q : std_logic_vector (5 downto 0);
    signal vStagei_uid708_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vStagei_uid708_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vStagei_uid755_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid755_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vStagei_uid802_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vStagei_uid802_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vStagei_uid849_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vStagei_uid849_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vStagei_uid896_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vStagei_uid896_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vStagei_uid943_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vStagei_uid943_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_s : std_logic_vector (1 downto 0);
    signal rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_s : std_logic_vector (1 downto 0);
    signal rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal vCount_uid692_lzcShifterZ1_uid181_Convert_a : std_logic_vector(31 downto 0);
    signal vCount_uid692_lzcShifterZ1_uid181_Convert_b : std_logic_vector(31 downto 0);
    signal vCount_uid692_lzcShifterZ1_uid181_Convert_q : std_logic_vector(0 downto 0);
    signal vStagei_uid694_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vStagei_uid694_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCount_uid739_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(31 downto 0);
    signal vCount_uid739_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(31 downto 0);
    signal vCount_uid739_lzcShifterZ1_uid211_Convert1_q : std_logic_vector(0 downto 0);
    signal vStagei_uid741_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid741_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCount_uid786_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(31 downto 0);
    signal vCount_uid786_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(31 downto 0);
    signal vCount_uid786_lzcShifterZ1_uid241_Convert2_q : std_logic_vector(0 downto 0);
    signal vStagei_uid788_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vStagei_uid788_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCount_uid833_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(31 downto 0);
    signal vCount_uid833_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(31 downto 0);
    signal vCount_uid833_lzcShifterZ1_uid271_Convert3_q : std_logic_vector(0 downto 0);
    signal vStagei_uid835_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vStagei_uid835_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCount_uid880_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(31 downto 0);
    signal vCount_uid880_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(31 downto 0);
    signal vCount_uid880_lzcShifterZ1_uid301_Convert4_q : std_logic_vector(0 downto 0);
    signal vStagei_uid882_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vStagei_uid882_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCount_uid927_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(31 downto 0);
    signal vCount_uid927_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(31 downto 0);
    signal vCount_uid927_lzcShifterZ1_uid331_Convert5_q : std_logic_vector(0 downto 0);
    signal vStagei_uid929_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vStagei_uid929_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal X61dto16_uid475_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal X61dto16_uid475_alignmentShifter_uid75_Acc_b : std_logic_vector (45 downto 0);
    signal X61dto32_uid478_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal X61dto32_uid478_alignmentShifter_uid75_Acc_b : std_logic_vector (29 downto 0);
    signal X61dto48_uid481_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal X61dto48_uid481_alignmentShifter_uid75_Acc_b : std_logic_vector (13 downto 0);
    signal X61dto16_uid584_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal X61dto16_uid584_alignmentShifter_uid131_Acc1_b : std_logic_vector (45 downto 0);
    signal X61dto32_uid587_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal X61dto32_uid587_alignmentShifter_uid131_Acc1_b : std_logic_vector (29 downto 0);
    signal X61dto48_uid590_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal X61dto48_uid590_alignmentShifter_uid131_Acc1_b : std_logic_vector (13 downto 0);
    signal accOverflow_uid89_Acc_a : std_logic_vector(0 downto 0);
    signal accOverflow_uid89_Acc_b : std_logic_vector(0 downto 0);
    signal accOverflow_uid89_Acc_q : std_logic_vector(0 downto 0);
    signal accOnesComplement_uid91_Acc_a : std_logic_vector(46 downto 0);
    signal accOnesComplement_uid91_Acc_b : std_logic_vector(46 downto 0);
    signal accOnesComplement_uid91_Acc_q : std_logic_vector(46 downto 0);
    signal accValuePositive_uid92_Acc_a : std_logic_vector(47 downto 0);
    signal accValuePositive_uid92_Acc_b : std_logic_vector(47 downto 0);
    signal accValuePositive_uid92_Acc_o : std_logic_vector (47 downto 0);
    signal accValuePositive_uid92_Acc_q : std_logic_vector (47 downto 0);
    signal accOverflow_uid145_Acc1_a : std_logic_vector(0 downto 0);
    signal accOverflow_uid145_Acc1_b : std_logic_vector(0 downto 0);
    signal accOverflow_uid145_Acc1_q : std_logic_vector(0 downto 0);
    signal accOnesComplement_uid147_Acc1_a : std_logic_vector(46 downto 0);
    signal accOnesComplement_uid147_Acc1_b : std_logic_vector(46 downto 0);
    signal accOnesComplement_uid147_Acc1_q : std_logic_vector(46 downto 0);
    signal accValuePositive_uid148_Acc1_a : std_logic_vector(47 downto 0);
    signal accValuePositive_uid148_Acc1_b : std_logic_vector(47 downto 0);
    signal accValuePositive_uid148_Acc1_o : std_logic_vector (47 downto 0);
    signal accValuePositive_uid148_Acc1_q : std_logic_vector (47 downto 0);
    signal InvExc_N_uid442_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal InvExc_N_uid442_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal expRExt_uid461_RecipSqRt_a : std_logic_vector(8 downto 0);
    signal expRExt_uid461_RecipSqRt_b : std_logic_vector(8 downto 0);
    signal expRExt_uid461_RecipSqRt_o : std_logic_vector (8 downto 0);
    signal expRExt_uid461_RecipSqRt_q : std_logic_vector (8 downto 0);
    signal s1_uid1061_uid1064_invSqrtPolyEval_q : std_logic_vector (22 downto 0);
    signal s2_uid1067_uid1070_invSqrtPolyEval_q : std_logic_vector (32 downto 0);
    signal expR_uid202_Convert_in : std_logic_vector (7 downto 0);
    signal expR_uid202_Convert_b : std_logic_vector (7 downto 0);
    signal expR_uid232_Convert1_in : std_logic_vector (7 downto 0);
    signal expR_uid232_Convert1_b : std_logic_vector (7 downto 0);
    signal expR_uid262_Convert2_in : std_logic_vector (7 downto 0);
    signal expR_uid262_Convert2_b : std_logic_vector (7 downto 0);
    signal expR_uid292_Convert3_in : std_logic_vector (7 downto 0);
    signal expR_uid292_Convert3_b : std_logic_vector (7 downto 0);
    signal expR_uid322_Convert4_in : std_logic_vector (7 downto 0);
    signal expR_uid322_Convert4_b : std_logic_vector (7 downto 0);
    signal expR_uid352_Convert5_in : std_logic_vector (7 downto 0);
    signal expR_uid352_Convert5_b : std_logic_vector (7 downto 0);
    signal vCount_uid533_zeroCounter_uid94_Acc_a : std_logic_vector(3 downto 0);
    signal vCount_uid533_zeroCounter_uid94_Acc_b : std_logic_vector(3 downto 0);
    signal vCount_uid533_zeroCounter_uid94_Acc_q : std_logic_vector(0 downto 0);
    signal vStagei_uid536_zeroCounter_uid94_Acc_s : std_logic_vector (0 downto 0);
    signal vStagei_uid536_zeroCounter_uid94_Acc_q : std_logic_vector (3 downto 0);
    signal accResOutOfExpRange_uid96_Acc_a : std_logic_vector(5 downto 0);
    signal accResOutOfExpRange_uid96_Acc_b : std_logic_vector(5 downto 0);
    signal accResOutOfExpRange_uid96_Acc_q : std_logic_vector(0 downto 0);
    signal resExpSub_uid100_Acc_a : std_logic_vector(9 downto 0);
    signal resExpSub_uid100_Acc_b : std_logic_vector(9 downto 0);
    signal resExpSub_uid100_Acc_o : std_logic_vector (9 downto 0);
    signal resExpSub_uid100_Acc_q : std_logic_vector (9 downto 0);
    signal leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc_in : std_logic_vector (5 downto 0);
    signal leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc_b : std_logic_vector (1 downto 0);
    signal leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc_in : std_logic_vector (3 downto 0);
    signal leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc_b : std_logic_vector (1 downto 0);
    signal leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc_in : std_logic_vector (1 downto 0);
    signal leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc_b : std_logic_vector (1 downto 0);
    signal vCount_uid642_zeroCounter_uid150_Acc1_a : std_logic_vector(3 downto 0);
    signal vCount_uid642_zeroCounter_uid150_Acc1_b : std_logic_vector(3 downto 0);
    signal vCount_uid642_zeroCounter_uid150_Acc1_q : std_logic_vector(0 downto 0);
    signal vStagei_uid645_zeroCounter_uid150_Acc1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid645_zeroCounter_uid150_Acc1_q : std_logic_vector (3 downto 0);
    signal accResOutOfExpRange_uid152_Acc1_a : std_logic_vector(5 downto 0);
    signal accResOutOfExpRange_uid152_Acc1_b : std_logic_vector(5 downto 0);
    signal accResOutOfExpRange_uid152_Acc1_q : std_logic_vector(0 downto 0);
    signal resExpSub_uid156_Acc1_a : std_logic_vector(9 downto 0);
    signal resExpSub_uid156_Acc1_b : std_logic_vector(9 downto 0);
    signal resExpSub_uid156_Acc1_o : std_logic_vector (9 downto 0);
    signal resExpSub_uid156_Acc1_q : std_logic_vector (9 downto 0);
    signal leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1_in : std_logic_vector (5 downto 0);
    signal leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1_b : std_logic_vector (1 downto 0);
    signal leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1_in : std_logic_vector (3 downto 0);
    signal leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1_b : std_logic_vector (1 downto 0);
    signal leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1_in : std_logic_vector (1 downto 0);
    signal leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1_b : std_logic_vector (1 downto 0);
    signal rVStage_uid710_lzcShifterZ1_uid181_Convert_in : std_logic_vector (31 downto 0);
    signal rVStage_uid710_lzcShifterZ1_uid181_Convert_b : std_logic_vector (3 downto 0);
    signal vStage_uid713_lzcShifterZ1_uid181_Convert_in : std_logic_vector (27 downto 0);
    signal vStage_uid713_lzcShifterZ1_uid181_Convert_b : std_logic_vector (27 downto 0);
    signal rVStage_uid757_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (31 downto 0);
    signal rVStage_uid757_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (3 downto 0);
    signal vStage_uid760_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (27 downto 0);
    signal vStage_uid760_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (27 downto 0);
    signal rVStage_uid804_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (31 downto 0);
    signal rVStage_uid804_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (3 downto 0);
    signal vStage_uid807_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (27 downto 0);
    signal vStage_uid807_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (27 downto 0);
    signal rVStage_uid851_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (31 downto 0);
    signal rVStage_uid851_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (3 downto 0);
    signal vStage_uid854_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (27 downto 0);
    signal vStage_uid854_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (27 downto 0);
    signal rVStage_uid898_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (31 downto 0);
    signal rVStage_uid898_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (3 downto 0);
    signal vStage_uid901_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (27 downto 0);
    signal vStage_uid901_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (27 downto 0);
    signal rVStage_uid945_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (31 downto 0);
    signal rVStage_uid945_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (3 downto 0);
    signal vStage_uid948_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (27 downto 0);
    signal vStage_uid948_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (27 downto 0);
    signal RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (31 downto 0);
    signal RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (30 downto 0);
    signal RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (29 downto 0);
    signal RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (31 downto 0);
    signal RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (30 downto 0);
    signal RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (29 downto 0);
    signal rVStage_uid696_lzcShifterZ1_uid181_Convert_in : std_logic_vector (31 downto 0);
    signal rVStage_uid696_lzcShifterZ1_uid181_Convert_b : std_logic_vector (15 downto 0);
    signal vStage_uid699_lzcShifterZ1_uid181_Convert_in : std_logic_vector (15 downto 0);
    signal vStage_uid699_lzcShifterZ1_uid181_Convert_b : std_logic_vector (15 downto 0);
    signal rVStage_uid743_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (31 downto 0);
    signal rVStage_uid743_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (15 downto 0);
    signal vStage_uid746_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (15 downto 0);
    signal vStage_uid746_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (15 downto 0);
    signal rVStage_uid790_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (31 downto 0);
    signal rVStage_uid790_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (15 downto 0);
    signal vStage_uid793_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (15 downto 0);
    signal vStage_uid793_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (15 downto 0);
    signal rVStage_uid837_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (31 downto 0);
    signal rVStage_uid837_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (15 downto 0);
    signal vStage_uid840_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (15 downto 0);
    signal vStage_uid840_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (15 downto 0);
    signal rVStage_uid884_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (31 downto 0);
    signal rVStage_uid884_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (15 downto 0);
    signal vStage_uid887_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (15 downto 0);
    signal vStage_uid887_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (15 downto 0);
    signal rVStage_uid931_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (31 downto 0);
    signal rVStage_uid931_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (15 downto 0);
    signal vStage_uid934_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (15 downto 0);
    signal vStage_uid934_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (15 downto 0);
    signal rightShiftStage0Idx1_uid477_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage0Idx2_uid480_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage0Idx3_uid483_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage0Idx1_uid586_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rightShiftStage0Idx2_uid589_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rightShiftStage0Idx3_uid592_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal oRAccOverflowFlagFeedback_uid117_Acc_a : std_logic_vector(0 downto 0);
    signal oRAccOverflowFlagFeedback_uid117_Acc_b : std_logic_vector(0 downto 0);
    signal oRAccOverflowFlagFeedback_uid117_Acc_q : std_logic_vector(0 downto 0);
    signal posAccWoLeadingZeroBit_uid93_Acc_in : std_logic_vector (45 downto 0);
    signal posAccWoLeadingZeroBit_uid93_Acc_b : std_logic_vector (45 downto 0);
    signal X31dto0_uid550_normalizationShifter_uid97_Acc_in : std_logic_vector (31 downto 0);
    signal X31dto0_uid550_normalizationShifter_uid97_Acc_b : std_logic_vector (31 downto 0);
    signal X15dto0_uid553_normalizationShifter_uid97_Acc_in : std_logic_vector (15 downto 0);
    signal X15dto0_uid553_normalizationShifter_uid97_Acc_b : std_logic_vector (15 downto 0);
    signal oRAccOverflowFlagFeedback_uid173_Acc1_a : std_logic_vector(0 downto 0);
    signal oRAccOverflowFlagFeedback_uid173_Acc1_b : std_logic_vector(0 downto 0);
    signal oRAccOverflowFlagFeedback_uid173_Acc1_q : std_logic_vector(0 downto 0);
    signal posAccWoLeadingZeroBit_uid149_Acc1_in : std_logic_vector (45 downto 0);
    signal posAccWoLeadingZeroBit_uid149_Acc1_b : std_logic_vector (45 downto 0);
    signal X31dto0_uid659_normalizationShifter_uid153_Acc1_in : std_logic_vector (31 downto 0);
    signal X31dto0_uid659_normalizationShifter_uid153_Acc1_b : std_logic_vector (31 downto 0);
    signal X15dto0_uid662_normalizationShifter_uid153_Acc1_in : std_logic_vector (15 downto 0);
    signal X15dto0_uid662_normalizationShifter_uid153_Acc1_b : std_logic_vector (15 downto 0);
    signal exc_R_uid445_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal exc_R_uid445_RecipSqRt_b : std_logic_vector(0 downto 0);
    signal exc_R_uid445_RecipSqRt_c : std_logic_vector(0 downto 0);
    signal exc_R_uid445_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal expR_uid462_RecipSqRt_in : std_logic_vector (7 downto 0);
    signal expR_uid462_RecipSqRt_b : std_logic_vector (7 downto 0);
    signal fxpInvSqrtRes_uid456_RecipSqRt_in : std_logic_vector (29 downto 0);
    signal fxpInvSqrtRes_uid456_RecipSqRt_b : std_logic_vector (23 downto 0);
    signal rVStage_uid538_zeroCounter_uid94_Acc_in : std_logic_vector (3 downto 0);
    signal rVStage_uid538_zeroCounter_uid94_Acc_b : std_logic_vector (1 downto 0);
    signal vStage_uid540_zeroCounter_uid94_Acc_in : std_logic_vector (1 downto 0);
    signal vStage_uid540_zeroCounter_uid94_Acc_b : std_logic_vector (1 downto 0);
    signal finalExponent_uid101_Acc_in : std_logic_vector (7 downto 0);
    signal finalExponent_uid101_Acc_b : std_logic_vector (7 downto 0);
    signal leftShiftStage0_uid557_normalizationShifter_uid97_Acc_s : std_logic_vector (1 downto 0);
    signal leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal rVStage_uid647_zeroCounter_uid150_Acc1_in : std_logic_vector (3 downto 0);
    signal rVStage_uid647_zeroCounter_uid150_Acc1_b : std_logic_vector (1 downto 0);
    signal vStage_uid649_zeroCounter_uid150_Acc1_in : std_logic_vector (1 downto 0);
    signal vStage_uid649_zeroCounter_uid150_Acc1_b : std_logic_vector (1 downto 0);
    signal finalExponent_uid157_Acc1_in : std_logic_vector (7 downto 0);
    signal finalExponent_uid157_Acc1_b : std_logic_vector (7 downto 0);
    signal leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_s : std_logic_vector (1 downto 0);
    signal leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal vCount_uid711_lzcShifterZ1_uid181_Convert_a : std_logic_vector(3 downto 0);
    signal vCount_uid711_lzcShifterZ1_uid181_Convert_b : std_logic_vector(3 downto 0);
    signal vCount_uid711_lzcShifterZ1_uid181_Convert_q : std_logic_vector(0 downto 0);
    signal cStage_uid714_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCount_uid758_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(3 downto 0);
    signal vCount_uid758_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(3 downto 0);
    signal vCount_uid758_lzcShifterZ1_uid211_Convert1_q : std_logic_vector(0 downto 0);
    signal cStage_uid761_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCount_uid805_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(3 downto 0);
    signal vCount_uid805_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(3 downto 0);
    signal vCount_uid805_lzcShifterZ1_uid241_Convert2_q : std_logic_vector(0 downto 0);
    signal cStage_uid808_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCount_uid852_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(3 downto 0);
    signal vCount_uid852_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(3 downto 0);
    signal vCount_uid852_lzcShifterZ1_uid271_Convert3_q : std_logic_vector(0 downto 0);
    signal cStage_uid855_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCount_uid899_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(3 downto 0);
    signal vCount_uid899_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(3 downto 0);
    signal vCount_uid899_lzcShifterZ1_uid301_Convert4_q : std_logic_vector(0 downto 0);
    signal cStage_uid902_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCount_uid946_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(3 downto 0);
    signal vCount_uid946_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(3 downto 0);
    signal vCount_uid946_lzcShifterZ1_uid331_Convert5_q : std_logic_vector(0 downto 0);
    signal cStage_uid949_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal rightShiftStage2Idx1_uid1002_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage2Idx2_uid1006_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage2Idx3_uid1010_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage2Idx1_uid1044_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal rightShiftStage2Idx2_uid1048_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal rightShiftStage2Idx3_uid1052_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal cStage_uid700_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal cStage_uid747_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal cStage_uid794_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal cStage_uid841_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal cStage_uid888_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal cStage_uid935_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal rightShiftStage0_uid485_alignmentShifter_uid75_Acc_s : std_logic_vector (1 downto 0);
    signal rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_s : std_logic_vector (1 downto 0);
    signal rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal muxAccOverflowFeedbackSignal_uid116_Acc_s : std_logic_vector (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid116_Acc_q : std_logic_vector (0 downto 0);
    signal rVStage_uid512_zeroCounter_uid94_Acc_in : std_logic_vector (45 downto 0);
    signal rVStage_uid512_zeroCounter_uid94_Acc_b : std_logic_vector (31 downto 0);
    signal vStage_uid515_zeroCounter_uid94_Acc_in : std_logic_vector (13 downto 0);
    signal vStage_uid515_zeroCounter_uid94_Acc_b : std_logic_vector (13 downto 0);
    signal muxAccOverflowFeedbackSignal_uid172_Acc1_s : std_logic_vector (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid172_Acc1_q : std_logic_vector (0 downto 0);
    signal rVStage_uid621_zeroCounter_uid150_Acc1_in : std_logic_vector (45 downto 0);
    signal rVStage_uid621_zeroCounter_uid150_Acc1_b : std_logic_vector (31 downto 0);
    signal vStage_uid624_zeroCounter_uid150_Acc1_in : std_logic_vector (13 downto 0);
    signal vStage_uid624_zeroCounter_uid150_Acc1_b : std_logic_vector (13 downto 0);
    signal xRegNeg_uid464_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal xRegNeg_uid464_RecipSqRt_b : std_logic_vector(0 downto 0);
    signal xRegNeg_uid464_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal fxpInverseResFrac_uid463_RecipSqRt_in : std_logic_vector (22 downto 0);
    signal fxpInverseResFrac_uid463_RecipSqRt_b : std_logic_vector (22 downto 0);
    signal finalExpUpdated_uid102_Acc_s : std_logic_vector (0 downto 0);
    signal finalExpUpdated_uid102_Acc_q : std_logic_vector (7 downto 0);
    signal LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc_in : std_logic_vector (43 downto 0);
    signal LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc_b : std_logic_vector (43 downto 0);
    signal LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc_in : std_logic_vector (39 downto 0);
    signal LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc_b : std_logic_vector (39 downto 0);
    signal LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc_in : std_logic_vector (35 downto 0);
    signal LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc_b : std_logic_vector (35 downto 0);
    signal finalExpUpdated_uid158_Acc1_s : std_logic_vector (0 downto 0);
    signal finalExpUpdated_uid158_Acc1_q : std_logic_vector (7 downto 0);
    signal LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1_in : std_logic_vector (43 downto 0);
    signal LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1_b : std_logic_vector (43 downto 0);
    signal LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1_in : std_logic_vector (39 downto 0);
    signal LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1_b : std_logic_vector (39 downto 0);
    signal LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1_in : std_logic_vector (35 downto 0);
    signal LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1_b : std_logic_vector (35 downto 0);
    signal vStagei_uid715_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vStagei_uid715_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vStagei_uid762_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid762_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vStagei_uid809_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vStagei_uid809_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vStagei_uid856_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vStagei_uid856_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vStagei_uid903_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vStagei_uid903_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vStagei_uid950_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vStagei_uid950_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_s : std_logic_vector (1 downto 0);
    signal rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_s : std_logic_vector (1 downto 0);
    signal rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc_b : std_logic_vector (57 downto 0);
    signal RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc_b : std_logic_vector (53 downto 0);
    signal RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc_b : std_logic_vector (49 downto 0);
    signal RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1_b : std_logic_vector (57 downto 0);
    signal RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1_b : std_logic_vector (53 downto 0);
    signal RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1_b : std_logic_vector (49 downto 0);
    signal vCount_uid513_zeroCounter_uid94_Acc_a : std_logic_vector(31 downto 0);
    signal vCount_uid513_zeroCounter_uid94_Acc_b : std_logic_vector(31 downto 0);
    signal vCount_uid513_zeroCounter_uid94_Acc_q : std_logic_vector(0 downto 0);
    signal cStage_uid516_zeroCounter_uid94_Acc_q : std_logic_vector (31 downto 0);
    signal vCount_uid622_zeroCounter_uid150_Acc1_a : std_logic_vector(31 downto 0);
    signal vCount_uid622_zeroCounter_uid150_Acc1_b : std_logic_vector(31 downto 0);
    signal vCount_uid622_zeroCounter_uid150_Acc1_q : std_logic_vector(0 downto 0);
    signal cStage_uid625_zeroCounter_uid150_Acc1_q : std_logic_vector (31 downto 0);
    signal xNOxRNeg_uid465_RecipSqRt_a : std_logic_vector(0 downto 0);
    signal xNOxRNeg_uid465_RecipSqRt_b : std_logic_vector(0 downto 0);
    signal xNOxRNeg_uid465_RecipSqRt_q : std_logic_vector(0 downto 0);
    signal fracRPostExc_uid468_RecipSqRt_s : std_logic_vector (1 downto 0);
    signal fracRPostExc_uid468_RecipSqRt_q : std_logic_vector (22 downto 0);
    signal leftShiftStage1Idx1_uid560_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage1Idx2_uid563_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage1Idx3_uid566_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage1Idx1_uid669_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal leftShiftStage1Idx2_uid672_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal leftShiftStage1Idx3_uid675_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal rVStage_uid717_lzcShifterZ1_uid181_Convert_in : std_logic_vector (31 downto 0);
    signal rVStage_uid717_lzcShifterZ1_uid181_Convert_b : std_logic_vector (1 downto 0);
    signal vStage_uid720_lzcShifterZ1_uid181_Convert_in : std_logic_vector (29 downto 0);
    signal vStage_uid720_lzcShifterZ1_uid181_Convert_b : std_logic_vector (29 downto 0);
    signal rVStage_uid764_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (31 downto 0);
    signal rVStage_uid764_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (1 downto 0);
    signal vStage_uid767_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (29 downto 0);
    signal vStage_uid767_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (29 downto 0);
    signal rVStage_uid811_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (31 downto 0);
    signal rVStage_uid811_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (1 downto 0);
    signal vStage_uid814_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (29 downto 0);
    signal vStage_uid814_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (29 downto 0);
    signal rVStage_uid858_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (31 downto 0);
    signal rVStage_uid858_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (1 downto 0);
    signal vStage_uid861_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (29 downto 0);
    signal vStage_uid861_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (29 downto 0);
    signal rVStage_uid905_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (31 downto 0);
    signal rVStage_uid905_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (1 downto 0);
    signal vStage_uid908_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (29 downto 0);
    signal vStage_uid908_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (29 downto 0);
    signal rVStage_uid952_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (31 downto 0);
    signal rVStage_uid952_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (1 downto 0);
    signal vStage_uid955_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (29 downto 0);
    signal vStage_uid955_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (29 downto 0);
    signal zRightShiferNoStickyOut_uid374_Convert7_q : std_logic_vector (33 downto 0);
    signal zRightShiferNoStickyOut_uid407_Convert8_q : std_logic_vector (33 downto 0);
    signal rightShiftStage1Idx1_uid488_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage1Idx2_uid491_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage1Idx3_uid494_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage1Idx1_uid597_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rightShiftStage1Idx2_uid600_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rightShiftStage1Idx3_uid603_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal vStagei_uid518_zeroCounter_uid94_Acc_s : std_logic_vector (0 downto 0);
    signal vStagei_uid518_zeroCounter_uid94_Acc_q : std_logic_vector (31 downto 0);
    signal vStagei_uid627_zeroCounter_uid150_Acc1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid627_zeroCounter_uid150_Acc1_q : std_logic_vector (31 downto 0);
    signal excRConc_uid466_RecipSqRt_q : std_logic_vector (2 downto 0);
    signal R_uid470_RecipSqRt_q : std_logic_vector (31 downto 0);
    signal leftShiftStage1_uid568_normalizationShifter_uid97_Acc_s : std_logic_vector (1 downto 0);
    signal leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_s : std_logic_vector (1 downto 0);
    signal leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal vCount_uid718_lzcShifterZ1_uid181_Convert_a : std_logic_vector(1 downto 0);
    signal vCount_uid718_lzcShifterZ1_uid181_Convert_b : std_logic_vector(1 downto 0);
    signal vCount_uid718_lzcShifterZ1_uid181_Convert_q : std_logic_vector(0 downto 0);
    signal cStage_uid721_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCount_uid765_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(1 downto 0);
    signal vCount_uid765_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(1 downto 0);
    signal vCount_uid765_lzcShifterZ1_uid211_Convert1_q : std_logic_vector(0 downto 0);
    signal cStage_uid768_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCount_uid812_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(1 downto 0);
    signal vCount_uid812_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(1 downto 0);
    signal vCount_uid812_lzcShifterZ1_uid241_Convert2_q : std_logic_vector(0 downto 0);
    signal cStage_uid815_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCount_uid859_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(1 downto 0);
    signal vCount_uid859_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(1 downto 0);
    signal vCount_uid859_lzcShifterZ1_uid271_Convert3_q : std_logic_vector(0 downto 0);
    signal cStage_uid862_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCount_uid906_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(1 downto 0);
    signal vCount_uid906_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(1 downto 0);
    signal vCount_uid906_lzcShifterZ1_uid301_Convert4_q : std_logic_vector(0 downto 0);
    signal cStage_uid909_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCount_uid953_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(1 downto 0);
    signal vCount_uid953_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(1 downto 0);
    signal vCount_uid953_lzcShifterZ1_uid331_Convert5_q : std_logic_vector(0 downto 0);
    signal cStage_uid956_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal xXorSign_uid375_Convert7_a : std_logic_vector(33 downto 0);
    signal xXorSign_uid375_Convert7_b : std_logic_vector(33 downto 0);
    signal xXorSign_uid375_Convert7_q : std_logic_vector(33 downto 0);
    signal xXorSign_uid408_Convert8_a : std_logic_vector(33 downto 0);
    signal xXorSign_uid408_Convert8_b : std_logic_vector(33 downto 0);
    signal xXorSign_uid408_Convert8_q : std_logic_vector(33 downto 0);
    signal rightShiftStage1_uid496_alignmentShifter_uid75_Acc_s : std_logic_vector (1 downto 0);
    signal rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_s : std_logic_vector (1 downto 0);
    signal rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rVStage_uid520_zeroCounter_uid94_Acc_in : std_logic_vector (31 downto 0);
    signal rVStage_uid520_zeroCounter_uid94_Acc_b : std_logic_vector (15 downto 0);
    signal vStage_uid522_zeroCounter_uid94_Acc_in : std_logic_vector (15 downto 0);
    signal vStage_uid522_zeroCounter_uid94_Acc_b : std_logic_vector (15 downto 0);
    signal rVStage_uid629_zeroCounter_uid150_Acc1_in : std_logic_vector (31 downto 0);
    signal rVStage_uid629_zeroCounter_uid150_Acc1_b : std_logic_vector (15 downto 0);
    signal vStage_uid631_zeroCounter_uid150_Acc1_in : std_logic_vector (15 downto 0);
    signal vStage_uid631_zeroCounter_uid150_Acc1_b : std_logic_vector (15 downto 0);
    signal outMuxSelEnc_uid467_RecipSqRt_q : std_logic_vector(1 downto 0);
    signal LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc_in : std_logic_vector (46 downto 0);
    signal LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc_b : std_logic_vector (46 downto 0);
    signal LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc_in : std_logic_vector (45 downto 0);
    signal LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc_b : std_logic_vector (45 downto 0);
    signal LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc_in : std_logic_vector (44 downto 0);
    signal LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc_b : std_logic_vector (44 downto 0);
    signal LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1_in : std_logic_vector (46 downto 0);
    signal LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1_b : std_logic_vector (46 downto 0);
    signal LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1_in : std_logic_vector (45 downto 0);
    signal LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1_b : std_logic_vector (45 downto 0);
    signal LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1_in : std_logic_vector (44 downto 0);
    signal LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1_b : std_logic_vector (44 downto 0);
    signal vStagei_uid722_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vStagei_uid722_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vStagei_uid769_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid769_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vStagei_uid816_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vStagei_uid816_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vStagei_uid863_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vStagei_uid863_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vStagei_uid910_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vStagei_uid910_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vStagei_uid957_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vStagei_uid957_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal sPostRndFull_uid377_Convert7_a : std_logic_vector(34 downto 0);
    signal sPostRndFull_uid377_Convert7_b : std_logic_vector(34 downto 0);
    signal sPostRndFull_uid377_Convert7_o : std_logic_vector (34 downto 0);
    signal sPostRndFull_uid377_Convert7_q : std_logic_vector (34 downto 0);
    signal sPostRndFull_uid410_Convert8_a : std_logic_vector(34 downto 0);
    signal sPostRndFull_uid410_Convert8_b : std_logic_vector(34 downto 0);
    signal sPostRndFull_uid410_Convert8_o : std_logic_vector (34 downto 0);
    signal sPostRndFull_uid410_Convert8_q : std_logic_vector (34 downto 0);
    signal RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc_b : std_logic_vector (60 downto 0);
    signal RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc_b : std_logic_vector (59 downto 0);
    signal RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc_in : std_logic_vector (61 downto 0);
    signal RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc_b : std_logic_vector (58 downto 0);
    signal RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1_b : std_logic_vector (60 downto 0);
    signal RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1_b : std_logic_vector (59 downto 0);
    signal RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1_in : std_logic_vector (61 downto 0);
    signal RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1_b : std_logic_vector (58 downto 0);
    signal expRPostExc_uid469_RecipSqRt_s : std_logic_vector (1 downto 0);
    signal expRPostExc_uid469_RecipSqRt_q : std_logic_vector (7 downto 0);
    signal leftShiftStage2Idx1_uid571_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage2Idx2_uid574_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage2Idx3_uid577_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage2Idx1_uid680_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal leftShiftStage2Idx2_uid683_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal leftShiftStage2Idx3_uid686_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal rVStage_uid724_lzcShifterZ1_uid181_Convert_in : std_logic_vector (31 downto 0);
    signal rVStage_uid724_lzcShifterZ1_uid181_Convert_b : std_logic_vector (0 downto 0);
    signal vStage_uid727_lzcShifterZ1_uid181_Convert_in : std_logic_vector (30 downto 0);
    signal vStage_uid727_lzcShifterZ1_uid181_Convert_b : std_logic_vector (30 downto 0);
    signal rVStage_uid771_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (31 downto 0);
    signal rVStage_uid771_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (0 downto 0);
    signal vStage_uid774_lzcShifterZ1_uid211_Convert1_in : std_logic_vector (30 downto 0);
    signal vStage_uid774_lzcShifterZ1_uid211_Convert1_b : std_logic_vector (30 downto 0);
    signal rVStage_uid818_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (31 downto 0);
    signal rVStage_uid818_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (0 downto 0);
    signal vStage_uid821_lzcShifterZ1_uid241_Convert2_in : std_logic_vector (30 downto 0);
    signal vStage_uid821_lzcShifterZ1_uid241_Convert2_b : std_logic_vector (30 downto 0);
    signal rVStage_uid865_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (31 downto 0);
    signal rVStage_uid865_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (0 downto 0);
    signal vStage_uid868_lzcShifterZ1_uid271_Convert3_in : std_logic_vector (30 downto 0);
    signal vStage_uid868_lzcShifterZ1_uid271_Convert3_b : std_logic_vector (30 downto 0);
    signal rVStage_uid912_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (31 downto 0);
    signal rVStage_uid912_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (0 downto 0);
    signal vStage_uid915_lzcShifterZ1_uid301_Convert4_in : std_logic_vector (30 downto 0);
    signal vStage_uid915_lzcShifterZ1_uid301_Convert4_b : std_logic_vector (30 downto 0);
    signal rVStage_uid959_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (31 downto 0);
    signal rVStage_uid959_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (0 downto 0);
    signal vStage_uid962_lzcShifterZ1_uid331_Convert5_in : std_logic_vector (30 downto 0);
    signal vStage_uid962_lzcShifterZ1_uid331_Convert5_b : std_logic_vector (30 downto 0);
    signal sPostRnd_uid378_Convert7_in : std_logic_vector (32 downto 0);
    signal sPostRnd_uid378_Convert7_b : std_logic_vector (31 downto 0);
    signal sPostRndFullMSBU_uid379_Convert7_in : std_logic_vector (33 downto 0);
    signal sPostRndFullMSBU_uid379_Convert7_b : std_logic_vector (0 downto 0);
    signal sPostRndFullMSBU_uid380_Convert7_in : std_logic_vector (34 downto 0);
    signal sPostRndFullMSBU_uid380_Convert7_b : std_logic_vector (0 downto 0);
    signal sPostRnd_uid411_Convert8_in : std_logic_vector (32 downto 0);
    signal sPostRnd_uid411_Convert8_b : std_logic_vector (31 downto 0);
    signal sPostRndFullMSBU_uid412_Convert8_in : std_logic_vector (33 downto 0);
    signal sPostRndFullMSBU_uid412_Convert8_b : std_logic_vector (0 downto 0);
    signal sPostRndFullMSBU_uid413_Convert8_in : std_logic_vector (34 downto 0);
    signal sPostRndFullMSBU_uid413_Convert8_b : std_logic_vector (0 downto 0);
    signal rightShiftStage2Idx1_uid499_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage2Idx2_uid502_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage2Idx3_uid505_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage2Idx1_uid608_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rightShiftStage2Idx2_uid611_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal rightShiftStage2Idx3_uid614_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal leftShiftStage2_uid579_normalizationShifter_uid97_Acc_s : std_logic_vector (1 downto 0);
    signal leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q : std_logic_vector (47 downto 0);
    signal leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_s : std_logic_vector (1 downto 0);
    signal leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q : std_logic_vector (47 downto 0);
    signal vCount_uid725_lzcShifterZ1_uid181_Convert_a : std_logic_vector(0 downto 0);
    signal vCount_uid725_lzcShifterZ1_uid181_Convert_b : std_logic_vector(0 downto 0);
    signal vCount_uid725_lzcShifterZ1_uid181_Convert_q : std_logic_vector(0 downto 0);
    signal cStage_uid728_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCount_uid772_lzcShifterZ1_uid211_Convert1_a : std_logic_vector(0 downto 0);
    signal vCount_uid772_lzcShifterZ1_uid211_Convert1_b : std_logic_vector(0 downto 0);
    signal vCount_uid772_lzcShifterZ1_uid211_Convert1_q : std_logic_vector(0 downto 0);
    signal cStage_uid775_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCount_uid819_lzcShifterZ1_uid241_Convert2_a : std_logic_vector(0 downto 0);
    signal vCount_uid819_lzcShifterZ1_uid241_Convert2_b : std_logic_vector(0 downto 0);
    signal vCount_uid819_lzcShifterZ1_uid241_Convert2_q : std_logic_vector(0 downto 0);
    signal cStage_uid822_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCount_uid866_lzcShifterZ1_uid271_Convert3_a : std_logic_vector(0 downto 0);
    signal vCount_uid866_lzcShifterZ1_uid271_Convert3_b : std_logic_vector(0 downto 0);
    signal vCount_uid866_lzcShifterZ1_uid271_Convert3_q : std_logic_vector(0 downto 0);
    signal cStage_uid869_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCount_uid913_lzcShifterZ1_uid301_Convert4_a : std_logic_vector(0 downto 0);
    signal vCount_uid913_lzcShifterZ1_uid301_Convert4_b : std_logic_vector(0 downto 0);
    signal vCount_uid913_lzcShifterZ1_uid301_Convert4_q : std_logic_vector(0 downto 0);
    signal cStage_uid916_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCount_uid960_lzcShifterZ1_uid331_Convert5_a : std_logic_vector(0 downto 0);
    signal vCount_uid960_lzcShifterZ1_uid331_Convert5_b : std_logic_vector(0 downto 0);
    signal vCount_uid960_lzcShifterZ1_uid331_Convert5_q : std_logic_vector(0 downto 0);
    signal cStage_uid963_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal rightShiftStage2_uid507_alignmentShifter_uid75_Acc_s : std_logic_vector (1 downto 0);
    signal rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_s : std_logic_vector (1 downto 0);
    signal rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal fracR_uid103_Acc_in : std_logic_vector (44 downto 0);
    signal fracR_uid103_Acc_b : std_logic_vector (22 downto 0);
    signal fracR_uid159_Acc1_in : std_logic_vector (44 downto 0);
    signal fracR_uid159_Acc1_b : std_logic_vector (22 downto 0);
    signal vStagei_uid729_lzcShifterZ1_uid181_Convert_s : std_logic_vector (0 downto 0);
    signal vStagei_uid729_lzcShifterZ1_uid181_Convert_q : std_logic_vector (31 downto 0);
    signal vCount_uid730_lzcShifterZ1_uid181_Convert_q : std_logic_vector (5 downto 0);
    signal vStagei_uid776_lzcShifterZ1_uid211_Convert1_s : std_logic_vector (0 downto 0);
    signal vStagei_uid776_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (31 downto 0);
    signal vCount_uid777_lzcShifterZ1_uid211_Convert1_q : std_logic_vector (5 downto 0);
    signal vStagei_uid823_lzcShifterZ1_uid241_Convert2_s : std_logic_vector (0 downto 0);
    signal vStagei_uid823_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (31 downto 0);
    signal vCount_uid824_lzcShifterZ1_uid241_Convert2_q : std_logic_vector (5 downto 0);
    signal vStagei_uid870_lzcShifterZ1_uid271_Convert3_s : std_logic_vector (0 downto 0);
    signal vStagei_uid870_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (31 downto 0);
    signal vCount_uid871_lzcShifterZ1_uid271_Convert3_q : std_logic_vector (5 downto 0);
    signal vStagei_uid917_lzcShifterZ1_uid301_Convert4_s : std_logic_vector (0 downto 0);
    signal vStagei_uid917_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (31 downto 0);
    signal vCount_uid918_lzcShifterZ1_uid301_Convert4_q : std_logic_vector (5 downto 0);
    signal vStagei_uid964_lzcShifterZ1_uid331_Convert5_s : std_logic_vector (0 downto 0);
    signal vStagei_uid964_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (31 downto 0);
    signal vCount_uid965_lzcShifterZ1_uid331_Convert5_q : std_logic_vector (5 downto 0);
    signal r_uid509_alignmentShifter_uid75_Acc_s : std_logic_vector (0 downto 0);
    signal r_uid509_alignmentShifter_uid75_Acc_q : std_logic_vector (61 downto 0);
    signal r_uid618_alignmentShifter_uid131_Acc1_s : std_logic_vector (0 downto 0);
    signal r_uid618_alignmentShifter_uid131_Acc1_q : std_logic_vector (61 downto 0);
    signal R_uid104_Acc_q : std_logic_vector (31 downto 0);
    signal R_uid160_Acc1_q : std_logic_vector (31 downto 0);
    signal fracRnd_uid186_Convert_in : std_logic_vector (30 downto 0);
    signal fracRnd_uid186_Convert_b : std_logic_vector (23 downto 0);
    signal fracRnd_uid216_Convert1_in : std_logic_vector (30 downto 0);
    signal fracRnd_uid216_Convert1_b : std_logic_vector (23 downto 0);
    signal fracRnd_uid246_Convert2_in : std_logic_vector (30 downto 0);
    signal fracRnd_uid246_Convert2_b : std_logic_vector (23 downto 0);
    signal fracRnd_uid276_Convert3_in : std_logic_vector (30 downto 0);
    signal fracRnd_uid276_Convert3_b : std_logic_vector (23 downto 0);
    signal fracRnd_uid306_Convert4_in : std_logic_vector (30 downto 0);
    signal fracRnd_uid306_Convert4_b : std_logic_vector (23 downto 0);
    signal fracRnd_uid336_Convert5_in : std_logic_vector (30 downto 0);
    signal fracRnd_uid336_Convert5_b : std_logic_vector (23 downto 0);
    signal shiftedFracUpper_uid78_Acc_in : std_logic_vector (61 downto 0);
    signal shiftedFracUpper_uid78_Acc_b : std_logic_vector (37 downto 0);
    signal shiftedFracUpper_uid134_Acc1_in : std_logic_vector (61 downto 0);
    signal shiftedFracUpper_uid134_Acc1_b : std_logic_vector (37 downto 0);
    signal fracX_uid359_Convert7_in : std_logic_vector (22 downto 0);
    signal fracX_uid359_Convert7_b : std_logic_vector (22 downto 0);
    signal expX_uid361_Convert7_in : std_logic_vector (30 downto 0);
    signal expX_uid361_Convert7_b : std_logic_vector (7 downto 0);
    signal signX_uid362_Convert7_in : std_logic_vector (31 downto 0);
    signal signX_uid362_Convert7_b : std_logic_vector (0 downto 0);
    signal fracX_uid392_Convert8_in : std_logic_vector (22 downto 0);
    signal fracX_uid392_Convert8_b : std_logic_vector (22 downto 0);
    signal expX_uid394_Convert8_in : std_logic_vector (30 downto 0);
    signal expX_uid394_Convert8_b : std_logic_vector (7 downto 0);
    signal signX_uid395_Convert8_in : std_logic_vector (31 downto 0);
    signal signX_uid395_Convert8_b : std_logic_vector (0 downto 0);
    signal extendedAlignedShiftedFrac_uid79_Acc_q : std_logic_vector (38 downto 0);
    signal extendedAlignedShiftedFrac_uid135_Acc1_q : std_logic_vector (38 downto 0);
    signal oFracX_uid360_uid360_Convert7_q : std_logic_vector (23 downto 0);
    signal shiftValE_uid368_Convert7_a : std_logic_vector(8 downto 0);
    signal shiftValE_uid368_Convert7_b : std_logic_vector(8 downto 0);
    signal shiftValE_uid368_Convert7_o : std_logic_vector (8 downto 0);
    signal shiftValE_uid368_Convert7_q : std_logic_vector (8 downto 0);
    signal oFracX_uid393_uid393_Convert8_q : std_logic_vector (23 downto 0);
    signal shiftValE_uid401_Convert8_a : std_logic_vector(8 downto 0);
    signal shiftValE_uid401_Convert8_b : std_logic_vector(8 downto 0);
    signal shiftValE_uid401_Convert8_o : std_logic_vector (8 downto 0);
    signal shiftValE_uid401_Convert8_q : std_logic_vector (8 downto 0);
    signal zOFracX_uid370_Convert7_q : std_logic_vector (24 downto 0);
    signal shiftVal_uid369_Convert7_in : std_logic_vector (5 downto 0);
    signal shiftVal_uid369_Convert7_b : std_logic_vector (5 downto 0);
    signal zOFracX_uid403_Convert8_q : std_logic_vector (24 downto 0);
    signal shiftVal_uid402_Convert8_in : std_logic_vector (5 downto 0);
    signal shiftVal_uid402_Convert8_b : std_logic_vector (5 downto 0);
    signal shifterIn_uid372_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (5 downto 0);
    signal rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (3 downto 0);
    signal rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (1 downto 0);
    signal shifterIn_uid405_Convert8_q : std_logic_vector (32 downto 0);
    signal rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (5 downto 0);
    signal rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (3 downto 0);
    signal rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (1 downto 0);
    signal rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (1 downto 0);
    signal msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (0 downto 0);
    signal X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7_in : std_logic_vector (32 downto 0);
    signal X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector (16 downto 0);
    signal msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (0 downto 0);
    signal X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8_in : std_logic_vector (32 downto 0);
    signal X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector (16 downto 0);
    signal rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(15 downto 0);
    signal rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(15 downto 0);
    signal rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(15 downto 0);
    signal rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_a : std_logic_vector(31 downto 0);
    signal rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_b : std_logic_vector(31 downto 0);
    signal rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector(31 downto 0);
    signal rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_q : std_logic_vector (32 downto 0);
    signal rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(15 downto 0);
    signal rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(15 downto 0);
    signal rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(15 downto 0);
    signal rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_a : std_logic_vector(31 downto 0);
    signal rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_b : std_logic_vector(31 downto 0);
    signal rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector(31 downto 0);
    signal rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
    signal rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_q : std_logic_vector (32 downto 0);
begin


	--maxNegValueU_uid387_Convert7(CONSTANT,386)
    maxNegValueU_uid387_Convert7_q <= "00000000000000000000000000000000";

	--maxNegValueS_uid383_Convert7(CONSTANT,382)
    maxNegValueS_uid383_Convert7_q <= "10000000000000000000000000000000";

	--maxPosValueS_uid382_Convert7(CONSTANT,381)
    maxPosValueS_uid382_Convert7_q <= "01111111111111111111111111111111";

	--d0_uid376_Convert7(CONSTANT,375)
    d0_uid376_Convert7_q <= "001";

	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable(LOGICAL,2352)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_a <= VCC_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q <= not ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_a;

	--ld_Mult_f_0_cast_q_to_Mult6_f_a_nor(LOGICAL,2369)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_b <= ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_q <= not (ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_a or ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_b);

	--ld_Mult_f_0_cast_q_to_Mult6_f_a_mem_top(CONSTANT,2365)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_mem_top_q <= "0101110";

	--ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp(LOGICAL,2366)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_a <= ld_Mult_f_0_cast_q_to_Mult6_f_a_mem_top_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_b <= STD_LOGIC_VECTOR("0" & ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_q);
    ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_q <= "1" when ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_a = ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_b else "0";

	--ld_Mult_f_0_cast_q_to_Mult6_f_a_cmpReg(REG,2367)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult_f_0_cast_q_to_Mult6_f_a_cmpReg_q <= "0";
        ELSIF rising_edge(clk) THEN
            ld_Mult_f_0_cast_q_to_Mult6_f_a_cmpReg_q <= ld_Mult_f_0_cast_q_to_Mult6_f_a_cmp_q;
        END IF;
    END PROCESS;


	--ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena(REG,2370)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena_q <= "0";
        ELSIF rising_edge(clk) THEN
            IF (ld_Mult_f_0_cast_q_to_Mult6_f_a_nor_q = "1") THEN
                ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena_q <= ld_Mult_f_0_cast_q_to_Mult6_f_a_cmpReg_q;
            END IF;
        END IF;
    END PROCESS;


	--ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd(LOGICAL,2371)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_a <= ld_Mult_f_0_cast_q_to_Mult6_f_a_sticky_ena_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_b <= VCC_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_q <= ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_a and ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_b;

	--GND(CONSTANT,0)
    GND_q <= "0";

	--ChannelIn(PORTIN,5)@0

	--signX_uid267_Convert3(BITSELECT,266)@0
    signX_uid267_Convert3_in <= py;
    signX_uid267_Convert3_b <= signX_uid267_Convert3_in(31 downto 31);

	--ld_signX_uid267_Convert3_b_to_outRes_uid294_Convert3_c(DELAY,1443)@0
    ld_signX_uid267_Convert3_b_to_outRes_uid294_Convert3_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => signX_uid267_Convert3_b, xout => ld_signX_uid267_Convert3_b_to_outRes_uid294_Convert3_c_q, clk => clk, aclr => areset );

	--expInf_uid192_Convert(CONSTANT,191)
    expInf_uid192_Convert_q <= "11111111";

	--zeroExponent_uid99_Acc(CONSTANT,98)
    zeroExponent_uid99_Acc_q <= "00000000";

	--maxCount_uid182_Convert(CONSTANT,181)
    maxCount_uid182_Convert_q <= "100000";

	--xXorSign_uid268_Convert3(LOGICAL,267)@0
    xXorSign_uid268_Convert3_a <= py;
    xXorSign_uid268_Convert3_b <= STD_LOGIC_VECTOR((31 downto 1 => signX_uid267_Convert3_b(0)) & signX_uid267_Convert3_b);
    xXorSign_uid268_Convert3_q <= xXorSign_uid268_Convert3_a xor xXorSign_uid268_Convert3_b;

	--yE_uid269_Convert3(ADD,268)@0
    yE_uid269_Convert3_a <= STD_LOGIC_VECTOR((33 downto 32 => xXorSign_uid268_Convert3_q(31)) & xXorSign_uid268_Convert3_q);
    yE_uid269_Convert3_b <= STD_LOGIC_VECTOR('0' & "00000000000000000000000000000000" & signX_uid267_Convert3_b);
            yE_uid269_Convert3_o <= STD_LOGIC_VECTOR(SIGNED(yE_uid269_Convert3_a) + SIGNED(yE_uid269_Convert3_b));
    yE_uid269_Convert3_q <= yE_uid269_Convert3_o(32 downto 0);


	--y_uid270_Convert3(BITSELECT,269)@0
    y_uid270_Convert3_in <= yE_uid269_Convert3_q(31 downto 0);
    y_uid270_Convert3_b <= y_uid270_Convert3_in(31 downto 0);

	--vCount_uid833_lzcShifterZ1_uid271_Convert3(LOGICAL,832)@0
    vCount_uid833_lzcShifterZ1_uid271_Convert3_a <= y_uid270_Convert3_b;
    vCount_uid833_lzcShifterZ1_uid271_Convert3_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid833_lzcShifterZ1_uid271_Convert3_q <= "1" when vCount_uid833_lzcShifterZ1_uid271_Convert3_a = vCount_uid833_lzcShifterZ1_uid271_Convert3_b else "0";

	--ld_vCount_uid833_lzcShifterZ1_uid271_Convert3_q_to_vCount_uid871_lzcShifterZ1_uid271_Convert3_f(DELAY,2011)@0
    ld_vCount_uid833_lzcShifterZ1_uid271_Convert3_q_to_vCount_uid871_lzcShifterZ1_uid271_Convert3_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid833_lzcShifterZ1_uid271_Convert3_q, xout => ld_vCount_uid833_lzcShifterZ1_uid271_Convert3_q_to_vCount_uid871_lzcShifterZ1_uid271_Convert3_f_q, clk => clk, aclr => areset );

	--rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc(CONSTANT,475)
    rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q <= "0000000000000000";

	--vStagei_uid835_lzcShifterZ1_uid271_Convert3(MUX,834)@0
    vStagei_uid835_lzcShifterZ1_uid271_Convert3_s <= vCount_uid833_lzcShifterZ1_uid271_Convert3_q;
    vStagei_uid835_lzcShifterZ1_uid271_Convert3: PROCESS (vStagei_uid835_lzcShifterZ1_uid271_Convert3_s, y_uid270_Convert3_b, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE vStagei_uid835_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vStagei_uid835_lzcShifterZ1_uid271_Convert3_q <= y_uid270_Convert3_b;
                  WHEN "1" => vStagei_uid835_lzcShifterZ1_uid271_Convert3_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => vStagei_uid835_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid837_lzcShifterZ1_uid271_Convert3(BITSELECT,836)@0
    rVStage_uid837_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid835_lzcShifterZ1_uid271_Convert3_q;
    rVStage_uid837_lzcShifterZ1_uid271_Convert3_b <= rVStage_uid837_lzcShifterZ1_uid271_Convert3_in(31 downto 16);

	--vCount_uid838_lzcShifterZ1_uid271_Convert3(LOGICAL,837)@0
    vCount_uid838_lzcShifterZ1_uid271_Convert3_a <= rVStage_uid837_lzcShifterZ1_uid271_Convert3_b;
    vCount_uid838_lzcShifterZ1_uid271_Convert3_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid838_lzcShifterZ1_uid271_Convert3_q_i <= "1" when vCount_uid838_lzcShifterZ1_uid271_Convert3_a = vCount_uid838_lzcShifterZ1_uid271_Convert3_b else "0";
    vCount_uid838_lzcShifterZ1_uid271_Convert3_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid838_lzcShifterZ1_uid271_Convert3_q, xin => vCount_uid838_lzcShifterZ1_uid271_Convert3_q_i, clk => clk, aclr => areset);

	--vStage_uid840_lzcShifterZ1_uid271_Convert3(BITSELECT,839)@0
    vStage_uid840_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid835_lzcShifterZ1_uid271_Convert3_q(15 downto 0);
    vStage_uid840_lzcShifterZ1_uid271_Convert3_b <= vStage_uid840_lzcShifterZ1_uid271_Convert3_in(15 downto 0);

	--cStage_uid841_lzcShifterZ1_uid271_Convert3(BITJOIN,840)@0
    cStage_uid841_lzcShifterZ1_uid271_Convert3_q <= vStage_uid840_lzcShifterZ1_uid271_Convert3_b & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3(REG,1108)@0
    reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3_q <= cStage_uid841_lzcShifterZ1_uid271_Convert3_q;
        END IF;
    END PROCESS;


	--reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2(REG,1107)@0
    reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2_q <= vStagei_uid835_lzcShifterZ1_uid271_Convert3_q;
        END IF;
    END PROCESS;


	--vStagei_uid842_lzcShifterZ1_uid271_Convert3(MUX,841)@1
    vStagei_uid842_lzcShifterZ1_uid271_Convert3_s <= vCount_uid838_lzcShifterZ1_uid271_Convert3_q;
    vStagei_uid842_lzcShifterZ1_uid271_Convert3: PROCESS (vStagei_uid842_lzcShifterZ1_uid271_Convert3_s, reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2_q, reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3_q)
    BEGIN
            CASE vStagei_uid842_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vStagei_uid842_lzcShifterZ1_uid271_Convert3_q <= reg_vStagei_uid835_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_2_q;
                  WHEN "1" => vStagei_uid842_lzcShifterZ1_uid271_Convert3_q <= reg_cStage_uid841_lzcShifterZ1_uid271_Convert3_0_to_vStagei_uid842_lzcShifterZ1_uid271_Convert3_3_q;
                  WHEN OTHERS => vStagei_uid842_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid844_lzcShifterZ1_uid271_Convert3(BITSELECT,843)@1
    rVStage_uid844_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid842_lzcShifterZ1_uid271_Convert3_q;
    rVStage_uid844_lzcShifterZ1_uid271_Convert3_b <= rVStage_uid844_lzcShifterZ1_uid271_Convert3_in(31 downto 24);

	--vCount_uid845_lzcShifterZ1_uid271_Convert3(LOGICAL,844)@1
    vCount_uid845_lzcShifterZ1_uid271_Convert3_a <= rVStage_uid844_lzcShifterZ1_uid271_Convert3_b;
    vCount_uid845_lzcShifterZ1_uid271_Convert3_b <= zeroExponent_uid99_Acc_q;
    vCount_uid845_lzcShifterZ1_uid271_Convert3_q <= "1" when vCount_uid845_lzcShifterZ1_uid271_Convert3_a = vCount_uid845_lzcShifterZ1_uid271_Convert3_b else "0";

	--rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc(CONSTANT,486)
    rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q <= "0000";

	--vStage_uid847_lzcShifterZ1_uid271_Convert3(BITSELECT,846)@1
    vStage_uid847_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid842_lzcShifterZ1_uid271_Convert3_q(23 downto 0);
    vStage_uid847_lzcShifterZ1_uid271_Convert3_b <= vStage_uid847_lzcShifterZ1_uid271_Convert3_in(23 downto 0);

	--cStage_uid848_lzcShifterZ1_uid271_Convert3(BITJOIN,847)@1
    cStage_uid848_lzcShifterZ1_uid271_Convert3_q <= vStage_uid847_lzcShifterZ1_uid271_Convert3_b & zeroExponent_uid99_Acc_q;

	--vStagei_uid849_lzcShifterZ1_uid271_Convert3(MUX,848)@1
    vStagei_uid849_lzcShifterZ1_uid271_Convert3_s <= vCount_uid845_lzcShifterZ1_uid271_Convert3_q;
    vStagei_uid849_lzcShifterZ1_uid271_Convert3: PROCESS (vStagei_uid849_lzcShifterZ1_uid271_Convert3_s, vStagei_uid842_lzcShifterZ1_uid271_Convert3_q, cStage_uid848_lzcShifterZ1_uid271_Convert3_q)
    BEGIN
            CASE vStagei_uid849_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vStagei_uid849_lzcShifterZ1_uid271_Convert3_q <= vStagei_uid842_lzcShifterZ1_uid271_Convert3_q;
                  WHEN "1" => vStagei_uid849_lzcShifterZ1_uid271_Convert3_q <= cStage_uid848_lzcShifterZ1_uid271_Convert3_q;
                  WHEN OTHERS => vStagei_uid849_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid851_lzcShifterZ1_uid271_Convert3(BITSELECT,850)@1
    rVStage_uid851_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid849_lzcShifterZ1_uid271_Convert3_q;
    rVStage_uid851_lzcShifterZ1_uid271_Convert3_b <= rVStage_uid851_lzcShifterZ1_uid271_Convert3_in(31 downto 28);

	--vCount_uid852_lzcShifterZ1_uid271_Convert3(LOGICAL,851)@1
    vCount_uid852_lzcShifterZ1_uid271_Convert3_a <= rVStage_uid851_lzcShifterZ1_uid271_Convert3_b;
    vCount_uid852_lzcShifterZ1_uid271_Convert3_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid852_lzcShifterZ1_uid271_Convert3_q <= "1" when vCount_uid852_lzcShifterZ1_uid271_Convert3_a = vCount_uid852_lzcShifterZ1_uid271_Convert3_b else "0";

	--rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc(CONSTANT,500)
    rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q <= "00";

	--vStage_uid854_lzcShifterZ1_uid271_Convert3(BITSELECT,853)@1
    vStage_uid854_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid849_lzcShifterZ1_uid271_Convert3_q(27 downto 0);
    vStage_uid854_lzcShifterZ1_uid271_Convert3_b <= vStage_uid854_lzcShifterZ1_uid271_Convert3_in(27 downto 0);

	--cStage_uid855_lzcShifterZ1_uid271_Convert3(BITJOIN,854)@1
    cStage_uid855_lzcShifterZ1_uid271_Convert3_q <= vStage_uid854_lzcShifterZ1_uid271_Convert3_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--vStagei_uid856_lzcShifterZ1_uid271_Convert3(MUX,855)@1
    vStagei_uid856_lzcShifterZ1_uid271_Convert3_s <= vCount_uid852_lzcShifterZ1_uid271_Convert3_q;
    vStagei_uid856_lzcShifterZ1_uid271_Convert3: PROCESS (vStagei_uid856_lzcShifterZ1_uid271_Convert3_s, vStagei_uid849_lzcShifterZ1_uid271_Convert3_q, cStage_uid855_lzcShifterZ1_uid271_Convert3_q)
    BEGIN
            CASE vStagei_uid856_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vStagei_uid856_lzcShifterZ1_uid271_Convert3_q <= vStagei_uid849_lzcShifterZ1_uid271_Convert3_q;
                  WHEN "1" => vStagei_uid856_lzcShifterZ1_uid271_Convert3_q <= cStage_uid855_lzcShifterZ1_uid271_Convert3_q;
                  WHEN OTHERS => vStagei_uid856_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid858_lzcShifterZ1_uid271_Convert3(BITSELECT,857)@1
    rVStage_uid858_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid856_lzcShifterZ1_uid271_Convert3_q;
    rVStage_uid858_lzcShifterZ1_uid271_Convert3_b <= rVStage_uid858_lzcShifterZ1_uid271_Convert3_in(31 downto 30);

	--vCount_uid859_lzcShifterZ1_uid271_Convert3(LOGICAL,858)@1
    vCount_uid859_lzcShifterZ1_uid271_Convert3_a <= rVStage_uid858_lzcShifterZ1_uid271_Convert3_b;
    vCount_uid859_lzcShifterZ1_uid271_Convert3_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid859_lzcShifterZ1_uid271_Convert3_q <= "1" when vCount_uid859_lzcShifterZ1_uid271_Convert3_a = vCount_uid859_lzcShifterZ1_uid271_Convert3_b else "0";

	--vStage_uid861_lzcShifterZ1_uid271_Convert3(BITSELECT,860)@1
    vStage_uid861_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid856_lzcShifterZ1_uid271_Convert3_q(29 downto 0);
    vStage_uid861_lzcShifterZ1_uid271_Convert3_b <= vStage_uid861_lzcShifterZ1_uid271_Convert3_in(29 downto 0);

	--cStage_uid862_lzcShifterZ1_uid271_Convert3(BITJOIN,861)@1
    cStage_uid862_lzcShifterZ1_uid271_Convert3_q <= vStage_uid861_lzcShifterZ1_uid271_Convert3_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--vStagei_uid863_lzcShifterZ1_uid271_Convert3(MUX,862)@1
    vStagei_uid863_lzcShifterZ1_uid271_Convert3_s <= vCount_uid859_lzcShifterZ1_uid271_Convert3_q;
    vStagei_uid863_lzcShifterZ1_uid271_Convert3: PROCESS (vStagei_uid863_lzcShifterZ1_uid271_Convert3_s, vStagei_uid856_lzcShifterZ1_uid271_Convert3_q, cStage_uid862_lzcShifterZ1_uid271_Convert3_q)
    BEGIN
            CASE vStagei_uid863_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vStagei_uid863_lzcShifterZ1_uid271_Convert3_q <= vStagei_uid856_lzcShifterZ1_uid271_Convert3_q;
                  WHEN "1" => vStagei_uid863_lzcShifterZ1_uid271_Convert3_q <= cStage_uid862_lzcShifterZ1_uid271_Convert3_q;
                  WHEN OTHERS => vStagei_uid863_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid865_lzcShifterZ1_uid271_Convert3(BITSELECT,864)@1
    rVStage_uid865_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid863_lzcShifterZ1_uid271_Convert3_q;
    rVStage_uid865_lzcShifterZ1_uid271_Convert3_b <= rVStage_uid865_lzcShifterZ1_uid271_Convert3_in(31 downto 31);

	--vCount_uid866_lzcShifterZ1_uid271_Convert3(LOGICAL,865)@1
    vCount_uid866_lzcShifterZ1_uid271_Convert3_a <= rVStage_uid865_lzcShifterZ1_uid271_Convert3_b;
    vCount_uid866_lzcShifterZ1_uid271_Convert3_b <= GND_q;
    vCount_uid866_lzcShifterZ1_uid271_Convert3_q <= "1" when vCount_uid866_lzcShifterZ1_uid271_Convert3_a = vCount_uid866_lzcShifterZ1_uid271_Convert3_b else "0";

	--vCount_uid871_lzcShifterZ1_uid271_Convert3(BITJOIN,870)@1
    vCount_uid871_lzcShifterZ1_uid271_Convert3_q <= ld_vCount_uid833_lzcShifterZ1_uid271_Convert3_q_to_vCount_uid871_lzcShifterZ1_uid271_Convert3_f_q & vCount_uid838_lzcShifterZ1_uid271_Convert3_q & vCount_uid845_lzcShifterZ1_uid271_Convert3_q & vCount_uid852_lzcShifterZ1_uid271_Convert3_q & vCount_uid859_lzcShifterZ1_uid271_Convert3_q & vCount_uid866_lzcShifterZ1_uid271_Convert3_q;

	--reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1(REG,1109)@1
    reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1_q <= "000000";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1_q <= vCount_uid871_lzcShifterZ1_uid271_Convert3_q;
        END IF;
    END PROCESS;


	--vCountBig_uid873_lzcShifterZ1_uid271_Convert3(COMPARE,872)@2
    vCountBig_uid873_lzcShifterZ1_uid271_Convert3_cin <= GND_q;
    vCountBig_uid873_lzcShifterZ1_uid271_Convert3_a <= STD_LOGIC_VECTOR("00" & maxCount_uid182_Convert_q) & '0';
    vCountBig_uid873_lzcShifterZ1_uid271_Convert3_b <= STD_LOGIC_VECTOR("00" & reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1_q) & vCountBig_uid873_lzcShifterZ1_uid271_Convert3_cin(0);
            vCountBig_uid873_lzcShifterZ1_uid271_Convert3_o <= STD_LOGIC_VECTOR(UNSIGNED(vCountBig_uid873_lzcShifterZ1_uid271_Convert3_a) - UNSIGNED(vCountBig_uid873_lzcShifterZ1_uid271_Convert3_b));
    vCountBig_uid873_lzcShifterZ1_uid271_Convert3_c(0) <= vCountBig_uid873_lzcShifterZ1_uid271_Convert3_o(8);


	--vCountFinal_uid875_lzcShifterZ1_uid271_Convert3(MUX,874)@2
    vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_s <= vCountBig_uid873_lzcShifterZ1_uid271_Convert3_c;
    vCountFinal_uid875_lzcShifterZ1_uid271_Convert3: PROCESS (vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_s, reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1_q, maxCount_uid182_Convert_q)
    BEGIN
            CASE vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_q <= reg_vCount_uid871_lzcShifterZ1_uid271_Convert3_0_to_vCountBig_uid873_lzcShifterZ1_uid271_Convert3_1_q;
                  WHEN "1" => vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_q <= maxCount_uid182_Convert_q;
                  WHEN OTHERS => vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--msbIn_uid184_Convert(CONSTANT,183)
    msbIn_uid184_Convert_q <= "10001110";

	--expPreRnd_uid275_Convert3(SUB,274)@2
    expPreRnd_uid275_Convert3_a <= STD_LOGIC_VECTOR("0" & msbIn_uid184_Convert_q);
    expPreRnd_uid275_Convert3_b <= STD_LOGIC_VECTOR("000" & vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_q);
            expPreRnd_uid275_Convert3_o <= STD_LOGIC_VECTOR(UNSIGNED(expPreRnd_uid275_Convert3_a) - UNSIGNED(expPreRnd_uid275_Convert3_b));
    expPreRnd_uid275_Convert3_q <= expPreRnd_uid275_Convert3_o(8 downto 0);


	--vStage_uid868_lzcShifterZ1_uid271_Convert3(BITSELECT,867)@1
    vStage_uid868_lzcShifterZ1_uid271_Convert3_in <= vStagei_uid863_lzcShifterZ1_uid271_Convert3_q(30 downto 0);
    vStage_uid868_lzcShifterZ1_uid271_Convert3_b <= vStage_uid868_lzcShifterZ1_uid271_Convert3_in(30 downto 0);

	--cStage_uid869_lzcShifterZ1_uid271_Convert3(BITJOIN,868)@1
    cStage_uid869_lzcShifterZ1_uid271_Convert3_q <= vStage_uid868_lzcShifterZ1_uid271_Convert3_b & GND_q;

	--vStagei_uid870_lzcShifterZ1_uid271_Convert3(MUX,869)@1
    vStagei_uid870_lzcShifterZ1_uid271_Convert3_s <= vCount_uid866_lzcShifterZ1_uid271_Convert3_q;
    vStagei_uid870_lzcShifterZ1_uid271_Convert3: PROCESS (vStagei_uid870_lzcShifterZ1_uid271_Convert3_s, vStagei_uid863_lzcShifterZ1_uid271_Convert3_q, cStage_uid869_lzcShifterZ1_uid271_Convert3_q)
    BEGIN
            CASE vStagei_uid870_lzcShifterZ1_uid271_Convert3_s IS
                  WHEN "0" => vStagei_uid870_lzcShifterZ1_uid271_Convert3_q <= vStagei_uid863_lzcShifterZ1_uid271_Convert3_q;
                  WHEN "1" => vStagei_uid870_lzcShifterZ1_uid271_Convert3_q <= cStage_uid869_lzcShifterZ1_uid271_Convert3_q;
                  WHEN OTHERS => vStagei_uid870_lzcShifterZ1_uid271_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracRnd_uid276_Convert3(BITSELECT,275)@1
    fracRnd_uid276_Convert3_in <= vStagei_uid870_lzcShifterZ1_uid271_Convert3_q(30 downto 0);
    fracRnd_uid276_Convert3_b <= fracRnd_uid276_Convert3_in(30 downto 7);

	--reg_fracRnd_uid276_Convert3_0_to_expFracRnd_uid277_uid277_Convert3_0(REG,1111)@1
    reg_fracRnd_uid276_Convert3_0_to_expFracRnd_uid277_uid277_Convert3_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracRnd_uid276_Convert3_0_to_expFracRnd_uid277_uid277_Convert3_0_q <= "000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracRnd_uid276_Convert3_0_to_expFracRnd_uid277_uid277_Convert3_0_q <= fracRnd_uid276_Convert3_b;
        END IF;
    END PROCESS;


	--expFracRnd_uid277_uid277_Convert3(BITJOIN,276)@2
    expFracRnd_uid277_uid277_Convert3_q <= expPreRnd_uid275_Convert3_q & reg_fracRnd_uid276_Convert3_0_to_expFracRnd_uid277_uid277_Convert3_0_q;

	--expFracR_uid278_Convert3(ADD,277)@2
    expFracR_uid278_Convert3_a <= STD_LOGIC_VECTOR((34 downto 33 => expFracRnd_uid277_uid277_Convert3_q(32)) & expFracRnd_uid277_uid277_Convert3_q);
    expFracR_uid278_Convert3_b <= STD_LOGIC_VECTOR('0' & "000000000000000000000000000000000" & VCC_q);
            expFracR_uid278_Convert3_o <= STD_LOGIC_VECTOR(SIGNED(expFracR_uid278_Convert3_a) + SIGNED(expFracR_uid278_Convert3_b));
    expFracR_uid278_Convert3_q <= expFracR_uid278_Convert3_o(33 downto 0);


	--expR_uid280_Convert3(BITSELECT,279)@2
    expR_uid280_Convert3_in <= expFracR_uid278_Convert3_q;
    expR_uid280_Convert3_b <= expR_uid280_Convert3_in(33 downto 24);

	--expR_uid292_Convert3(BITSELECT,291)@2
    expR_uid292_Convert3_in <= expR_uid280_Convert3_b(7 downto 0);
    expR_uid292_Convert3_b <= expR_uid292_Convert3_in(7 downto 0);

	--reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2(REG,1115)@2
    reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2_q <= "00000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2_q <= expR_uid292_Convert3_b;
        END IF;
    END PROCESS;


	--reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1(REG,1112)@2
    reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q <= "0000000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q <= expR_uid280_Convert3_b;
        END IF;
    END PROCESS;


	--ovf_uid283_Convert3(COMPARE,282)@3
    ovf_uid283_Convert3_cin <= GND_q;
    ovf_uid283_Convert3_a <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q(9)) & reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q) & '0';
    ovf_uid283_Convert3_b <= STD_LOGIC_VECTOR('0' & "000" & expInf_uid192_Convert_q) & ovf_uid283_Convert3_cin(0);
            ovf_uid283_Convert3_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid283_Convert3_a) - SIGNED(ovf_uid283_Convert3_b));
    ovf_uid283_Convert3_n(0) <= not ovf_uid283_Convert3_o(12);


	--inIsZero_uid273_Convert3(LOGICAL,272)@2
    inIsZero_uid273_Convert3_a <= vCountFinal_uid875_lzcShifterZ1_uid271_Convert3_q;
    inIsZero_uid273_Convert3_b <= maxCount_uid182_Convert_q;
    inIsZero_uid273_Convert3_q_i <= "1" when inIsZero_uid273_Convert3_a = inIsZero_uid273_Convert3_b else "0";
    inIsZero_uid273_Convert3_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => inIsZero_uid273_Convert3_q, xin => inIsZero_uid273_Convert3_q_i, clk => clk, aclr => areset);

	--ovf_uid281_Convert3(COMPARE,280)@3
    ovf_uid281_Convert3_cin <= GND_q;
    ovf_uid281_Convert3_a <= STD_LOGIC_VECTOR('0' & "0000000000" & GND_q) & '0';
    ovf_uid281_Convert3_b <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q(9)) & reg_expR_uid280_Convert3_0_to_ovf_uid281_Convert3_1_q) & ovf_uid281_Convert3_cin(0);
            ovf_uid281_Convert3_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid281_Convert3_a) - SIGNED(ovf_uid281_Convert3_b));
    ovf_uid281_Convert3_n(0) <= not ovf_uid281_Convert3_o(12);


	--udfOrInZero_uid287_Convert3(LOGICAL,286)@3
    udfOrInZero_uid287_Convert3_a <= ovf_uid281_Convert3_n;
    udfOrInZero_uid287_Convert3_b <= inIsZero_uid273_Convert3_q;
    udfOrInZero_uid287_Convert3_q <= udfOrInZero_uid287_Convert3_a or udfOrInZero_uid287_Convert3_b;

	--excSelector_uid288_Convert3(BITJOIN,287)@3
    excSelector_uid288_Convert3_q <= ovf_uid283_Convert3_n & udfOrInZero_uid287_Convert3_q;

	--expRPostExc_uid293_Convert3(MUX,292)@3
    expRPostExc_uid293_Convert3_s <= excSelector_uid288_Convert3_q;
    expRPostExc_uid293_Convert3: PROCESS (expRPostExc_uid293_Convert3_s, reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2_q, zeroExponent_uid99_Acc_q, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid293_Convert3_s IS
                  WHEN "00" => expRPostExc_uid293_Convert3_q <= reg_expR_uid292_Convert3_0_to_expRPostExc_uid293_Convert3_2_q;
                  WHEN "01" => expRPostExc_uid293_Convert3_q <= zeroExponent_uid99_Acc_q;
                  WHEN "10" => expRPostExc_uid293_Convert3_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid293_Convert3_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid293_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracZ_uid195_Convert(CONSTANT,194)
    fracZ_uid195_Convert_q <= "00000000000000000000000";

	--fracR_uid279_Convert3(BITSELECT,278)@2
    fracR_uid279_Convert3_in <= expFracR_uid278_Convert3_q(23 downto 0);
    fracR_uid279_Convert3_b <= fracR_uid279_Convert3_in(23 downto 1);

	--reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2(REG,1114)@2
    reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2_q <= fracR_uid279_Convert3_b;
        END IF;
    END PROCESS;


	--excSelector_uid284_Convert3(LOGICAL,283)@3
    excSelector_uid284_Convert3_a <= inIsZero_uid273_Convert3_q;
    excSelector_uid284_Convert3_b <= ovf_uid283_Convert3_n;
    excSelector_uid284_Convert3_q <= excSelector_uid284_Convert3_a or excSelector_uid284_Convert3_b;

	--fracRPostExc_uid286_Convert3(MUX,285)@3
    fracRPostExc_uid286_Convert3_s <= excSelector_uid284_Convert3_q;
    fracRPostExc_uid286_Convert3: PROCESS (fracRPostExc_uid286_Convert3_s, reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2_q, fracZ_uid195_Convert_q)
    BEGIN
            CASE fracRPostExc_uid286_Convert3_s IS
                  WHEN "0" => fracRPostExc_uid286_Convert3_q <= reg_fracR_uid279_Convert3_0_to_fracRPostExc_uid286_Convert3_2_q;
                  WHEN "1" => fracRPostExc_uid286_Convert3_q <= fracZ_uid195_Convert_q;
                  WHEN OTHERS => fracRPostExc_uid286_Convert3_q <= (others => '0');
            END CASE;
    END PROCESS;


	--outRes_uid294_Convert3(BITJOIN,293)@3
    outRes_uid294_Convert3_q <= ld_signX_uid267_Convert3_b_to_outRes_uid294_Convert3_c_q & expRPostExc_uid293_Convert3_q & fracRPostExc_uid286_Convert3_q;

	--Sub1_R_sub_f_1_cast(FLOATCAST,63)@3
    Sub1_R_sub_f_1_cast_reset <= areset;
    Sub1_R_sub_f_1_cast_a <= outRes_uid294_Convert3_q;
    Sub1_R_sub_f_1_cast_inst : cast_sIEEE_2_sInternal
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Sub1_R_sub_f_1_cast_reset,
    		dataa	 => Sub1_R_sub_f_1_cast_a,
    		result	 => Sub1_R_sub_f_1_cast_q
    	);
    -- synopsys translate off
    Sub1_R_sub_f_1_cast_q_real <= sInternal_2_real(Sub1_R_sub_f_1_cast_q);
    -- synopsys translate on

	--signX_uid237_Convert2(BITSELECT,236)@0
    signX_uid237_Convert2_in <= ref_py;
    signX_uid237_Convert2_b <= signX_uid237_Convert2_in(31 downto 31);

	--ld_signX_uid237_Convert2_b_to_outRes_uid264_Convert2_c(DELAY,1412)@0
    ld_signX_uid237_Convert2_b_to_outRes_uid264_Convert2_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => signX_uid237_Convert2_b, xout => ld_signX_uid237_Convert2_b_to_outRes_uid264_Convert2_c_q, clk => clk, aclr => areset );

	--xXorSign_uid238_Convert2(LOGICAL,237)@0
    xXorSign_uid238_Convert2_a <= ref_py;
    xXorSign_uid238_Convert2_b <= STD_LOGIC_VECTOR((31 downto 1 => signX_uid237_Convert2_b(0)) & signX_uid237_Convert2_b);
    xXorSign_uid238_Convert2_q <= xXorSign_uid238_Convert2_a xor xXorSign_uid238_Convert2_b;

	--yE_uid239_Convert2(ADD,238)@0
    yE_uid239_Convert2_a <= STD_LOGIC_VECTOR((33 downto 32 => xXorSign_uid238_Convert2_q(31)) & xXorSign_uid238_Convert2_q);
    yE_uid239_Convert2_b <= STD_LOGIC_VECTOR('0' & "00000000000000000000000000000000" & signX_uid237_Convert2_b);
            yE_uid239_Convert2_o <= STD_LOGIC_VECTOR(SIGNED(yE_uid239_Convert2_a) + SIGNED(yE_uid239_Convert2_b));
    yE_uid239_Convert2_q <= yE_uid239_Convert2_o(32 downto 0);


	--y_uid240_Convert2(BITSELECT,239)@0
    y_uid240_Convert2_in <= yE_uid239_Convert2_q(31 downto 0);
    y_uid240_Convert2_b <= y_uid240_Convert2_in(31 downto 0);

	--vCount_uid786_lzcShifterZ1_uid241_Convert2(LOGICAL,785)@0
    vCount_uid786_lzcShifterZ1_uid241_Convert2_a <= y_uid240_Convert2_b;
    vCount_uid786_lzcShifterZ1_uid241_Convert2_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid786_lzcShifterZ1_uid241_Convert2_q <= "1" when vCount_uid786_lzcShifterZ1_uid241_Convert2_a = vCount_uid786_lzcShifterZ1_uid241_Convert2_b else "0";

	--ld_vCount_uid786_lzcShifterZ1_uid241_Convert2_q_to_vCount_uid824_lzcShifterZ1_uid241_Convert2_f(DELAY,1964)@0
    ld_vCount_uid786_lzcShifterZ1_uid241_Convert2_q_to_vCount_uid824_lzcShifterZ1_uid241_Convert2_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid786_lzcShifterZ1_uid241_Convert2_q, xout => ld_vCount_uid786_lzcShifterZ1_uid241_Convert2_q_to_vCount_uid824_lzcShifterZ1_uid241_Convert2_f_q, clk => clk, aclr => areset );

	--vStagei_uid788_lzcShifterZ1_uid241_Convert2(MUX,787)@0
    vStagei_uid788_lzcShifterZ1_uid241_Convert2_s <= vCount_uid786_lzcShifterZ1_uid241_Convert2_q;
    vStagei_uid788_lzcShifterZ1_uid241_Convert2: PROCESS (vStagei_uid788_lzcShifterZ1_uid241_Convert2_s, y_uid240_Convert2_b, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE vStagei_uid788_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vStagei_uid788_lzcShifterZ1_uid241_Convert2_q <= y_uid240_Convert2_b;
                  WHEN "1" => vStagei_uid788_lzcShifterZ1_uid241_Convert2_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => vStagei_uid788_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid790_lzcShifterZ1_uid241_Convert2(BITSELECT,789)@0
    rVStage_uid790_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid788_lzcShifterZ1_uid241_Convert2_q;
    rVStage_uid790_lzcShifterZ1_uid241_Convert2_b <= rVStage_uid790_lzcShifterZ1_uid241_Convert2_in(31 downto 16);

	--vCount_uid791_lzcShifterZ1_uid241_Convert2(LOGICAL,790)@0
    vCount_uid791_lzcShifterZ1_uid241_Convert2_a <= rVStage_uid790_lzcShifterZ1_uid241_Convert2_b;
    vCount_uid791_lzcShifterZ1_uid241_Convert2_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid791_lzcShifterZ1_uid241_Convert2_q_i <= "1" when vCount_uid791_lzcShifterZ1_uid241_Convert2_a = vCount_uid791_lzcShifterZ1_uid241_Convert2_b else "0";
    vCount_uid791_lzcShifterZ1_uid241_Convert2_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid791_lzcShifterZ1_uid241_Convert2_q, xin => vCount_uid791_lzcShifterZ1_uid241_Convert2_q_i, clk => clk, aclr => areset);

	--vStage_uid793_lzcShifterZ1_uid241_Convert2(BITSELECT,792)@0
    vStage_uid793_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid788_lzcShifterZ1_uid241_Convert2_q(15 downto 0);
    vStage_uid793_lzcShifterZ1_uid241_Convert2_b <= vStage_uid793_lzcShifterZ1_uid241_Convert2_in(15 downto 0);

	--cStage_uid794_lzcShifterZ1_uid241_Convert2(BITJOIN,793)@0
    cStage_uid794_lzcShifterZ1_uid241_Convert2_q <= vStage_uid793_lzcShifterZ1_uid241_Convert2_b & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3(REG,1099)@0
    reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3_q <= cStage_uid794_lzcShifterZ1_uid241_Convert2_q;
        END IF;
    END PROCESS;


	--reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2(REG,1098)@0
    reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2_q <= vStagei_uid788_lzcShifterZ1_uid241_Convert2_q;
        END IF;
    END PROCESS;


	--vStagei_uid795_lzcShifterZ1_uid241_Convert2(MUX,794)@1
    vStagei_uid795_lzcShifterZ1_uid241_Convert2_s <= vCount_uid791_lzcShifterZ1_uid241_Convert2_q;
    vStagei_uid795_lzcShifterZ1_uid241_Convert2: PROCESS (vStagei_uid795_lzcShifterZ1_uid241_Convert2_s, reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2_q, reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3_q)
    BEGIN
            CASE vStagei_uid795_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vStagei_uid795_lzcShifterZ1_uid241_Convert2_q <= reg_vStagei_uid788_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_2_q;
                  WHEN "1" => vStagei_uid795_lzcShifterZ1_uid241_Convert2_q <= reg_cStage_uid794_lzcShifterZ1_uid241_Convert2_0_to_vStagei_uid795_lzcShifterZ1_uid241_Convert2_3_q;
                  WHEN OTHERS => vStagei_uid795_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid797_lzcShifterZ1_uid241_Convert2(BITSELECT,796)@1
    rVStage_uid797_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid795_lzcShifterZ1_uid241_Convert2_q;
    rVStage_uid797_lzcShifterZ1_uid241_Convert2_b <= rVStage_uid797_lzcShifterZ1_uid241_Convert2_in(31 downto 24);

	--vCount_uid798_lzcShifterZ1_uid241_Convert2(LOGICAL,797)@1
    vCount_uid798_lzcShifterZ1_uid241_Convert2_a <= rVStage_uid797_lzcShifterZ1_uid241_Convert2_b;
    vCount_uid798_lzcShifterZ1_uid241_Convert2_b <= zeroExponent_uid99_Acc_q;
    vCount_uid798_lzcShifterZ1_uid241_Convert2_q <= "1" when vCount_uid798_lzcShifterZ1_uid241_Convert2_a = vCount_uid798_lzcShifterZ1_uid241_Convert2_b else "0";

	--vStage_uid800_lzcShifterZ1_uid241_Convert2(BITSELECT,799)@1
    vStage_uid800_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid795_lzcShifterZ1_uid241_Convert2_q(23 downto 0);
    vStage_uid800_lzcShifterZ1_uid241_Convert2_b <= vStage_uid800_lzcShifterZ1_uid241_Convert2_in(23 downto 0);

	--cStage_uid801_lzcShifterZ1_uid241_Convert2(BITJOIN,800)@1
    cStage_uid801_lzcShifterZ1_uid241_Convert2_q <= vStage_uid800_lzcShifterZ1_uid241_Convert2_b & zeroExponent_uid99_Acc_q;

	--vStagei_uid802_lzcShifterZ1_uid241_Convert2(MUX,801)@1
    vStagei_uid802_lzcShifterZ1_uid241_Convert2_s <= vCount_uid798_lzcShifterZ1_uid241_Convert2_q;
    vStagei_uid802_lzcShifterZ1_uid241_Convert2: PROCESS (vStagei_uid802_lzcShifterZ1_uid241_Convert2_s, vStagei_uid795_lzcShifterZ1_uid241_Convert2_q, cStage_uid801_lzcShifterZ1_uid241_Convert2_q)
    BEGIN
            CASE vStagei_uid802_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vStagei_uid802_lzcShifterZ1_uid241_Convert2_q <= vStagei_uid795_lzcShifterZ1_uid241_Convert2_q;
                  WHEN "1" => vStagei_uid802_lzcShifterZ1_uid241_Convert2_q <= cStage_uid801_lzcShifterZ1_uid241_Convert2_q;
                  WHEN OTHERS => vStagei_uid802_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid804_lzcShifterZ1_uid241_Convert2(BITSELECT,803)@1
    rVStage_uid804_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid802_lzcShifterZ1_uid241_Convert2_q;
    rVStage_uid804_lzcShifterZ1_uid241_Convert2_b <= rVStage_uid804_lzcShifterZ1_uid241_Convert2_in(31 downto 28);

	--vCount_uid805_lzcShifterZ1_uid241_Convert2(LOGICAL,804)@1
    vCount_uid805_lzcShifterZ1_uid241_Convert2_a <= rVStage_uid804_lzcShifterZ1_uid241_Convert2_b;
    vCount_uid805_lzcShifterZ1_uid241_Convert2_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid805_lzcShifterZ1_uid241_Convert2_q <= "1" when vCount_uid805_lzcShifterZ1_uid241_Convert2_a = vCount_uid805_lzcShifterZ1_uid241_Convert2_b else "0";

	--vStage_uid807_lzcShifterZ1_uid241_Convert2(BITSELECT,806)@1
    vStage_uid807_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid802_lzcShifterZ1_uid241_Convert2_q(27 downto 0);
    vStage_uid807_lzcShifterZ1_uid241_Convert2_b <= vStage_uid807_lzcShifterZ1_uid241_Convert2_in(27 downto 0);

	--cStage_uid808_lzcShifterZ1_uid241_Convert2(BITJOIN,807)@1
    cStage_uid808_lzcShifterZ1_uid241_Convert2_q <= vStage_uid807_lzcShifterZ1_uid241_Convert2_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--vStagei_uid809_lzcShifterZ1_uid241_Convert2(MUX,808)@1
    vStagei_uid809_lzcShifterZ1_uid241_Convert2_s <= vCount_uid805_lzcShifterZ1_uid241_Convert2_q;
    vStagei_uid809_lzcShifterZ1_uid241_Convert2: PROCESS (vStagei_uid809_lzcShifterZ1_uid241_Convert2_s, vStagei_uid802_lzcShifterZ1_uid241_Convert2_q, cStage_uid808_lzcShifterZ1_uid241_Convert2_q)
    BEGIN
            CASE vStagei_uid809_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vStagei_uid809_lzcShifterZ1_uid241_Convert2_q <= vStagei_uid802_lzcShifterZ1_uid241_Convert2_q;
                  WHEN "1" => vStagei_uid809_lzcShifterZ1_uid241_Convert2_q <= cStage_uid808_lzcShifterZ1_uid241_Convert2_q;
                  WHEN OTHERS => vStagei_uid809_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid811_lzcShifterZ1_uid241_Convert2(BITSELECT,810)@1
    rVStage_uid811_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid809_lzcShifterZ1_uid241_Convert2_q;
    rVStage_uid811_lzcShifterZ1_uid241_Convert2_b <= rVStage_uid811_lzcShifterZ1_uid241_Convert2_in(31 downto 30);

	--vCount_uid812_lzcShifterZ1_uid241_Convert2(LOGICAL,811)@1
    vCount_uid812_lzcShifterZ1_uid241_Convert2_a <= rVStage_uid811_lzcShifterZ1_uid241_Convert2_b;
    vCount_uid812_lzcShifterZ1_uid241_Convert2_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid812_lzcShifterZ1_uid241_Convert2_q <= "1" when vCount_uid812_lzcShifterZ1_uid241_Convert2_a = vCount_uid812_lzcShifterZ1_uid241_Convert2_b else "0";

	--vStage_uid814_lzcShifterZ1_uid241_Convert2(BITSELECT,813)@1
    vStage_uid814_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid809_lzcShifterZ1_uid241_Convert2_q(29 downto 0);
    vStage_uid814_lzcShifterZ1_uid241_Convert2_b <= vStage_uid814_lzcShifterZ1_uid241_Convert2_in(29 downto 0);

	--cStage_uid815_lzcShifterZ1_uid241_Convert2(BITJOIN,814)@1
    cStage_uid815_lzcShifterZ1_uid241_Convert2_q <= vStage_uid814_lzcShifterZ1_uid241_Convert2_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--vStagei_uid816_lzcShifterZ1_uid241_Convert2(MUX,815)@1
    vStagei_uid816_lzcShifterZ1_uid241_Convert2_s <= vCount_uid812_lzcShifterZ1_uid241_Convert2_q;
    vStagei_uid816_lzcShifterZ1_uid241_Convert2: PROCESS (vStagei_uid816_lzcShifterZ1_uid241_Convert2_s, vStagei_uid809_lzcShifterZ1_uid241_Convert2_q, cStage_uid815_lzcShifterZ1_uid241_Convert2_q)
    BEGIN
            CASE vStagei_uid816_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vStagei_uid816_lzcShifterZ1_uid241_Convert2_q <= vStagei_uid809_lzcShifterZ1_uid241_Convert2_q;
                  WHEN "1" => vStagei_uid816_lzcShifterZ1_uid241_Convert2_q <= cStage_uid815_lzcShifterZ1_uid241_Convert2_q;
                  WHEN OTHERS => vStagei_uid816_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid818_lzcShifterZ1_uid241_Convert2(BITSELECT,817)@1
    rVStage_uid818_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid816_lzcShifterZ1_uid241_Convert2_q;
    rVStage_uid818_lzcShifterZ1_uid241_Convert2_b <= rVStage_uid818_lzcShifterZ1_uid241_Convert2_in(31 downto 31);

	--vCount_uid819_lzcShifterZ1_uid241_Convert2(LOGICAL,818)@1
    vCount_uid819_lzcShifterZ1_uid241_Convert2_a <= rVStage_uid818_lzcShifterZ1_uid241_Convert2_b;
    vCount_uid819_lzcShifterZ1_uid241_Convert2_b <= GND_q;
    vCount_uid819_lzcShifterZ1_uid241_Convert2_q <= "1" when vCount_uid819_lzcShifterZ1_uid241_Convert2_a = vCount_uid819_lzcShifterZ1_uid241_Convert2_b else "0";

	--vCount_uid824_lzcShifterZ1_uid241_Convert2(BITJOIN,823)@1
    vCount_uid824_lzcShifterZ1_uid241_Convert2_q <= ld_vCount_uid786_lzcShifterZ1_uid241_Convert2_q_to_vCount_uid824_lzcShifterZ1_uid241_Convert2_f_q & vCount_uid791_lzcShifterZ1_uid241_Convert2_q & vCount_uid798_lzcShifterZ1_uid241_Convert2_q & vCount_uid805_lzcShifterZ1_uid241_Convert2_q & vCount_uid812_lzcShifterZ1_uid241_Convert2_q & vCount_uid819_lzcShifterZ1_uid241_Convert2_q;

	--reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1(REG,1100)@1
    reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1_q <= "000000";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1_q <= vCount_uid824_lzcShifterZ1_uid241_Convert2_q;
        END IF;
    END PROCESS;


	--vCountBig_uid826_lzcShifterZ1_uid241_Convert2(COMPARE,825)@2
    vCountBig_uid826_lzcShifterZ1_uid241_Convert2_cin <= GND_q;
    vCountBig_uid826_lzcShifterZ1_uid241_Convert2_a <= STD_LOGIC_VECTOR("00" & maxCount_uid182_Convert_q) & '0';
    vCountBig_uid826_lzcShifterZ1_uid241_Convert2_b <= STD_LOGIC_VECTOR("00" & reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1_q) & vCountBig_uid826_lzcShifterZ1_uid241_Convert2_cin(0);
            vCountBig_uid826_lzcShifterZ1_uid241_Convert2_o <= STD_LOGIC_VECTOR(UNSIGNED(vCountBig_uid826_lzcShifterZ1_uid241_Convert2_a) - UNSIGNED(vCountBig_uid826_lzcShifterZ1_uid241_Convert2_b));
    vCountBig_uid826_lzcShifterZ1_uid241_Convert2_c(0) <= vCountBig_uid826_lzcShifterZ1_uid241_Convert2_o(8);


	--vCountFinal_uid828_lzcShifterZ1_uid241_Convert2(MUX,827)@2
    vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_s <= vCountBig_uid826_lzcShifterZ1_uid241_Convert2_c;
    vCountFinal_uid828_lzcShifterZ1_uid241_Convert2: PROCESS (vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_s, reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1_q, maxCount_uid182_Convert_q)
    BEGIN
            CASE vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_q <= reg_vCount_uid824_lzcShifterZ1_uid241_Convert2_0_to_vCountBig_uid826_lzcShifterZ1_uid241_Convert2_1_q;
                  WHEN "1" => vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_q <= maxCount_uid182_Convert_q;
                  WHEN OTHERS => vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--expPreRnd_uid245_Convert2(SUB,244)@2
    expPreRnd_uid245_Convert2_a <= STD_LOGIC_VECTOR("0" & msbIn_uid184_Convert_q);
    expPreRnd_uid245_Convert2_b <= STD_LOGIC_VECTOR("000" & vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_q);
            expPreRnd_uid245_Convert2_o <= STD_LOGIC_VECTOR(UNSIGNED(expPreRnd_uid245_Convert2_a) - UNSIGNED(expPreRnd_uid245_Convert2_b));
    expPreRnd_uid245_Convert2_q <= expPreRnd_uid245_Convert2_o(8 downto 0);


	--vStage_uid821_lzcShifterZ1_uid241_Convert2(BITSELECT,820)@1
    vStage_uid821_lzcShifterZ1_uid241_Convert2_in <= vStagei_uid816_lzcShifterZ1_uid241_Convert2_q(30 downto 0);
    vStage_uid821_lzcShifterZ1_uid241_Convert2_b <= vStage_uid821_lzcShifterZ1_uid241_Convert2_in(30 downto 0);

	--cStage_uid822_lzcShifterZ1_uid241_Convert2(BITJOIN,821)@1
    cStage_uid822_lzcShifterZ1_uid241_Convert2_q <= vStage_uid821_lzcShifterZ1_uid241_Convert2_b & GND_q;

	--vStagei_uid823_lzcShifterZ1_uid241_Convert2(MUX,822)@1
    vStagei_uid823_lzcShifterZ1_uid241_Convert2_s <= vCount_uid819_lzcShifterZ1_uid241_Convert2_q;
    vStagei_uid823_lzcShifterZ1_uid241_Convert2: PROCESS (vStagei_uid823_lzcShifterZ1_uid241_Convert2_s, vStagei_uid816_lzcShifterZ1_uid241_Convert2_q, cStage_uid822_lzcShifterZ1_uid241_Convert2_q)
    BEGIN
            CASE vStagei_uid823_lzcShifterZ1_uid241_Convert2_s IS
                  WHEN "0" => vStagei_uid823_lzcShifterZ1_uid241_Convert2_q <= vStagei_uid816_lzcShifterZ1_uid241_Convert2_q;
                  WHEN "1" => vStagei_uid823_lzcShifterZ1_uid241_Convert2_q <= cStage_uid822_lzcShifterZ1_uid241_Convert2_q;
                  WHEN OTHERS => vStagei_uid823_lzcShifterZ1_uid241_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracRnd_uid246_Convert2(BITSELECT,245)@1
    fracRnd_uid246_Convert2_in <= vStagei_uid823_lzcShifterZ1_uid241_Convert2_q(30 downto 0);
    fracRnd_uid246_Convert2_b <= fracRnd_uid246_Convert2_in(30 downto 7);

	--reg_fracRnd_uid246_Convert2_0_to_expFracRnd_uid247_uid247_Convert2_0(REG,1102)@1
    reg_fracRnd_uid246_Convert2_0_to_expFracRnd_uid247_uid247_Convert2_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracRnd_uid246_Convert2_0_to_expFracRnd_uid247_uid247_Convert2_0_q <= "000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracRnd_uid246_Convert2_0_to_expFracRnd_uid247_uid247_Convert2_0_q <= fracRnd_uid246_Convert2_b;
        END IF;
    END PROCESS;


	--expFracRnd_uid247_uid247_Convert2(BITJOIN,246)@2
    expFracRnd_uid247_uid247_Convert2_q <= expPreRnd_uid245_Convert2_q & reg_fracRnd_uid246_Convert2_0_to_expFracRnd_uid247_uid247_Convert2_0_q;

	--expFracR_uid248_Convert2(ADD,247)@2
    expFracR_uid248_Convert2_a <= STD_LOGIC_VECTOR((34 downto 33 => expFracRnd_uid247_uid247_Convert2_q(32)) & expFracRnd_uid247_uid247_Convert2_q);
    expFracR_uid248_Convert2_b <= STD_LOGIC_VECTOR('0' & "000000000000000000000000000000000" & VCC_q);
            expFracR_uid248_Convert2_o <= STD_LOGIC_VECTOR(SIGNED(expFracR_uid248_Convert2_a) + SIGNED(expFracR_uid248_Convert2_b));
    expFracR_uid248_Convert2_q <= expFracR_uid248_Convert2_o(33 downto 0);


	--expR_uid250_Convert2(BITSELECT,249)@2
    expR_uid250_Convert2_in <= expFracR_uid248_Convert2_q;
    expR_uid250_Convert2_b <= expR_uid250_Convert2_in(33 downto 24);

	--expR_uid262_Convert2(BITSELECT,261)@2
    expR_uid262_Convert2_in <= expR_uid250_Convert2_b(7 downto 0);
    expR_uid262_Convert2_b <= expR_uid262_Convert2_in(7 downto 0);

	--reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2(REG,1106)@2
    reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2_q <= "00000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2_q <= expR_uid262_Convert2_b;
        END IF;
    END PROCESS;


	--reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1(REG,1103)@2
    reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q <= "0000000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q <= expR_uid250_Convert2_b;
        END IF;
    END PROCESS;


	--ovf_uid253_Convert2(COMPARE,252)@3
    ovf_uid253_Convert2_cin <= GND_q;
    ovf_uid253_Convert2_a <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q(9)) & reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q) & '0';
    ovf_uid253_Convert2_b <= STD_LOGIC_VECTOR('0' & "000" & expInf_uid192_Convert_q) & ovf_uid253_Convert2_cin(0);
            ovf_uid253_Convert2_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid253_Convert2_a) - SIGNED(ovf_uid253_Convert2_b));
    ovf_uid253_Convert2_n(0) <= not ovf_uid253_Convert2_o(12);


	--inIsZero_uid243_Convert2(LOGICAL,242)@2
    inIsZero_uid243_Convert2_a <= vCountFinal_uid828_lzcShifterZ1_uid241_Convert2_q;
    inIsZero_uid243_Convert2_b <= maxCount_uid182_Convert_q;
    inIsZero_uid243_Convert2_q_i <= "1" when inIsZero_uid243_Convert2_a = inIsZero_uid243_Convert2_b else "0";
    inIsZero_uid243_Convert2_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => inIsZero_uid243_Convert2_q, xin => inIsZero_uid243_Convert2_q_i, clk => clk, aclr => areset);

	--ovf_uid251_Convert2(COMPARE,250)@3
    ovf_uid251_Convert2_cin <= GND_q;
    ovf_uid251_Convert2_a <= STD_LOGIC_VECTOR('0' & "0000000000" & GND_q) & '0';
    ovf_uid251_Convert2_b <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q(9)) & reg_expR_uid250_Convert2_0_to_ovf_uid251_Convert2_1_q) & ovf_uid251_Convert2_cin(0);
            ovf_uid251_Convert2_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid251_Convert2_a) - SIGNED(ovf_uid251_Convert2_b));
    ovf_uid251_Convert2_n(0) <= not ovf_uid251_Convert2_o(12);


	--udfOrInZero_uid257_Convert2(LOGICAL,256)@3
    udfOrInZero_uid257_Convert2_a <= ovf_uid251_Convert2_n;
    udfOrInZero_uid257_Convert2_b <= inIsZero_uid243_Convert2_q;
    udfOrInZero_uid257_Convert2_q <= udfOrInZero_uid257_Convert2_a or udfOrInZero_uid257_Convert2_b;

	--excSelector_uid258_Convert2(BITJOIN,257)@3
    excSelector_uid258_Convert2_q <= ovf_uid253_Convert2_n & udfOrInZero_uid257_Convert2_q;

	--expRPostExc_uid263_Convert2(MUX,262)@3
    expRPostExc_uid263_Convert2_s <= excSelector_uid258_Convert2_q;
    expRPostExc_uid263_Convert2: PROCESS (expRPostExc_uid263_Convert2_s, reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2_q, zeroExponent_uid99_Acc_q, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid263_Convert2_s IS
                  WHEN "00" => expRPostExc_uid263_Convert2_q <= reg_expR_uid262_Convert2_0_to_expRPostExc_uid263_Convert2_2_q;
                  WHEN "01" => expRPostExc_uid263_Convert2_q <= zeroExponent_uid99_Acc_q;
                  WHEN "10" => expRPostExc_uid263_Convert2_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid263_Convert2_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid263_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid249_Convert2(BITSELECT,248)@2
    fracR_uid249_Convert2_in <= expFracR_uid248_Convert2_q(23 downto 0);
    fracR_uid249_Convert2_b <= fracR_uid249_Convert2_in(23 downto 1);

	--reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2(REG,1105)@2
    reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2_q <= fracR_uid249_Convert2_b;
        END IF;
    END PROCESS;


	--excSelector_uid254_Convert2(LOGICAL,253)@3
    excSelector_uid254_Convert2_a <= inIsZero_uid243_Convert2_q;
    excSelector_uid254_Convert2_b <= ovf_uid253_Convert2_n;
    excSelector_uid254_Convert2_q <= excSelector_uid254_Convert2_a or excSelector_uid254_Convert2_b;

	--fracRPostExc_uid256_Convert2(MUX,255)@3
    fracRPostExc_uid256_Convert2_s <= excSelector_uid254_Convert2_q;
    fracRPostExc_uid256_Convert2: PROCESS (fracRPostExc_uid256_Convert2_s, reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2_q, fracZ_uid195_Convert_q)
    BEGIN
            CASE fracRPostExc_uid256_Convert2_s IS
                  WHEN "0" => fracRPostExc_uid256_Convert2_q <= reg_fracR_uid249_Convert2_0_to_fracRPostExc_uid256_Convert2_2_q;
                  WHEN "1" => fracRPostExc_uid256_Convert2_q <= fracZ_uid195_Convert_q;
                  WHEN OTHERS => fracRPostExc_uid256_Convert2_q <= (others => '0');
            END CASE;
    END PROCESS;


	--outRes_uid264_Convert2(BITJOIN,263)@3
    outRes_uid264_Convert2_q <= ld_signX_uid237_Convert2_b_to_outRes_uid264_Convert2_c_q & expRPostExc_uid263_Convert2_q & fracRPostExc_uid256_Convert2_q;

	--Sub1_R_sub_f_0_cast(FLOATCAST,62)@3
    Sub1_R_sub_f_0_cast_reset <= areset;
    Sub1_R_sub_f_0_cast_a <= outRes_uid264_Convert2_q;
    Sub1_R_sub_f_0_cast_inst : cast_sIEEE_2_sInternal
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Sub1_R_sub_f_0_cast_reset,
    		dataa	 => Sub1_R_sub_f_0_cast_a,
    		result	 => Sub1_R_sub_f_0_cast_q
    	);
    -- synopsys translate off
    Sub1_R_sub_f_0_cast_q_real <= sInternal_2_real(Sub1_R_sub_f_0_cast_q);
    -- synopsys translate on

	--Sub1_R_sub_f(FLOATADDSUB,49)@5
    Sub1_R_sub_f_reset <= areset;
    Sub1_R_sub_f_add_sub	 <= not GND_q;
    Sub1_R_sub_f_inst : fp_addsub_sInternal_2_sInternal
    GENERIC MAP (
       addsub_resetval => '1'
    )
    PORT MAP (
    	add_sub	 => Sub1_R_sub_f_add_sub,
    	clk_en	 => '1',
    	clock	 => clk,
    	reset    => Sub1_R_sub_f_reset,
    	dataa	 => Sub1_R_sub_f_0_cast_q,
    	datab	 => Sub1_R_sub_f_1_cast_q,
    	result	 => Sub1_R_sub_f_q
   	);
    Sub1_R_sub_f_p <= not Sub1_R_sub_f_q(41 downto 41);
    Sub1_R_sub_f_n <= Sub1_R_sub_f_q(41 downto 41);
    -- synopsys translate off
    Sub1_R_sub_f_a_real <= sInternal_2_real(Sub1_R_sub_f_0_cast_q);
    Sub1_R_sub_f_b_real <= sInternal_2_real(Sub1_R_sub_f_1_cast_q);
    Sub1_R_sub_f_q_real <= sInternal_2_real(Sub1_R_sub_f_q);
    -- synopsys translate on

	--Mult1_f_0_cast(FLOATCAST,54)@10
    Mult1_f_0_cast_reset <= areset;
    Mult1_f_0_cast_a <= Sub1_R_sub_f_q;
    Mult1_f_0_cast_inst : cast_sInternal_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult1_f_0_cast_reset,
    		dataa	 => Mult1_f_0_cast_a,
    		result	 => Mult1_f_0_cast_q
    	);
    -- synopsys translate off
    Mult1_f_0_cast_q_real <= sNorm_2_real(Mult1_f_0_cast_q);
    -- synopsys translate on

	--ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg(REG,2364)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg_q <= "000000";
        ELSIF rising_edge(clk) THEN
            ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg_q <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt(COUNTER,2363)
    -- every=1, low=0, high=46, step=1, init=1
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i <= TO_UNSIGNED(1,6);
            ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i = 45 THEN
                  ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_eq <= '1';
                ELSE
                  ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_eq = '1') THEN
                    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i - 46;
                ELSE
                    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_i,6));


	--ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem(DUALMEM,2372)
    ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_ia <= Mult1_f_0_cast_q;
    ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_aa <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg_q;
    ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_ab <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_q;
    ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 45,
        widthad_a => 6,
        numwords_a => 47,
        width_b => 45,
        widthad_b => 6,
        numwords_b => 47,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken1 => ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_q(0),
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        aclr1 => ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_reset0,
        clock1 => clk,
        address_b => ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_iq,
        address_a => ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_aa,
        data_a => ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_ia
    );
    ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_reset0 <= areset;
        ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_q <= ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_iq(44 downto 0);

	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor(LOGICAL,2353)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_b <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_q <= not (ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_a or ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_b);

	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_mem_top(CONSTANT,2349)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_mem_top_q <= "011100";

	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp(LOGICAL,2350)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_mem_top_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_b <= STD_LOGIC_VECTOR("0" & ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_q);
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_q <= "1" when ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_a = ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_b else "0";

	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmpReg(REG,2351)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmpReg_q <= "0";
        ELSIF rising_edge(clk) THEN
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmpReg_q <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmp_q;
        END IF;
    END PROCESS;


	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena(REG,2354)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena_q <= "0";
        ELSIF rising_edge(clk) THEN
            IF (ld_Mult3_f_1_cast_q_to_Mult3_f_b_nor_q = "1") THEN
                ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena_q <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_cmpReg_q;
            END IF;
        END IF;
    END PROCESS;


	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd(LOGICAL,2355)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_sticky_ena_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_b <= VCC_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_q <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_a and ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_b;

	--signX_uid327_Convert5(BITSELECT,326)@0
    signX_uid327_Convert5_in <= m;
    signX_uid327_Convert5_b <= signX_uid327_Convert5_in(31 downto 31);

	--ld_signX_uid327_Convert5_b_to_outRes_uid354_Convert5_c(DELAY,1505)@0
    ld_signX_uid327_Convert5_b_to_outRes_uid354_Convert5_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => signX_uid327_Convert5_b, xout => ld_signX_uid327_Convert5_b_to_outRes_uid354_Convert5_c_q, clk => clk, aclr => areset );

	--xXorSign_uid328_Convert5(LOGICAL,327)@0
    xXorSign_uid328_Convert5_a <= m;
    xXorSign_uid328_Convert5_b <= STD_LOGIC_VECTOR((31 downto 1 => signX_uid327_Convert5_b(0)) & signX_uid327_Convert5_b);
    xXorSign_uid328_Convert5_q <= xXorSign_uid328_Convert5_a xor xXorSign_uid328_Convert5_b;

	--yE_uid329_Convert5(ADD,328)@0
    yE_uid329_Convert5_a <= STD_LOGIC_VECTOR((33 downto 32 => xXorSign_uid328_Convert5_q(31)) & xXorSign_uid328_Convert5_q);
    yE_uid329_Convert5_b <= STD_LOGIC_VECTOR('0' & "00000000000000000000000000000000" & signX_uid327_Convert5_b);
            yE_uid329_Convert5_o <= STD_LOGIC_VECTOR(SIGNED(yE_uid329_Convert5_a) + SIGNED(yE_uid329_Convert5_b));
    yE_uid329_Convert5_q <= yE_uid329_Convert5_o(32 downto 0);


	--y_uid330_Convert5(BITSELECT,329)@0
    y_uid330_Convert5_in <= yE_uid329_Convert5_q(31 downto 0);
    y_uid330_Convert5_b <= y_uid330_Convert5_in(31 downto 0);

	--vCount_uid927_lzcShifterZ1_uid331_Convert5(LOGICAL,926)@0
    vCount_uid927_lzcShifterZ1_uid331_Convert5_a <= y_uid330_Convert5_b;
    vCount_uid927_lzcShifterZ1_uid331_Convert5_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid927_lzcShifterZ1_uid331_Convert5_q <= "1" when vCount_uid927_lzcShifterZ1_uid331_Convert5_a = vCount_uid927_lzcShifterZ1_uid331_Convert5_b else "0";

	--ld_vCount_uid927_lzcShifterZ1_uid331_Convert5_q_to_vCount_uid965_lzcShifterZ1_uid331_Convert5_f(DELAY,2105)@0
    ld_vCount_uid927_lzcShifterZ1_uid331_Convert5_q_to_vCount_uid965_lzcShifterZ1_uid331_Convert5_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid927_lzcShifterZ1_uid331_Convert5_q, xout => ld_vCount_uid927_lzcShifterZ1_uid331_Convert5_q_to_vCount_uid965_lzcShifterZ1_uid331_Convert5_f_q, clk => clk, aclr => areset );

	--vStagei_uid929_lzcShifterZ1_uid331_Convert5(MUX,928)@0
    vStagei_uid929_lzcShifterZ1_uid331_Convert5_s <= vCount_uid927_lzcShifterZ1_uid331_Convert5_q;
    vStagei_uid929_lzcShifterZ1_uid331_Convert5: PROCESS (vStagei_uid929_lzcShifterZ1_uid331_Convert5_s, y_uid330_Convert5_b, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE vStagei_uid929_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vStagei_uid929_lzcShifterZ1_uid331_Convert5_q <= y_uid330_Convert5_b;
                  WHEN "1" => vStagei_uid929_lzcShifterZ1_uid331_Convert5_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => vStagei_uid929_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid931_lzcShifterZ1_uid331_Convert5(BITSELECT,930)@0
    rVStage_uid931_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid929_lzcShifterZ1_uid331_Convert5_q;
    rVStage_uid931_lzcShifterZ1_uid331_Convert5_b <= rVStage_uid931_lzcShifterZ1_uid331_Convert5_in(31 downto 16);

	--vCount_uid932_lzcShifterZ1_uid331_Convert5(LOGICAL,931)@0
    vCount_uid932_lzcShifterZ1_uid331_Convert5_a <= rVStage_uid931_lzcShifterZ1_uid331_Convert5_b;
    vCount_uid932_lzcShifterZ1_uid331_Convert5_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid932_lzcShifterZ1_uid331_Convert5_q_i <= "1" when vCount_uid932_lzcShifterZ1_uid331_Convert5_a = vCount_uid932_lzcShifterZ1_uid331_Convert5_b else "0";
    vCount_uid932_lzcShifterZ1_uid331_Convert5_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid932_lzcShifterZ1_uid331_Convert5_q, xin => vCount_uid932_lzcShifterZ1_uid331_Convert5_q_i, clk => clk, aclr => areset);

	--vStage_uid934_lzcShifterZ1_uid331_Convert5(BITSELECT,933)@0
    vStage_uid934_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid929_lzcShifterZ1_uid331_Convert5_q(15 downto 0);
    vStage_uid934_lzcShifterZ1_uid331_Convert5_b <= vStage_uid934_lzcShifterZ1_uid331_Convert5_in(15 downto 0);

	--cStage_uid935_lzcShifterZ1_uid331_Convert5(BITJOIN,934)@0
    cStage_uid935_lzcShifterZ1_uid331_Convert5_q <= vStage_uid934_lzcShifterZ1_uid331_Convert5_b & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3(REG,1130)@0
    reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3_q <= cStage_uid935_lzcShifterZ1_uid331_Convert5_q;
        END IF;
    END PROCESS;


	--reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2(REG,1129)@0
    reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2_q <= vStagei_uid929_lzcShifterZ1_uid331_Convert5_q;
        END IF;
    END PROCESS;


	--vStagei_uid936_lzcShifterZ1_uid331_Convert5(MUX,935)@1
    vStagei_uid936_lzcShifterZ1_uid331_Convert5_s <= vCount_uid932_lzcShifterZ1_uid331_Convert5_q;
    vStagei_uid936_lzcShifterZ1_uid331_Convert5: PROCESS (vStagei_uid936_lzcShifterZ1_uid331_Convert5_s, reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2_q, reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3_q)
    BEGIN
            CASE vStagei_uid936_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vStagei_uid936_lzcShifterZ1_uid331_Convert5_q <= reg_vStagei_uid929_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_2_q;
                  WHEN "1" => vStagei_uid936_lzcShifterZ1_uid331_Convert5_q <= reg_cStage_uid935_lzcShifterZ1_uid331_Convert5_0_to_vStagei_uid936_lzcShifterZ1_uid331_Convert5_3_q;
                  WHEN OTHERS => vStagei_uid936_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid938_lzcShifterZ1_uid331_Convert5(BITSELECT,937)@1
    rVStage_uid938_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid936_lzcShifterZ1_uid331_Convert5_q;
    rVStage_uid938_lzcShifterZ1_uid331_Convert5_b <= rVStage_uid938_lzcShifterZ1_uid331_Convert5_in(31 downto 24);

	--vCount_uid939_lzcShifterZ1_uid331_Convert5(LOGICAL,938)@1
    vCount_uid939_lzcShifterZ1_uid331_Convert5_a <= rVStage_uid938_lzcShifterZ1_uid331_Convert5_b;
    vCount_uid939_lzcShifterZ1_uid331_Convert5_b <= zeroExponent_uid99_Acc_q;
    vCount_uid939_lzcShifterZ1_uid331_Convert5_q <= "1" when vCount_uid939_lzcShifterZ1_uid331_Convert5_a = vCount_uid939_lzcShifterZ1_uid331_Convert5_b else "0";

	--vStage_uid941_lzcShifterZ1_uid331_Convert5(BITSELECT,940)@1
    vStage_uid941_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid936_lzcShifterZ1_uid331_Convert5_q(23 downto 0);
    vStage_uid941_lzcShifterZ1_uid331_Convert5_b <= vStage_uid941_lzcShifterZ1_uid331_Convert5_in(23 downto 0);

	--cStage_uid942_lzcShifterZ1_uid331_Convert5(BITJOIN,941)@1
    cStage_uid942_lzcShifterZ1_uid331_Convert5_q <= vStage_uid941_lzcShifterZ1_uid331_Convert5_b & zeroExponent_uid99_Acc_q;

	--vStagei_uid943_lzcShifterZ1_uid331_Convert5(MUX,942)@1
    vStagei_uid943_lzcShifterZ1_uid331_Convert5_s <= vCount_uid939_lzcShifterZ1_uid331_Convert5_q;
    vStagei_uid943_lzcShifterZ1_uid331_Convert5: PROCESS (vStagei_uid943_lzcShifterZ1_uid331_Convert5_s, vStagei_uid936_lzcShifterZ1_uid331_Convert5_q, cStage_uid942_lzcShifterZ1_uid331_Convert5_q)
    BEGIN
            CASE vStagei_uid943_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vStagei_uid943_lzcShifterZ1_uid331_Convert5_q <= vStagei_uid936_lzcShifterZ1_uid331_Convert5_q;
                  WHEN "1" => vStagei_uid943_lzcShifterZ1_uid331_Convert5_q <= cStage_uid942_lzcShifterZ1_uid331_Convert5_q;
                  WHEN OTHERS => vStagei_uid943_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid945_lzcShifterZ1_uid331_Convert5(BITSELECT,944)@1
    rVStage_uid945_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid943_lzcShifterZ1_uid331_Convert5_q;
    rVStage_uid945_lzcShifterZ1_uid331_Convert5_b <= rVStage_uid945_lzcShifterZ1_uid331_Convert5_in(31 downto 28);

	--vCount_uid946_lzcShifterZ1_uid331_Convert5(LOGICAL,945)@1
    vCount_uid946_lzcShifterZ1_uid331_Convert5_a <= rVStage_uid945_lzcShifterZ1_uid331_Convert5_b;
    vCount_uid946_lzcShifterZ1_uid331_Convert5_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid946_lzcShifterZ1_uid331_Convert5_q <= "1" when vCount_uid946_lzcShifterZ1_uid331_Convert5_a = vCount_uid946_lzcShifterZ1_uid331_Convert5_b else "0";

	--vStage_uid948_lzcShifterZ1_uid331_Convert5(BITSELECT,947)@1
    vStage_uid948_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid943_lzcShifterZ1_uid331_Convert5_q(27 downto 0);
    vStage_uid948_lzcShifterZ1_uid331_Convert5_b <= vStage_uid948_lzcShifterZ1_uid331_Convert5_in(27 downto 0);

	--cStage_uid949_lzcShifterZ1_uid331_Convert5(BITJOIN,948)@1
    cStage_uid949_lzcShifterZ1_uid331_Convert5_q <= vStage_uid948_lzcShifterZ1_uid331_Convert5_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--vStagei_uid950_lzcShifterZ1_uid331_Convert5(MUX,949)@1
    vStagei_uid950_lzcShifterZ1_uid331_Convert5_s <= vCount_uid946_lzcShifterZ1_uid331_Convert5_q;
    vStagei_uid950_lzcShifterZ1_uid331_Convert5: PROCESS (vStagei_uid950_lzcShifterZ1_uid331_Convert5_s, vStagei_uid943_lzcShifterZ1_uid331_Convert5_q, cStage_uid949_lzcShifterZ1_uid331_Convert5_q)
    BEGIN
            CASE vStagei_uid950_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vStagei_uid950_lzcShifterZ1_uid331_Convert5_q <= vStagei_uid943_lzcShifterZ1_uid331_Convert5_q;
                  WHEN "1" => vStagei_uid950_lzcShifterZ1_uid331_Convert5_q <= cStage_uid949_lzcShifterZ1_uid331_Convert5_q;
                  WHEN OTHERS => vStagei_uid950_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid952_lzcShifterZ1_uid331_Convert5(BITSELECT,951)@1
    rVStage_uid952_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid950_lzcShifterZ1_uid331_Convert5_q;
    rVStage_uid952_lzcShifterZ1_uid331_Convert5_b <= rVStage_uid952_lzcShifterZ1_uid331_Convert5_in(31 downto 30);

	--vCount_uid953_lzcShifterZ1_uid331_Convert5(LOGICAL,952)@1
    vCount_uid953_lzcShifterZ1_uid331_Convert5_a <= rVStage_uid952_lzcShifterZ1_uid331_Convert5_b;
    vCount_uid953_lzcShifterZ1_uid331_Convert5_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid953_lzcShifterZ1_uid331_Convert5_q <= "1" when vCount_uid953_lzcShifterZ1_uid331_Convert5_a = vCount_uid953_lzcShifterZ1_uid331_Convert5_b else "0";

	--vStage_uid955_lzcShifterZ1_uid331_Convert5(BITSELECT,954)@1
    vStage_uid955_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid950_lzcShifterZ1_uid331_Convert5_q(29 downto 0);
    vStage_uid955_lzcShifterZ1_uid331_Convert5_b <= vStage_uid955_lzcShifterZ1_uid331_Convert5_in(29 downto 0);

	--cStage_uid956_lzcShifterZ1_uid331_Convert5(BITJOIN,955)@1
    cStage_uid956_lzcShifterZ1_uid331_Convert5_q <= vStage_uid955_lzcShifterZ1_uid331_Convert5_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--vStagei_uid957_lzcShifterZ1_uid331_Convert5(MUX,956)@1
    vStagei_uid957_lzcShifterZ1_uid331_Convert5_s <= vCount_uid953_lzcShifterZ1_uid331_Convert5_q;
    vStagei_uid957_lzcShifterZ1_uid331_Convert5: PROCESS (vStagei_uid957_lzcShifterZ1_uid331_Convert5_s, vStagei_uid950_lzcShifterZ1_uid331_Convert5_q, cStage_uid956_lzcShifterZ1_uid331_Convert5_q)
    BEGIN
            CASE vStagei_uid957_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vStagei_uid957_lzcShifterZ1_uid331_Convert5_q <= vStagei_uid950_lzcShifterZ1_uid331_Convert5_q;
                  WHEN "1" => vStagei_uid957_lzcShifterZ1_uid331_Convert5_q <= cStage_uid956_lzcShifterZ1_uid331_Convert5_q;
                  WHEN OTHERS => vStagei_uid957_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid959_lzcShifterZ1_uid331_Convert5(BITSELECT,958)@1
    rVStage_uid959_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid957_lzcShifterZ1_uid331_Convert5_q;
    rVStage_uid959_lzcShifterZ1_uid331_Convert5_b <= rVStage_uid959_lzcShifterZ1_uid331_Convert5_in(31 downto 31);

	--vCount_uid960_lzcShifterZ1_uid331_Convert5(LOGICAL,959)@1
    vCount_uid960_lzcShifterZ1_uid331_Convert5_a <= rVStage_uid959_lzcShifterZ1_uid331_Convert5_b;
    vCount_uid960_lzcShifterZ1_uid331_Convert5_b <= GND_q;
    vCount_uid960_lzcShifterZ1_uid331_Convert5_q <= "1" when vCount_uid960_lzcShifterZ1_uid331_Convert5_a = vCount_uid960_lzcShifterZ1_uid331_Convert5_b else "0";

	--vCount_uid965_lzcShifterZ1_uid331_Convert5(BITJOIN,964)@1
    vCount_uid965_lzcShifterZ1_uid331_Convert5_q <= ld_vCount_uid927_lzcShifterZ1_uid331_Convert5_q_to_vCount_uid965_lzcShifterZ1_uid331_Convert5_f_q & vCount_uid932_lzcShifterZ1_uid331_Convert5_q & vCount_uid939_lzcShifterZ1_uid331_Convert5_q & vCount_uid946_lzcShifterZ1_uid331_Convert5_q & vCount_uid953_lzcShifterZ1_uid331_Convert5_q & vCount_uid960_lzcShifterZ1_uid331_Convert5_q;

	--reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1(REG,1131)@1
    reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1_q <= "000000";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1_q <= vCount_uid965_lzcShifterZ1_uid331_Convert5_q;
        END IF;
    END PROCESS;


	--vCountBig_uid967_lzcShifterZ1_uid331_Convert5(COMPARE,966)@2
    vCountBig_uid967_lzcShifterZ1_uid331_Convert5_cin <= GND_q;
    vCountBig_uid967_lzcShifterZ1_uid331_Convert5_a <= STD_LOGIC_VECTOR("00" & maxCount_uid182_Convert_q) & '0';
    vCountBig_uid967_lzcShifterZ1_uid331_Convert5_b <= STD_LOGIC_VECTOR("00" & reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1_q) & vCountBig_uid967_lzcShifterZ1_uid331_Convert5_cin(0);
            vCountBig_uid967_lzcShifterZ1_uid331_Convert5_o <= STD_LOGIC_VECTOR(UNSIGNED(vCountBig_uid967_lzcShifterZ1_uid331_Convert5_a) - UNSIGNED(vCountBig_uid967_lzcShifterZ1_uid331_Convert5_b));
    vCountBig_uid967_lzcShifterZ1_uid331_Convert5_c(0) <= vCountBig_uid967_lzcShifterZ1_uid331_Convert5_o(8);


	--vCountFinal_uid969_lzcShifterZ1_uid331_Convert5(MUX,968)@2
    vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_s <= vCountBig_uid967_lzcShifterZ1_uid331_Convert5_c;
    vCountFinal_uid969_lzcShifterZ1_uid331_Convert5: PROCESS (vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_s, reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1_q, maxCount_uid182_Convert_q)
    BEGIN
            CASE vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_q <= reg_vCount_uid965_lzcShifterZ1_uid331_Convert5_0_to_vCountBig_uid967_lzcShifterZ1_uid331_Convert5_1_q;
                  WHEN "1" => vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_q <= maxCount_uid182_Convert_q;
                  WHEN OTHERS => vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--expPreRnd_uid335_Convert5(SUB,334)@2
    expPreRnd_uid335_Convert5_a <= STD_LOGIC_VECTOR("0" & msbIn_uid184_Convert_q);
    expPreRnd_uid335_Convert5_b <= STD_LOGIC_VECTOR("000" & vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_q);
            expPreRnd_uid335_Convert5_o <= STD_LOGIC_VECTOR(UNSIGNED(expPreRnd_uid335_Convert5_a) - UNSIGNED(expPreRnd_uid335_Convert5_b));
    expPreRnd_uid335_Convert5_q <= expPreRnd_uid335_Convert5_o(8 downto 0);


	--vStage_uid962_lzcShifterZ1_uid331_Convert5(BITSELECT,961)@1
    vStage_uid962_lzcShifterZ1_uid331_Convert5_in <= vStagei_uid957_lzcShifterZ1_uid331_Convert5_q(30 downto 0);
    vStage_uid962_lzcShifterZ1_uid331_Convert5_b <= vStage_uid962_lzcShifterZ1_uid331_Convert5_in(30 downto 0);

	--cStage_uid963_lzcShifterZ1_uid331_Convert5(BITJOIN,962)@1
    cStage_uid963_lzcShifterZ1_uid331_Convert5_q <= vStage_uid962_lzcShifterZ1_uid331_Convert5_b & GND_q;

	--vStagei_uid964_lzcShifterZ1_uid331_Convert5(MUX,963)@1
    vStagei_uid964_lzcShifterZ1_uid331_Convert5_s <= vCount_uid960_lzcShifterZ1_uid331_Convert5_q;
    vStagei_uid964_lzcShifterZ1_uid331_Convert5: PROCESS (vStagei_uid964_lzcShifterZ1_uid331_Convert5_s, vStagei_uid957_lzcShifterZ1_uid331_Convert5_q, cStage_uid963_lzcShifterZ1_uid331_Convert5_q)
    BEGIN
            CASE vStagei_uid964_lzcShifterZ1_uid331_Convert5_s IS
                  WHEN "0" => vStagei_uid964_lzcShifterZ1_uid331_Convert5_q <= vStagei_uid957_lzcShifterZ1_uid331_Convert5_q;
                  WHEN "1" => vStagei_uid964_lzcShifterZ1_uid331_Convert5_q <= cStage_uid963_lzcShifterZ1_uid331_Convert5_q;
                  WHEN OTHERS => vStagei_uid964_lzcShifterZ1_uid331_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracRnd_uid336_Convert5(BITSELECT,335)@1
    fracRnd_uid336_Convert5_in <= vStagei_uid964_lzcShifterZ1_uid331_Convert5_q(30 downto 0);
    fracRnd_uid336_Convert5_b <= fracRnd_uid336_Convert5_in(30 downto 7);

	--reg_fracRnd_uid336_Convert5_0_to_expFracRnd_uid337_uid337_Convert5_0(REG,1133)@1
    reg_fracRnd_uid336_Convert5_0_to_expFracRnd_uid337_uid337_Convert5_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracRnd_uid336_Convert5_0_to_expFracRnd_uid337_uid337_Convert5_0_q <= "000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracRnd_uid336_Convert5_0_to_expFracRnd_uid337_uid337_Convert5_0_q <= fracRnd_uid336_Convert5_b;
        END IF;
    END PROCESS;


	--expFracRnd_uid337_uid337_Convert5(BITJOIN,336)@2
    expFracRnd_uid337_uid337_Convert5_q <= expPreRnd_uid335_Convert5_q & reg_fracRnd_uid336_Convert5_0_to_expFracRnd_uid337_uid337_Convert5_0_q;

	--expFracR_uid338_Convert5(ADD,337)@2
    expFracR_uid338_Convert5_a <= STD_LOGIC_VECTOR((34 downto 33 => expFracRnd_uid337_uid337_Convert5_q(32)) & expFracRnd_uid337_uid337_Convert5_q);
    expFracR_uid338_Convert5_b <= STD_LOGIC_VECTOR('0' & "000000000000000000000000000000000" & VCC_q);
            expFracR_uid338_Convert5_o <= STD_LOGIC_VECTOR(SIGNED(expFracR_uid338_Convert5_a) + SIGNED(expFracR_uid338_Convert5_b));
    expFracR_uid338_Convert5_q <= expFracR_uid338_Convert5_o(33 downto 0);


	--expR_uid340_Convert5(BITSELECT,339)@2
    expR_uid340_Convert5_in <= expFracR_uid338_Convert5_q;
    expR_uid340_Convert5_b <= expR_uid340_Convert5_in(33 downto 24);

	--expR_uid352_Convert5(BITSELECT,351)@2
    expR_uid352_Convert5_in <= expR_uid340_Convert5_b(7 downto 0);
    expR_uid352_Convert5_b <= expR_uid352_Convert5_in(7 downto 0);

	--reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2(REG,1137)@2
    reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2_q <= "00000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2_q <= expR_uid352_Convert5_b;
        END IF;
    END PROCESS;


	--reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1(REG,1134)@2
    reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q <= "0000000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q <= expR_uid340_Convert5_b;
        END IF;
    END PROCESS;


	--ovf_uid343_Convert5(COMPARE,342)@3
    ovf_uid343_Convert5_cin <= GND_q;
    ovf_uid343_Convert5_a <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q(9)) & reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q) & '0';
    ovf_uid343_Convert5_b <= STD_LOGIC_VECTOR('0' & "000" & expInf_uid192_Convert_q) & ovf_uid343_Convert5_cin(0);
            ovf_uid343_Convert5_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid343_Convert5_a) - SIGNED(ovf_uid343_Convert5_b));
    ovf_uid343_Convert5_n(0) <= not ovf_uid343_Convert5_o(12);


	--inIsZero_uid333_Convert5(LOGICAL,332)@2
    inIsZero_uid333_Convert5_a <= vCountFinal_uid969_lzcShifterZ1_uid331_Convert5_q;
    inIsZero_uid333_Convert5_b <= maxCount_uid182_Convert_q;
    inIsZero_uid333_Convert5_q_i <= "1" when inIsZero_uid333_Convert5_a = inIsZero_uid333_Convert5_b else "0";
    inIsZero_uid333_Convert5_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => inIsZero_uid333_Convert5_q, xin => inIsZero_uid333_Convert5_q_i, clk => clk, aclr => areset);

	--ovf_uid341_Convert5(COMPARE,340)@3
    ovf_uid341_Convert5_cin <= GND_q;
    ovf_uid341_Convert5_a <= STD_LOGIC_VECTOR('0' & "0000000000" & GND_q) & '0';
    ovf_uid341_Convert5_b <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q(9)) & reg_expR_uid340_Convert5_0_to_ovf_uid341_Convert5_1_q) & ovf_uid341_Convert5_cin(0);
            ovf_uid341_Convert5_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid341_Convert5_a) - SIGNED(ovf_uid341_Convert5_b));
    ovf_uid341_Convert5_n(0) <= not ovf_uid341_Convert5_o(12);


	--udfOrInZero_uid347_Convert5(LOGICAL,346)@3
    udfOrInZero_uid347_Convert5_a <= ovf_uid341_Convert5_n;
    udfOrInZero_uid347_Convert5_b <= inIsZero_uid333_Convert5_q;
    udfOrInZero_uid347_Convert5_q <= udfOrInZero_uid347_Convert5_a or udfOrInZero_uid347_Convert5_b;

	--excSelector_uid348_Convert5(BITJOIN,347)@3
    excSelector_uid348_Convert5_q <= ovf_uid343_Convert5_n & udfOrInZero_uid347_Convert5_q;

	--expRPostExc_uid353_Convert5(MUX,352)@3
    expRPostExc_uid353_Convert5_s <= excSelector_uid348_Convert5_q;
    expRPostExc_uid353_Convert5: PROCESS (expRPostExc_uid353_Convert5_s, reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2_q, zeroExponent_uid99_Acc_q, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid353_Convert5_s IS
                  WHEN "00" => expRPostExc_uid353_Convert5_q <= reg_expR_uid352_Convert5_0_to_expRPostExc_uid353_Convert5_2_q;
                  WHEN "01" => expRPostExc_uid353_Convert5_q <= zeroExponent_uid99_Acc_q;
                  WHEN "10" => expRPostExc_uid353_Convert5_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid353_Convert5_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid353_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid339_Convert5(BITSELECT,338)@2
    fracR_uid339_Convert5_in <= expFracR_uid338_Convert5_q(23 downto 0);
    fracR_uid339_Convert5_b <= fracR_uid339_Convert5_in(23 downto 1);

	--reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2(REG,1136)@2
    reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2_q <= fracR_uid339_Convert5_b;
        END IF;
    END PROCESS;


	--excSelector_uid344_Convert5(LOGICAL,343)@3
    excSelector_uid344_Convert5_a <= inIsZero_uid333_Convert5_q;
    excSelector_uid344_Convert5_b <= ovf_uid343_Convert5_n;
    excSelector_uid344_Convert5_q <= excSelector_uid344_Convert5_a or excSelector_uid344_Convert5_b;

	--fracRPostExc_uid346_Convert5(MUX,345)@3
    fracRPostExc_uid346_Convert5_s <= excSelector_uid344_Convert5_q;
    fracRPostExc_uid346_Convert5: PROCESS (fracRPostExc_uid346_Convert5_s, reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2_q, fracZ_uid195_Convert_q)
    BEGIN
            CASE fracRPostExc_uid346_Convert5_s IS
                  WHEN "0" => fracRPostExc_uid346_Convert5_q <= reg_fracR_uid339_Convert5_0_to_fracRPostExc_uid346_Convert5_2_q;
                  WHEN "1" => fracRPostExc_uid346_Convert5_q <= fracZ_uid195_Convert_q;
                  WHEN OTHERS => fracRPostExc_uid346_Convert5_q <= (others => '0');
            END CASE;
    END PROCESS;


	--outRes_uid354_Convert5(BITJOIN,353)@3
    outRes_uid354_Convert5_q <= ld_signX_uid327_Convert5_b_to_outRes_uid354_Convert5_c_q & expRPostExc_uid353_Convert5_q & fracRPostExc_uid346_Convert5_q;

	--signX_uid297_Convert4(BITSELECT,296)@0
    signX_uid297_Convert4_in <= ref_gm;
    signX_uid297_Convert4_b <= signX_uid297_Convert4_in(31 downto 31);

	--ld_signX_uid297_Convert4_b_to_outRes_uid324_Convert4_c(DELAY,1474)@0
    ld_signX_uid297_Convert4_b_to_outRes_uid324_Convert4_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => signX_uid297_Convert4_b, xout => ld_signX_uid297_Convert4_b_to_outRes_uid324_Convert4_c_q, clk => clk, aclr => areset );

	--xXorSign_uid298_Convert4(LOGICAL,297)@0
    xXorSign_uid298_Convert4_a <= ref_gm;
    xXorSign_uid298_Convert4_b <= STD_LOGIC_VECTOR((31 downto 1 => signX_uid297_Convert4_b(0)) & signX_uid297_Convert4_b);
    xXorSign_uid298_Convert4_q <= xXorSign_uid298_Convert4_a xor xXorSign_uid298_Convert4_b;

	--yE_uid299_Convert4(ADD,298)@0
    yE_uid299_Convert4_a <= STD_LOGIC_VECTOR((33 downto 32 => xXorSign_uid298_Convert4_q(31)) & xXorSign_uid298_Convert4_q);
    yE_uid299_Convert4_b <= STD_LOGIC_VECTOR('0' & "00000000000000000000000000000000" & signX_uid297_Convert4_b);
            yE_uid299_Convert4_o <= STD_LOGIC_VECTOR(SIGNED(yE_uid299_Convert4_a) + SIGNED(yE_uid299_Convert4_b));
    yE_uid299_Convert4_q <= yE_uid299_Convert4_o(32 downto 0);


	--y_uid300_Convert4(BITSELECT,299)@0
    y_uid300_Convert4_in <= yE_uid299_Convert4_q(31 downto 0);
    y_uid300_Convert4_b <= y_uid300_Convert4_in(31 downto 0);

	--vCount_uid880_lzcShifterZ1_uid301_Convert4(LOGICAL,879)@0
    vCount_uid880_lzcShifterZ1_uid301_Convert4_a <= y_uid300_Convert4_b;
    vCount_uid880_lzcShifterZ1_uid301_Convert4_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid880_lzcShifterZ1_uid301_Convert4_q <= "1" when vCount_uid880_lzcShifterZ1_uid301_Convert4_a = vCount_uid880_lzcShifterZ1_uid301_Convert4_b else "0";

	--ld_vCount_uid880_lzcShifterZ1_uid301_Convert4_q_to_vCount_uid918_lzcShifterZ1_uid301_Convert4_f(DELAY,2058)@0
    ld_vCount_uid880_lzcShifterZ1_uid301_Convert4_q_to_vCount_uid918_lzcShifterZ1_uid301_Convert4_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid880_lzcShifterZ1_uid301_Convert4_q, xout => ld_vCount_uid880_lzcShifterZ1_uid301_Convert4_q_to_vCount_uid918_lzcShifterZ1_uid301_Convert4_f_q, clk => clk, aclr => areset );

	--vStagei_uid882_lzcShifterZ1_uid301_Convert4(MUX,881)@0
    vStagei_uid882_lzcShifterZ1_uid301_Convert4_s <= vCount_uid880_lzcShifterZ1_uid301_Convert4_q;
    vStagei_uid882_lzcShifterZ1_uid301_Convert4: PROCESS (vStagei_uid882_lzcShifterZ1_uid301_Convert4_s, y_uid300_Convert4_b, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE vStagei_uid882_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vStagei_uid882_lzcShifterZ1_uid301_Convert4_q <= y_uid300_Convert4_b;
                  WHEN "1" => vStagei_uid882_lzcShifterZ1_uid301_Convert4_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => vStagei_uid882_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid884_lzcShifterZ1_uid301_Convert4(BITSELECT,883)@0
    rVStage_uid884_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid882_lzcShifterZ1_uid301_Convert4_q;
    rVStage_uid884_lzcShifterZ1_uid301_Convert4_b <= rVStage_uid884_lzcShifterZ1_uid301_Convert4_in(31 downto 16);

	--vCount_uid885_lzcShifterZ1_uid301_Convert4(LOGICAL,884)@0
    vCount_uid885_lzcShifterZ1_uid301_Convert4_a <= rVStage_uid884_lzcShifterZ1_uid301_Convert4_b;
    vCount_uid885_lzcShifterZ1_uid301_Convert4_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid885_lzcShifterZ1_uid301_Convert4_q_i <= "1" when vCount_uid885_lzcShifterZ1_uid301_Convert4_a = vCount_uid885_lzcShifterZ1_uid301_Convert4_b else "0";
    vCount_uid885_lzcShifterZ1_uid301_Convert4_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid885_lzcShifterZ1_uid301_Convert4_q, xin => vCount_uid885_lzcShifterZ1_uid301_Convert4_q_i, clk => clk, aclr => areset);

	--vStage_uid887_lzcShifterZ1_uid301_Convert4(BITSELECT,886)@0
    vStage_uid887_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid882_lzcShifterZ1_uid301_Convert4_q(15 downto 0);
    vStage_uid887_lzcShifterZ1_uid301_Convert4_b <= vStage_uid887_lzcShifterZ1_uid301_Convert4_in(15 downto 0);

	--cStage_uid888_lzcShifterZ1_uid301_Convert4(BITJOIN,887)@0
    cStage_uid888_lzcShifterZ1_uid301_Convert4_q <= vStage_uid887_lzcShifterZ1_uid301_Convert4_b & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3(REG,1121)@0
    reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3_q <= cStage_uid888_lzcShifterZ1_uid301_Convert4_q;
        END IF;
    END PROCESS;


	--reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2(REG,1120)@0
    reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2_q <= vStagei_uid882_lzcShifterZ1_uid301_Convert4_q;
        END IF;
    END PROCESS;


	--vStagei_uid889_lzcShifterZ1_uid301_Convert4(MUX,888)@1
    vStagei_uid889_lzcShifterZ1_uid301_Convert4_s <= vCount_uid885_lzcShifterZ1_uid301_Convert4_q;
    vStagei_uid889_lzcShifterZ1_uid301_Convert4: PROCESS (vStagei_uid889_lzcShifterZ1_uid301_Convert4_s, reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2_q, reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3_q)
    BEGIN
            CASE vStagei_uid889_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vStagei_uid889_lzcShifterZ1_uid301_Convert4_q <= reg_vStagei_uid882_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_2_q;
                  WHEN "1" => vStagei_uid889_lzcShifterZ1_uid301_Convert4_q <= reg_cStage_uid888_lzcShifterZ1_uid301_Convert4_0_to_vStagei_uid889_lzcShifterZ1_uid301_Convert4_3_q;
                  WHEN OTHERS => vStagei_uid889_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid891_lzcShifterZ1_uid301_Convert4(BITSELECT,890)@1
    rVStage_uid891_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid889_lzcShifterZ1_uid301_Convert4_q;
    rVStage_uid891_lzcShifterZ1_uid301_Convert4_b <= rVStage_uid891_lzcShifterZ1_uid301_Convert4_in(31 downto 24);

	--vCount_uid892_lzcShifterZ1_uid301_Convert4(LOGICAL,891)@1
    vCount_uid892_lzcShifterZ1_uid301_Convert4_a <= rVStage_uid891_lzcShifterZ1_uid301_Convert4_b;
    vCount_uid892_lzcShifterZ1_uid301_Convert4_b <= zeroExponent_uid99_Acc_q;
    vCount_uid892_lzcShifterZ1_uid301_Convert4_q <= "1" when vCount_uid892_lzcShifterZ1_uid301_Convert4_a = vCount_uid892_lzcShifterZ1_uid301_Convert4_b else "0";

	--vStage_uid894_lzcShifterZ1_uid301_Convert4(BITSELECT,893)@1
    vStage_uid894_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid889_lzcShifterZ1_uid301_Convert4_q(23 downto 0);
    vStage_uid894_lzcShifterZ1_uid301_Convert4_b <= vStage_uid894_lzcShifterZ1_uid301_Convert4_in(23 downto 0);

	--cStage_uid895_lzcShifterZ1_uid301_Convert4(BITJOIN,894)@1
    cStage_uid895_lzcShifterZ1_uid301_Convert4_q <= vStage_uid894_lzcShifterZ1_uid301_Convert4_b & zeroExponent_uid99_Acc_q;

	--vStagei_uid896_lzcShifterZ1_uid301_Convert4(MUX,895)@1
    vStagei_uid896_lzcShifterZ1_uid301_Convert4_s <= vCount_uid892_lzcShifterZ1_uid301_Convert4_q;
    vStagei_uid896_lzcShifterZ1_uid301_Convert4: PROCESS (vStagei_uid896_lzcShifterZ1_uid301_Convert4_s, vStagei_uid889_lzcShifterZ1_uid301_Convert4_q, cStage_uid895_lzcShifterZ1_uid301_Convert4_q)
    BEGIN
            CASE vStagei_uid896_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vStagei_uid896_lzcShifterZ1_uid301_Convert4_q <= vStagei_uid889_lzcShifterZ1_uid301_Convert4_q;
                  WHEN "1" => vStagei_uid896_lzcShifterZ1_uid301_Convert4_q <= cStage_uid895_lzcShifterZ1_uid301_Convert4_q;
                  WHEN OTHERS => vStagei_uid896_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid898_lzcShifterZ1_uid301_Convert4(BITSELECT,897)@1
    rVStage_uid898_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid896_lzcShifterZ1_uid301_Convert4_q;
    rVStage_uid898_lzcShifterZ1_uid301_Convert4_b <= rVStage_uid898_lzcShifterZ1_uid301_Convert4_in(31 downto 28);

	--vCount_uid899_lzcShifterZ1_uid301_Convert4(LOGICAL,898)@1
    vCount_uid899_lzcShifterZ1_uid301_Convert4_a <= rVStage_uid898_lzcShifterZ1_uid301_Convert4_b;
    vCount_uid899_lzcShifterZ1_uid301_Convert4_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid899_lzcShifterZ1_uid301_Convert4_q <= "1" when vCount_uid899_lzcShifterZ1_uid301_Convert4_a = vCount_uid899_lzcShifterZ1_uid301_Convert4_b else "0";

	--vStage_uid901_lzcShifterZ1_uid301_Convert4(BITSELECT,900)@1
    vStage_uid901_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid896_lzcShifterZ1_uid301_Convert4_q(27 downto 0);
    vStage_uid901_lzcShifterZ1_uid301_Convert4_b <= vStage_uid901_lzcShifterZ1_uid301_Convert4_in(27 downto 0);

	--cStage_uid902_lzcShifterZ1_uid301_Convert4(BITJOIN,901)@1
    cStage_uid902_lzcShifterZ1_uid301_Convert4_q <= vStage_uid901_lzcShifterZ1_uid301_Convert4_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--vStagei_uid903_lzcShifterZ1_uid301_Convert4(MUX,902)@1
    vStagei_uid903_lzcShifterZ1_uid301_Convert4_s <= vCount_uid899_lzcShifterZ1_uid301_Convert4_q;
    vStagei_uid903_lzcShifterZ1_uid301_Convert4: PROCESS (vStagei_uid903_lzcShifterZ1_uid301_Convert4_s, vStagei_uid896_lzcShifterZ1_uid301_Convert4_q, cStage_uid902_lzcShifterZ1_uid301_Convert4_q)
    BEGIN
            CASE vStagei_uid903_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vStagei_uid903_lzcShifterZ1_uid301_Convert4_q <= vStagei_uid896_lzcShifterZ1_uid301_Convert4_q;
                  WHEN "1" => vStagei_uid903_lzcShifterZ1_uid301_Convert4_q <= cStage_uid902_lzcShifterZ1_uid301_Convert4_q;
                  WHEN OTHERS => vStagei_uid903_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid905_lzcShifterZ1_uid301_Convert4(BITSELECT,904)@1
    rVStage_uid905_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid903_lzcShifterZ1_uid301_Convert4_q;
    rVStage_uid905_lzcShifterZ1_uid301_Convert4_b <= rVStage_uid905_lzcShifterZ1_uid301_Convert4_in(31 downto 30);

	--vCount_uid906_lzcShifterZ1_uid301_Convert4(LOGICAL,905)@1
    vCount_uid906_lzcShifterZ1_uid301_Convert4_a <= rVStage_uid905_lzcShifterZ1_uid301_Convert4_b;
    vCount_uid906_lzcShifterZ1_uid301_Convert4_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid906_lzcShifterZ1_uid301_Convert4_q <= "1" when vCount_uid906_lzcShifterZ1_uid301_Convert4_a = vCount_uid906_lzcShifterZ1_uid301_Convert4_b else "0";

	--vStage_uid908_lzcShifterZ1_uid301_Convert4(BITSELECT,907)@1
    vStage_uid908_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid903_lzcShifterZ1_uid301_Convert4_q(29 downto 0);
    vStage_uid908_lzcShifterZ1_uid301_Convert4_b <= vStage_uid908_lzcShifterZ1_uid301_Convert4_in(29 downto 0);

	--cStage_uid909_lzcShifterZ1_uid301_Convert4(BITJOIN,908)@1
    cStage_uid909_lzcShifterZ1_uid301_Convert4_q <= vStage_uid908_lzcShifterZ1_uid301_Convert4_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--vStagei_uid910_lzcShifterZ1_uid301_Convert4(MUX,909)@1
    vStagei_uid910_lzcShifterZ1_uid301_Convert4_s <= vCount_uid906_lzcShifterZ1_uid301_Convert4_q;
    vStagei_uid910_lzcShifterZ1_uid301_Convert4: PROCESS (vStagei_uid910_lzcShifterZ1_uid301_Convert4_s, vStagei_uid903_lzcShifterZ1_uid301_Convert4_q, cStage_uid909_lzcShifterZ1_uid301_Convert4_q)
    BEGIN
            CASE vStagei_uid910_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vStagei_uid910_lzcShifterZ1_uid301_Convert4_q <= vStagei_uid903_lzcShifterZ1_uid301_Convert4_q;
                  WHEN "1" => vStagei_uid910_lzcShifterZ1_uid301_Convert4_q <= cStage_uid909_lzcShifterZ1_uid301_Convert4_q;
                  WHEN OTHERS => vStagei_uid910_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid912_lzcShifterZ1_uid301_Convert4(BITSELECT,911)@1
    rVStage_uid912_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid910_lzcShifterZ1_uid301_Convert4_q;
    rVStage_uid912_lzcShifterZ1_uid301_Convert4_b <= rVStage_uid912_lzcShifterZ1_uid301_Convert4_in(31 downto 31);

	--vCount_uid913_lzcShifterZ1_uid301_Convert4(LOGICAL,912)@1
    vCount_uid913_lzcShifterZ1_uid301_Convert4_a <= rVStage_uid912_lzcShifterZ1_uid301_Convert4_b;
    vCount_uid913_lzcShifterZ1_uid301_Convert4_b <= GND_q;
    vCount_uid913_lzcShifterZ1_uid301_Convert4_q <= "1" when vCount_uid913_lzcShifterZ1_uid301_Convert4_a = vCount_uid913_lzcShifterZ1_uid301_Convert4_b else "0";

	--vCount_uid918_lzcShifterZ1_uid301_Convert4(BITJOIN,917)@1
    vCount_uid918_lzcShifterZ1_uid301_Convert4_q <= ld_vCount_uid880_lzcShifterZ1_uid301_Convert4_q_to_vCount_uid918_lzcShifterZ1_uid301_Convert4_f_q & vCount_uid885_lzcShifterZ1_uid301_Convert4_q & vCount_uid892_lzcShifterZ1_uid301_Convert4_q & vCount_uid899_lzcShifterZ1_uid301_Convert4_q & vCount_uid906_lzcShifterZ1_uid301_Convert4_q & vCount_uid913_lzcShifterZ1_uid301_Convert4_q;

	--reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1(REG,1122)@1
    reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1_q <= "000000";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1_q <= vCount_uid918_lzcShifterZ1_uid301_Convert4_q;
        END IF;
    END PROCESS;


	--vCountBig_uid920_lzcShifterZ1_uid301_Convert4(COMPARE,919)@2
    vCountBig_uid920_lzcShifterZ1_uid301_Convert4_cin <= GND_q;
    vCountBig_uid920_lzcShifterZ1_uid301_Convert4_a <= STD_LOGIC_VECTOR("00" & maxCount_uid182_Convert_q) & '0';
    vCountBig_uid920_lzcShifterZ1_uid301_Convert4_b <= STD_LOGIC_VECTOR("00" & reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1_q) & vCountBig_uid920_lzcShifterZ1_uid301_Convert4_cin(0);
            vCountBig_uid920_lzcShifterZ1_uid301_Convert4_o <= STD_LOGIC_VECTOR(UNSIGNED(vCountBig_uid920_lzcShifterZ1_uid301_Convert4_a) - UNSIGNED(vCountBig_uid920_lzcShifterZ1_uid301_Convert4_b));
    vCountBig_uid920_lzcShifterZ1_uid301_Convert4_c(0) <= vCountBig_uid920_lzcShifterZ1_uid301_Convert4_o(8);


	--vCountFinal_uid922_lzcShifterZ1_uid301_Convert4(MUX,921)@2
    vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_s <= vCountBig_uid920_lzcShifterZ1_uid301_Convert4_c;
    vCountFinal_uid922_lzcShifterZ1_uid301_Convert4: PROCESS (vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_s, reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1_q, maxCount_uid182_Convert_q)
    BEGIN
            CASE vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_q <= reg_vCount_uid918_lzcShifterZ1_uid301_Convert4_0_to_vCountBig_uid920_lzcShifterZ1_uid301_Convert4_1_q;
                  WHEN "1" => vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_q <= maxCount_uid182_Convert_q;
                  WHEN OTHERS => vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--expPreRnd_uid305_Convert4(SUB,304)@2
    expPreRnd_uid305_Convert4_a <= STD_LOGIC_VECTOR("0" & msbIn_uid184_Convert_q);
    expPreRnd_uid305_Convert4_b <= STD_LOGIC_VECTOR("000" & vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_q);
            expPreRnd_uid305_Convert4_o <= STD_LOGIC_VECTOR(UNSIGNED(expPreRnd_uid305_Convert4_a) - UNSIGNED(expPreRnd_uid305_Convert4_b));
    expPreRnd_uid305_Convert4_q <= expPreRnd_uid305_Convert4_o(8 downto 0);


	--vStage_uid915_lzcShifterZ1_uid301_Convert4(BITSELECT,914)@1
    vStage_uid915_lzcShifterZ1_uid301_Convert4_in <= vStagei_uid910_lzcShifterZ1_uid301_Convert4_q(30 downto 0);
    vStage_uid915_lzcShifterZ1_uid301_Convert4_b <= vStage_uid915_lzcShifterZ1_uid301_Convert4_in(30 downto 0);

	--cStage_uid916_lzcShifterZ1_uid301_Convert4(BITJOIN,915)@1
    cStage_uid916_lzcShifterZ1_uid301_Convert4_q <= vStage_uid915_lzcShifterZ1_uid301_Convert4_b & GND_q;

	--vStagei_uid917_lzcShifterZ1_uid301_Convert4(MUX,916)@1
    vStagei_uid917_lzcShifterZ1_uid301_Convert4_s <= vCount_uid913_lzcShifterZ1_uid301_Convert4_q;
    vStagei_uid917_lzcShifterZ1_uid301_Convert4: PROCESS (vStagei_uid917_lzcShifterZ1_uid301_Convert4_s, vStagei_uid910_lzcShifterZ1_uid301_Convert4_q, cStage_uid916_lzcShifterZ1_uid301_Convert4_q)
    BEGIN
            CASE vStagei_uid917_lzcShifterZ1_uid301_Convert4_s IS
                  WHEN "0" => vStagei_uid917_lzcShifterZ1_uid301_Convert4_q <= vStagei_uid910_lzcShifterZ1_uid301_Convert4_q;
                  WHEN "1" => vStagei_uid917_lzcShifterZ1_uid301_Convert4_q <= cStage_uid916_lzcShifterZ1_uid301_Convert4_q;
                  WHEN OTHERS => vStagei_uid917_lzcShifterZ1_uid301_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracRnd_uid306_Convert4(BITSELECT,305)@1
    fracRnd_uid306_Convert4_in <= vStagei_uid917_lzcShifterZ1_uid301_Convert4_q(30 downto 0);
    fracRnd_uid306_Convert4_b <= fracRnd_uid306_Convert4_in(30 downto 7);

	--reg_fracRnd_uid306_Convert4_0_to_expFracRnd_uid307_uid307_Convert4_0(REG,1124)@1
    reg_fracRnd_uid306_Convert4_0_to_expFracRnd_uid307_uid307_Convert4_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracRnd_uid306_Convert4_0_to_expFracRnd_uid307_uid307_Convert4_0_q <= "000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracRnd_uid306_Convert4_0_to_expFracRnd_uid307_uid307_Convert4_0_q <= fracRnd_uid306_Convert4_b;
        END IF;
    END PROCESS;


	--expFracRnd_uid307_uid307_Convert4(BITJOIN,306)@2
    expFracRnd_uid307_uid307_Convert4_q <= expPreRnd_uid305_Convert4_q & reg_fracRnd_uid306_Convert4_0_to_expFracRnd_uid307_uid307_Convert4_0_q;

	--expFracR_uid308_Convert4(ADD,307)@2
    expFracR_uid308_Convert4_a <= STD_LOGIC_VECTOR((34 downto 33 => expFracRnd_uid307_uid307_Convert4_q(32)) & expFracRnd_uid307_uid307_Convert4_q);
    expFracR_uid308_Convert4_b <= STD_LOGIC_VECTOR('0' & "000000000000000000000000000000000" & VCC_q);
            expFracR_uid308_Convert4_o <= STD_LOGIC_VECTOR(SIGNED(expFracR_uid308_Convert4_a) + SIGNED(expFracR_uid308_Convert4_b));
    expFracR_uid308_Convert4_q <= expFracR_uid308_Convert4_o(33 downto 0);


	--expR_uid310_Convert4(BITSELECT,309)@2
    expR_uid310_Convert4_in <= expFracR_uid308_Convert4_q;
    expR_uid310_Convert4_b <= expR_uid310_Convert4_in(33 downto 24);

	--expR_uid322_Convert4(BITSELECT,321)@2
    expR_uid322_Convert4_in <= expR_uid310_Convert4_b(7 downto 0);
    expR_uid322_Convert4_b <= expR_uid322_Convert4_in(7 downto 0);

	--reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2(REG,1128)@2
    reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2_q <= "00000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2_q <= expR_uid322_Convert4_b;
        END IF;
    END PROCESS;


	--reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1(REG,1125)@2
    reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q <= "0000000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q <= expR_uid310_Convert4_b;
        END IF;
    END PROCESS;


	--ovf_uid313_Convert4(COMPARE,312)@3
    ovf_uid313_Convert4_cin <= GND_q;
    ovf_uid313_Convert4_a <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q(9)) & reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q) & '0';
    ovf_uid313_Convert4_b <= STD_LOGIC_VECTOR('0' & "000" & expInf_uid192_Convert_q) & ovf_uid313_Convert4_cin(0);
            ovf_uid313_Convert4_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid313_Convert4_a) - SIGNED(ovf_uid313_Convert4_b));
    ovf_uid313_Convert4_n(0) <= not ovf_uid313_Convert4_o(12);


	--inIsZero_uid303_Convert4(LOGICAL,302)@2
    inIsZero_uid303_Convert4_a <= vCountFinal_uid922_lzcShifterZ1_uid301_Convert4_q;
    inIsZero_uid303_Convert4_b <= maxCount_uid182_Convert_q;
    inIsZero_uid303_Convert4_q_i <= "1" when inIsZero_uid303_Convert4_a = inIsZero_uid303_Convert4_b else "0";
    inIsZero_uid303_Convert4_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => inIsZero_uid303_Convert4_q, xin => inIsZero_uid303_Convert4_q_i, clk => clk, aclr => areset);

	--ovf_uid311_Convert4(COMPARE,310)@3
    ovf_uid311_Convert4_cin <= GND_q;
    ovf_uid311_Convert4_a <= STD_LOGIC_VECTOR('0' & "0000000000" & GND_q) & '0';
    ovf_uid311_Convert4_b <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q(9)) & reg_expR_uid310_Convert4_0_to_ovf_uid311_Convert4_1_q) & ovf_uid311_Convert4_cin(0);
            ovf_uid311_Convert4_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid311_Convert4_a) - SIGNED(ovf_uid311_Convert4_b));
    ovf_uid311_Convert4_n(0) <= not ovf_uid311_Convert4_o(12);


	--udfOrInZero_uid317_Convert4(LOGICAL,316)@3
    udfOrInZero_uid317_Convert4_a <= ovf_uid311_Convert4_n;
    udfOrInZero_uid317_Convert4_b <= inIsZero_uid303_Convert4_q;
    udfOrInZero_uid317_Convert4_q <= udfOrInZero_uid317_Convert4_a or udfOrInZero_uid317_Convert4_b;

	--excSelector_uid318_Convert4(BITJOIN,317)@3
    excSelector_uid318_Convert4_q <= ovf_uid313_Convert4_n & udfOrInZero_uid317_Convert4_q;

	--expRPostExc_uid323_Convert4(MUX,322)@3
    expRPostExc_uid323_Convert4_s <= excSelector_uid318_Convert4_q;
    expRPostExc_uid323_Convert4: PROCESS (expRPostExc_uid323_Convert4_s, reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2_q, zeroExponent_uid99_Acc_q, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid323_Convert4_s IS
                  WHEN "00" => expRPostExc_uid323_Convert4_q <= reg_expR_uid322_Convert4_0_to_expRPostExc_uid323_Convert4_2_q;
                  WHEN "01" => expRPostExc_uid323_Convert4_q <= zeroExponent_uid99_Acc_q;
                  WHEN "10" => expRPostExc_uid323_Convert4_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid323_Convert4_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid323_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid309_Convert4(BITSELECT,308)@2
    fracR_uid309_Convert4_in <= expFracR_uid308_Convert4_q(23 downto 0);
    fracR_uid309_Convert4_b <= fracR_uid309_Convert4_in(23 downto 1);

	--reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2(REG,1127)@2
    reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2_q <= fracR_uid309_Convert4_b;
        END IF;
    END PROCESS;


	--excSelector_uid314_Convert4(LOGICAL,313)@3
    excSelector_uid314_Convert4_a <= inIsZero_uid303_Convert4_q;
    excSelector_uid314_Convert4_b <= ovf_uid313_Convert4_n;
    excSelector_uid314_Convert4_q <= excSelector_uid314_Convert4_a or excSelector_uid314_Convert4_b;

	--fracRPostExc_uid316_Convert4(MUX,315)@3
    fracRPostExc_uid316_Convert4_s <= excSelector_uid314_Convert4_q;
    fracRPostExc_uid316_Convert4: PROCESS (fracRPostExc_uid316_Convert4_s, reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2_q, fracZ_uid195_Convert_q)
    BEGIN
            CASE fracRPostExc_uid316_Convert4_s IS
                  WHEN "0" => fracRPostExc_uid316_Convert4_q <= reg_fracR_uid309_Convert4_0_to_fracRPostExc_uid316_Convert4_2_q;
                  WHEN "1" => fracRPostExc_uid316_Convert4_q <= fracZ_uid195_Convert_q;
                  WHEN OTHERS => fracRPostExc_uid316_Convert4_q <= (others => '0');
            END CASE;
    END PROCESS;


	--outRes_uid324_Convert4(BITJOIN,323)@3
    outRes_uid324_Convert4_q <= ld_signX_uid297_Convert4_b_to_outRes_uid324_Convert4_c_q & expRPostExc_uid323_Convert4_q & fracRPostExc_uid316_Convert4_q;

	--Mult2_f(FLOATMULT,42)@3
    Mult2_f_reset <= areset;
    Mult2_f_inst : fp_mult_sIEEE_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult2_f_reset,
    		dataa	 => outRes_uid324_Convert4_q,
    		datab	 => outRes_uid354_Convert5_q,
    		result	 => Mult2_f_q
    	);
    -- synopsys translate off
    Mult2_f_a_real <= sIEEE_2_real(outRes_uid324_Convert4_q);
    Mult2_f_b_real <= sIEEE_2_real(outRes_uid354_Convert5_q);
    Mult2_f_q_real <= sInternal_2_real(Mult2_f_q);
    -- synopsys translate on

	--Mult3_f_1_cast(FLOATCAST,56)@7
    Mult3_f_1_cast_reset <= areset;
    Mult3_f_1_cast_a <= Mult2_f_q;
    Mult3_f_1_cast_inst : cast_sInternal_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult3_f_1_cast_reset,
    		dataa	 => Mult3_f_1_cast_a,
    		result	 => Mult3_f_1_cast_q
    	);
    -- synopsys translate off
    Mult3_f_1_cast_q_real <= sNorm_2_real(Mult3_f_1_cast_q);
    -- synopsys translate on

	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_wrreg(REG,2348)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_wrreg_q <= "00000";
        ELSIF rising_edge(clk) THEN
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_wrreg_q <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt(COUNTER,2347)
    -- every=1, low=0, high=28, step=1, init=1
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i <= TO_UNSIGNED(1,5);
            ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i = 27 THEN
                  ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_eq <= '1';
                ELSE
                  ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_eq = '1') THEN
                    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i - 28;
                ELSE
                    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_i,5));


	--ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem(DUALMEM,2346)
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_ia <= Mult3_f_1_cast_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_aa <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_wrreg_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_ab <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_rdcnt_q;
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 45,
        widthad_a => 5,
        numwords_a => 29,
        width_b => 45,
        widthad_b => 5,
        numwords_b => 29,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken1 => ld_Mult3_f_1_cast_q_to_Mult3_f_b_enaAnd_q(0),
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        aclr1 => ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_reset0,
        clock1 => clk,
        address_b => ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_iq,
        address_a => ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_aa,
        data_a => ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_ia
    );
    ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_reset0 <= areset;
        ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_q <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_iq(44 downto 0);

	--Mult1_f(FLOATMULT,41)@14
    Mult1_f_reset <= areset;
    Mult1_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult1_f_reset,
    		dataa	 => Mult1_f_0_cast_q,
    		datab	 => Mult1_f_0_cast_q,
    		result	 => Mult1_f_q
    	);
    -- synopsys translate off
    Mult1_f_a_real <= sNorm_2_real(Mult1_f_0_cast_q);
    Mult1_f_b_real <= sNorm_2_real(Mult1_f_0_cast_q);
    Mult1_f_q_real <= sInternal_2_real(Mult1_f_q);
    -- synopsys translate on

	--signX_uid207_Convert1(BITSELECT,206)@0
    signX_uid207_Convert1_in <= px;
    signX_uid207_Convert1_b <= signX_uid207_Convert1_in(31 downto 31);

	--ld_signX_uid207_Convert1_b_to_outRes_uid234_Convert1_c(DELAY,1381)@0
    ld_signX_uid207_Convert1_b_to_outRes_uid234_Convert1_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => signX_uid207_Convert1_b, xout => ld_signX_uid207_Convert1_b_to_outRes_uid234_Convert1_c_q, clk => clk, aclr => areset );

	--xXorSign_uid208_Convert1(LOGICAL,207)@0
    xXorSign_uid208_Convert1_a <= px;
    xXorSign_uid208_Convert1_b <= STD_LOGIC_VECTOR((31 downto 1 => signX_uid207_Convert1_b(0)) & signX_uid207_Convert1_b);
    xXorSign_uid208_Convert1_q <= xXorSign_uid208_Convert1_a xor xXorSign_uid208_Convert1_b;

	--yE_uid209_Convert1(ADD,208)@0
    yE_uid209_Convert1_a <= STD_LOGIC_VECTOR((33 downto 32 => xXorSign_uid208_Convert1_q(31)) & xXorSign_uid208_Convert1_q);
    yE_uid209_Convert1_b <= STD_LOGIC_VECTOR('0' & "00000000000000000000000000000000" & signX_uid207_Convert1_b);
            yE_uid209_Convert1_o <= STD_LOGIC_VECTOR(SIGNED(yE_uid209_Convert1_a) + SIGNED(yE_uid209_Convert1_b));
    yE_uid209_Convert1_q <= yE_uid209_Convert1_o(32 downto 0);


	--y_uid210_Convert1(BITSELECT,209)@0
    y_uid210_Convert1_in <= yE_uid209_Convert1_q(31 downto 0);
    y_uid210_Convert1_b <= y_uid210_Convert1_in(31 downto 0);

	--vCount_uid739_lzcShifterZ1_uid211_Convert1(LOGICAL,738)@0
    vCount_uid739_lzcShifterZ1_uid211_Convert1_a <= y_uid210_Convert1_b;
    vCount_uid739_lzcShifterZ1_uid211_Convert1_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid739_lzcShifterZ1_uid211_Convert1_q <= "1" when vCount_uid739_lzcShifterZ1_uid211_Convert1_a = vCount_uid739_lzcShifterZ1_uid211_Convert1_b else "0";

	--ld_vCount_uid739_lzcShifterZ1_uid211_Convert1_q_to_vCount_uid777_lzcShifterZ1_uid211_Convert1_f(DELAY,1917)@0
    ld_vCount_uid739_lzcShifterZ1_uid211_Convert1_q_to_vCount_uid777_lzcShifterZ1_uid211_Convert1_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid739_lzcShifterZ1_uid211_Convert1_q, xout => ld_vCount_uid739_lzcShifterZ1_uid211_Convert1_q_to_vCount_uid777_lzcShifterZ1_uid211_Convert1_f_q, clk => clk, aclr => areset );

	--vStagei_uid741_lzcShifterZ1_uid211_Convert1(MUX,740)@0
    vStagei_uid741_lzcShifterZ1_uid211_Convert1_s <= vCount_uid739_lzcShifterZ1_uid211_Convert1_q;
    vStagei_uid741_lzcShifterZ1_uid211_Convert1: PROCESS (vStagei_uid741_lzcShifterZ1_uid211_Convert1_s, y_uid210_Convert1_b, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE vStagei_uid741_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vStagei_uid741_lzcShifterZ1_uid211_Convert1_q <= y_uid210_Convert1_b;
                  WHEN "1" => vStagei_uid741_lzcShifterZ1_uid211_Convert1_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => vStagei_uid741_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid743_lzcShifterZ1_uid211_Convert1(BITSELECT,742)@0
    rVStage_uid743_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid741_lzcShifterZ1_uid211_Convert1_q;
    rVStage_uid743_lzcShifterZ1_uid211_Convert1_b <= rVStage_uid743_lzcShifterZ1_uid211_Convert1_in(31 downto 16);

	--vCount_uid744_lzcShifterZ1_uid211_Convert1(LOGICAL,743)@0
    vCount_uid744_lzcShifterZ1_uid211_Convert1_a <= rVStage_uid743_lzcShifterZ1_uid211_Convert1_b;
    vCount_uid744_lzcShifterZ1_uid211_Convert1_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid744_lzcShifterZ1_uid211_Convert1_q_i <= "1" when vCount_uid744_lzcShifterZ1_uid211_Convert1_a = vCount_uid744_lzcShifterZ1_uid211_Convert1_b else "0";
    vCount_uid744_lzcShifterZ1_uid211_Convert1_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid744_lzcShifterZ1_uid211_Convert1_q, xin => vCount_uid744_lzcShifterZ1_uid211_Convert1_q_i, clk => clk, aclr => areset);

	--vStage_uid746_lzcShifterZ1_uid211_Convert1(BITSELECT,745)@0
    vStage_uid746_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid741_lzcShifterZ1_uid211_Convert1_q(15 downto 0);
    vStage_uid746_lzcShifterZ1_uid211_Convert1_b <= vStage_uid746_lzcShifterZ1_uid211_Convert1_in(15 downto 0);

	--cStage_uid747_lzcShifterZ1_uid211_Convert1(BITJOIN,746)@0
    cStage_uid747_lzcShifterZ1_uid211_Convert1_q <= vStage_uid746_lzcShifterZ1_uid211_Convert1_b & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3(REG,1090)@0
    reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3_q <= cStage_uid747_lzcShifterZ1_uid211_Convert1_q;
        END IF;
    END PROCESS;


	--reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2(REG,1089)@0
    reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2_q <= vStagei_uid741_lzcShifterZ1_uid211_Convert1_q;
        END IF;
    END PROCESS;


	--vStagei_uid748_lzcShifterZ1_uid211_Convert1(MUX,747)@1
    vStagei_uid748_lzcShifterZ1_uid211_Convert1_s <= vCount_uid744_lzcShifterZ1_uid211_Convert1_q;
    vStagei_uid748_lzcShifterZ1_uid211_Convert1: PROCESS (vStagei_uid748_lzcShifterZ1_uid211_Convert1_s, reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2_q, reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3_q)
    BEGIN
            CASE vStagei_uid748_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vStagei_uid748_lzcShifterZ1_uid211_Convert1_q <= reg_vStagei_uid741_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_2_q;
                  WHEN "1" => vStagei_uid748_lzcShifterZ1_uid211_Convert1_q <= reg_cStage_uid747_lzcShifterZ1_uid211_Convert1_0_to_vStagei_uid748_lzcShifterZ1_uid211_Convert1_3_q;
                  WHEN OTHERS => vStagei_uid748_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid750_lzcShifterZ1_uid211_Convert1(BITSELECT,749)@1
    rVStage_uid750_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid748_lzcShifterZ1_uid211_Convert1_q;
    rVStage_uid750_lzcShifterZ1_uid211_Convert1_b <= rVStage_uid750_lzcShifterZ1_uid211_Convert1_in(31 downto 24);

	--vCount_uid751_lzcShifterZ1_uid211_Convert1(LOGICAL,750)@1
    vCount_uid751_lzcShifterZ1_uid211_Convert1_a <= rVStage_uid750_lzcShifterZ1_uid211_Convert1_b;
    vCount_uid751_lzcShifterZ1_uid211_Convert1_b <= zeroExponent_uid99_Acc_q;
    vCount_uid751_lzcShifterZ1_uid211_Convert1_q <= "1" when vCount_uid751_lzcShifterZ1_uid211_Convert1_a = vCount_uid751_lzcShifterZ1_uid211_Convert1_b else "0";

	--vStage_uid753_lzcShifterZ1_uid211_Convert1(BITSELECT,752)@1
    vStage_uid753_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid748_lzcShifterZ1_uid211_Convert1_q(23 downto 0);
    vStage_uid753_lzcShifterZ1_uid211_Convert1_b <= vStage_uid753_lzcShifterZ1_uid211_Convert1_in(23 downto 0);

	--cStage_uid754_lzcShifterZ1_uid211_Convert1(BITJOIN,753)@1
    cStage_uid754_lzcShifterZ1_uid211_Convert1_q <= vStage_uid753_lzcShifterZ1_uid211_Convert1_b & zeroExponent_uid99_Acc_q;

	--vStagei_uid755_lzcShifterZ1_uid211_Convert1(MUX,754)@1
    vStagei_uid755_lzcShifterZ1_uid211_Convert1_s <= vCount_uid751_lzcShifterZ1_uid211_Convert1_q;
    vStagei_uid755_lzcShifterZ1_uid211_Convert1: PROCESS (vStagei_uid755_lzcShifterZ1_uid211_Convert1_s, vStagei_uid748_lzcShifterZ1_uid211_Convert1_q, cStage_uid754_lzcShifterZ1_uid211_Convert1_q)
    BEGIN
            CASE vStagei_uid755_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vStagei_uid755_lzcShifterZ1_uid211_Convert1_q <= vStagei_uid748_lzcShifterZ1_uid211_Convert1_q;
                  WHEN "1" => vStagei_uid755_lzcShifterZ1_uid211_Convert1_q <= cStage_uid754_lzcShifterZ1_uid211_Convert1_q;
                  WHEN OTHERS => vStagei_uid755_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid757_lzcShifterZ1_uid211_Convert1(BITSELECT,756)@1
    rVStage_uid757_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid755_lzcShifterZ1_uid211_Convert1_q;
    rVStage_uid757_lzcShifterZ1_uid211_Convert1_b <= rVStage_uid757_lzcShifterZ1_uid211_Convert1_in(31 downto 28);

	--vCount_uid758_lzcShifterZ1_uid211_Convert1(LOGICAL,757)@1
    vCount_uid758_lzcShifterZ1_uid211_Convert1_a <= rVStage_uid757_lzcShifterZ1_uid211_Convert1_b;
    vCount_uid758_lzcShifterZ1_uid211_Convert1_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid758_lzcShifterZ1_uid211_Convert1_q <= "1" when vCount_uid758_lzcShifterZ1_uid211_Convert1_a = vCount_uid758_lzcShifterZ1_uid211_Convert1_b else "0";

	--vStage_uid760_lzcShifterZ1_uid211_Convert1(BITSELECT,759)@1
    vStage_uid760_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid755_lzcShifterZ1_uid211_Convert1_q(27 downto 0);
    vStage_uid760_lzcShifterZ1_uid211_Convert1_b <= vStage_uid760_lzcShifterZ1_uid211_Convert1_in(27 downto 0);

	--cStage_uid761_lzcShifterZ1_uid211_Convert1(BITJOIN,760)@1
    cStage_uid761_lzcShifterZ1_uid211_Convert1_q <= vStage_uid760_lzcShifterZ1_uid211_Convert1_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--vStagei_uid762_lzcShifterZ1_uid211_Convert1(MUX,761)@1
    vStagei_uid762_lzcShifterZ1_uid211_Convert1_s <= vCount_uid758_lzcShifterZ1_uid211_Convert1_q;
    vStagei_uid762_lzcShifterZ1_uid211_Convert1: PROCESS (vStagei_uid762_lzcShifterZ1_uid211_Convert1_s, vStagei_uid755_lzcShifterZ1_uid211_Convert1_q, cStage_uid761_lzcShifterZ1_uid211_Convert1_q)
    BEGIN
            CASE vStagei_uid762_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vStagei_uid762_lzcShifterZ1_uid211_Convert1_q <= vStagei_uid755_lzcShifterZ1_uid211_Convert1_q;
                  WHEN "1" => vStagei_uid762_lzcShifterZ1_uid211_Convert1_q <= cStage_uid761_lzcShifterZ1_uid211_Convert1_q;
                  WHEN OTHERS => vStagei_uid762_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid764_lzcShifterZ1_uid211_Convert1(BITSELECT,763)@1
    rVStage_uid764_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid762_lzcShifterZ1_uid211_Convert1_q;
    rVStage_uid764_lzcShifterZ1_uid211_Convert1_b <= rVStage_uid764_lzcShifterZ1_uid211_Convert1_in(31 downto 30);

	--vCount_uid765_lzcShifterZ1_uid211_Convert1(LOGICAL,764)@1
    vCount_uid765_lzcShifterZ1_uid211_Convert1_a <= rVStage_uid764_lzcShifterZ1_uid211_Convert1_b;
    vCount_uid765_lzcShifterZ1_uid211_Convert1_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid765_lzcShifterZ1_uid211_Convert1_q <= "1" when vCount_uid765_lzcShifterZ1_uid211_Convert1_a = vCount_uid765_lzcShifterZ1_uid211_Convert1_b else "0";

	--vStage_uid767_lzcShifterZ1_uid211_Convert1(BITSELECT,766)@1
    vStage_uid767_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid762_lzcShifterZ1_uid211_Convert1_q(29 downto 0);
    vStage_uid767_lzcShifterZ1_uid211_Convert1_b <= vStage_uid767_lzcShifterZ1_uid211_Convert1_in(29 downto 0);

	--cStage_uid768_lzcShifterZ1_uid211_Convert1(BITJOIN,767)@1
    cStage_uid768_lzcShifterZ1_uid211_Convert1_q <= vStage_uid767_lzcShifterZ1_uid211_Convert1_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--vStagei_uid769_lzcShifterZ1_uid211_Convert1(MUX,768)@1
    vStagei_uid769_lzcShifterZ1_uid211_Convert1_s <= vCount_uid765_lzcShifterZ1_uid211_Convert1_q;
    vStagei_uid769_lzcShifterZ1_uid211_Convert1: PROCESS (vStagei_uid769_lzcShifterZ1_uid211_Convert1_s, vStagei_uid762_lzcShifterZ1_uid211_Convert1_q, cStage_uid768_lzcShifterZ1_uid211_Convert1_q)
    BEGIN
            CASE vStagei_uid769_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vStagei_uid769_lzcShifterZ1_uid211_Convert1_q <= vStagei_uid762_lzcShifterZ1_uid211_Convert1_q;
                  WHEN "1" => vStagei_uid769_lzcShifterZ1_uid211_Convert1_q <= cStage_uid768_lzcShifterZ1_uid211_Convert1_q;
                  WHEN OTHERS => vStagei_uid769_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid771_lzcShifterZ1_uid211_Convert1(BITSELECT,770)@1
    rVStage_uid771_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid769_lzcShifterZ1_uid211_Convert1_q;
    rVStage_uid771_lzcShifterZ1_uid211_Convert1_b <= rVStage_uid771_lzcShifterZ1_uid211_Convert1_in(31 downto 31);

	--vCount_uid772_lzcShifterZ1_uid211_Convert1(LOGICAL,771)@1
    vCount_uid772_lzcShifterZ1_uid211_Convert1_a <= rVStage_uid771_lzcShifterZ1_uid211_Convert1_b;
    vCount_uid772_lzcShifterZ1_uid211_Convert1_b <= GND_q;
    vCount_uid772_lzcShifterZ1_uid211_Convert1_q <= "1" when vCount_uid772_lzcShifterZ1_uid211_Convert1_a = vCount_uid772_lzcShifterZ1_uid211_Convert1_b else "0";

	--vCount_uid777_lzcShifterZ1_uid211_Convert1(BITJOIN,776)@1
    vCount_uid777_lzcShifterZ1_uid211_Convert1_q <= ld_vCount_uid739_lzcShifterZ1_uid211_Convert1_q_to_vCount_uid777_lzcShifterZ1_uid211_Convert1_f_q & vCount_uid744_lzcShifterZ1_uid211_Convert1_q & vCount_uid751_lzcShifterZ1_uid211_Convert1_q & vCount_uid758_lzcShifterZ1_uid211_Convert1_q & vCount_uid765_lzcShifterZ1_uid211_Convert1_q & vCount_uid772_lzcShifterZ1_uid211_Convert1_q;

	--reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1(REG,1091)@1
    reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1_q <= "000000";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1_q <= vCount_uid777_lzcShifterZ1_uid211_Convert1_q;
        END IF;
    END PROCESS;


	--vCountBig_uid779_lzcShifterZ1_uid211_Convert1(COMPARE,778)@2
    vCountBig_uid779_lzcShifterZ1_uid211_Convert1_cin <= GND_q;
    vCountBig_uid779_lzcShifterZ1_uid211_Convert1_a <= STD_LOGIC_VECTOR("00" & maxCount_uid182_Convert_q) & '0';
    vCountBig_uid779_lzcShifterZ1_uid211_Convert1_b <= STD_LOGIC_VECTOR("00" & reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1_q) & vCountBig_uid779_lzcShifterZ1_uid211_Convert1_cin(0);
            vCountBig_uid779_lzcShifterZ1_uid211_Convert1_o <= STD_LOGIC_VECTOR(UNSIGNED(vCountBig_uid779_lzcShifterZ1_uid211_Convert1_a) - UNSIGNED(vCountBig_uid779_lzcShifterZ1_uid211_Convert1_b));
    vCountBig_uid779_lzcShifterZ1_uid211_Convert1_c(0) <= vCountBig_uid779_lzcShifterZ1_uid211_Convert1_o(8);


	--vCountFinal_uid781_lzcShifterZ1_uid211_Convert1(MUX,780)@2
    vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_s <= vCountBig_uid779_lzcShifterZ1_uid211_Convert1_c;
    vCountFinal_uid781_lzcShifterZ1_uid211_Convert1: PROCESS (vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_s, reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1_q, maxCount_uid182_Convert_q)
    BEGIN
            CASE vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_q <= reg_vCount_uid777_lzcShifterZ1_uid211_Convert1_0_to_vCountBig_uid779_lzcShifterZ1_uid211_Convert1_1_q;
                  WHEN "1" => vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_q <= maxCount_uid182_Convert_q;
                  WHEN OTHERS => vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--expPreRnd_uid215_Convert1(SUB,214)@2
    expPreRnd_uid215_Convert1_a <= STD_LOGIC_VECTOR("0" & msbIn_uid184_Convert_q);
    expPreRnd_uid215_Convert1_b <= STD_LOGIC_VECTOR("000" & vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_q);
            expPreRnd_uid215_Convert1_o <= STD_LOGIC_VECTOR(UNSIGNED(expPreRnd_uid215_Convert1_a) - UNSIGNED(expPreRnd_uid215_Convert1_b));
    expPreRnd_uid215_Convert1_q <= expPreRnd_uid215_Convert1_o(8 downto 0);


	--vStage_uid774_lzcShifterZ1_uid211_Convert1(BITSELECT,773)@1
    vStage_uid774_lzcShifterZ1_uid211_Convert1_in <= vStagei_uid769_lzcShifterZ1_uid211_Convert1_q(30 downto 0);
    vStage_uid774_lzcShifterZ1_uid211_Convert1_b <= vStage_uid774_lzcShifterZ1_uid211_Convert1_in(30 downto 0);

	--cStage_uid775_lzcShifterZ1_uid211_Convert1(BITJOIN,774)@1
    cStage_uid775_lzcShifterZ1_uid211_Convert1_q <= vStage_uid774_lzcShifterZ1_uid211_Convert1_b & GND_q;

	--vStagei_uid776_lzcShifterZ1_uid211_Convert1(MUX,775)@1
    vStagei_uid776_lzcShifterZ1_uid211_Convert1_s <= vCount_uid772_lzcShifterZ1_uid211_Convert1_q;
    vStagei_uid776_lzcShifterZ1_uid211_Convert1: PROCESS (vStagei_uid776_lzcShifterZ1_uid211_Convert1_s, vStagei_uid769_lzcShifterZ1_uid211_Convert1_q, cStage_uid775_lzcShifterZ1_uid211_Convert1_q)
    BEGIN
            CASE vStagei_uid776_lzcShifterZ1_uid211_Convert1_s IS
                  WHEN "0" => vStagei_uid776_lzcShifterZ1_uid211_Convert1_q <= vStagei_uid769_lzcShifterZ1_uid211_Convert1_q;
                  WHEN "1" => vStagei_uid776_lzcShifterZ1_uid211_Convert1_q <= cStage_uid775_lzcShifterZ1_uid211_Convert1_q;
                  WHEN OTHERS => vStagei_uid776_lzcShifterZ1_uid211_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracRnd_uid216_Convert1(BITSELECT,215)@1
    fracRnd_uid216_Convert1_in <= vStagei_uid776_lzcShifterZ1_uid211_Convert1_q(30 downto 0);
    fracRnd_uid216_Convert1_b <= fracRnd_uid216_Convert1_in(30 downto 7);

	--reg_fracRnd_uid216_Convert1_0_to_expFracRnd_uid217_uid217_Convert1_0(REG,1093)@1
    reg_fracRnd_uid216_Convert1_0_to_expFracRnd_uid217_uid217_Convert1_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracRnd_uid216_Convert1_0_to_expFracRnd_uid217_uid217_Convert1_0_q <= "000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracRnd_uid216_Convert1_0_to_expFracRnd_uid217_uid217_Convert1_0_q <= fracRnd_uid216_Convert1_b;
        END IF;
    END PROCESS;


	--expFracRnd_uid217_uid217_Convert1(BITJOIN,216)@2
    expFracRnd_uid217_uid217_Convert1_q <= expPreRnd_uid215_Convert1_q & reg_fracRnd_uid216_Convert1_0_to_expFracRnd_uid217_uid217_Convert1_0_q;

	--expFracR_uid218_Convert1(ADD,217)@2
    expFracR_uid218_Convert1_a <= STD_LOGIC_VECTOR((34 downto 33 => expFracRnd_uid217_uid217_Convert1_q(32)) & expFracRnd_uid217_uid217_Convert1_q);
    expFracR_uid218_Convert1_b <= STD_LOGIC_VECTOR('0' & "000000000000000000000000000000000" & VCC_q);
            expFracR_uid218_Convert1_o <= STD_LOGIC_VECTOR(SIGNED(expFracR_uid218_Convert1_a) + SIGNED(expFracR_uid218_Convert1_b));
    expFracR_uid218_Convert1_q <= expFracR_uid218_Convert1_o(33 downto 0);


	--expR_uid220_Convert1(BITSELECT,219)@2
    expR_uid220_Convert1_in <= expFracR_uid218_Convert1_q;
    expR_uid220_Convert1_b <= expR_uid220_Convert1_in(33 downto 24);

	--expR_uid232_Convert1(BITSELECT,231)@2
    expR_uid232_Convert1_in <= expR_uid220_Convert1_b(7 downto 0);
    expR_uid232_Convert1_b <= expR_uid232_Convert1_in(7 downto 0);

	--reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2(REG,1097)@2
    reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2_q <= "00000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2_q <= expR_uid232_Convert1_b;
        END IF;
    END PROCESS;


	--reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1(REG,1094)@2
    reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q <= "0000000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q <= expR_uid220_Convert1_b;
        END IF;
    END PROCESS;


	--ovf_uid223_Convert1(COMPARE,222)@3
    ovf_uid223_Convert1_cin <= GND_q;
    ovf_uid223_Convert1_a <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q(9)) & reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q) & '0';
    ovf_uid223_Convert1_b <= STD_LOGIC_VECTOR('0' & "000" & expInf_uid192_Convert_q) & ovf_uid223_Convert1_cin(0);
            ovf_uid223_Convert1_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid223_Convert1_a) - SIGNED(ovf_uid223_Convert1_b));
    ovf_uid223_Convert1_n(0) <= not ovf_uid223_Convert1_o(12);


	--inIsZero_uid213_Convert1(LOGICAL,212)@2
    inIsZero_uid213_Convert1_a <= vCountFinal_uid781_lzcShifterZ1_uid211_Convert1_q;
    inIsZero_uid213_Convert1_b <= maxCount_uid182_Convert_q;
    inIsZero_uid213_Convert1_q_i <= "1" when inIsZero_uid213_Convert1_a = inIsZero_uid213_Convert1_b else "0";
    inIsZero_uid213_Convert1_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => inIsZero_uid213_Convert1_q, xin => inIsZero_uid213_Convert1_q_i, clk => clk, aclr => areset);

	--ovf_uid221_Convert1(COMPARE,220)@3
    ovf_uid221_Convert1_cin <= GND_q;
    ovf_uid221_Convert1_a <= STD_LOGIC_VECTOR('0' & "0000000000" & GND_q) & '0';
    ovf_uid221_Convert1_b <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q(9)) & reg_expR_uid220_Convert1_0_to_ovf_uid221_Convert1_1_q) & ovf_uid221_Convert1_cin(0);
            ovf_uid221_Convert1_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid221_Convert1_a) - SIGNED(ovf_uid221_Convert1_b));
    ovf_uid221_Convert1_n(0) <= not ovf_uid221_Convert1_o(12);


	--udfOrInZero_uid227_Convert1(LOGICAL,226)@3
    udfOrInZero_uid227_Convert1_a <= ovf_uid221_Convert1_n;
    udfOrInZero_uid227_Convert1_b <= inIsZero_uid213_Convert1_q;
    udfOrInZero_uid227_Convert1_q <= udfOrInZero_uid227_Convert1_a or udfOrInZero_uid227_Convert1_b;

	--excSelector_uid228_Convert1(BITJOIN,227)@3
    excSelector_uid228_Convert1_q <= ovf_uid223_Convert1_n & udfOrInZero_uid227_Convert1_q;

	--expRPostExc_uid233_Convert1(MUX,232)@3
    expRPostExc_uid233_Convert1_s <= excSelector_uid228_Convert1_q;
    expRPostExc_uid233_Convert1: PROCESS (expRPostExc_uid233_Convert1_s, reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2_q, zeroExponent_uid99_Acc_q, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid233_Convert1_s IS
                  WHEN "00" => expRPostExc_uid233_Convert1_q <= reg_expR_uid232_Convert1_0_to_expRPostExc_uid233_Convert1_2_q;
                  WHEN "01" => expRPostExc_uid233_Convert1_q <= zeroExponent_uid99_Acc_q;
                  WHEN "10" => expRPostExc_uid233_Convert1_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid233_Convert1_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid233_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid219_Convert1(BITSELECT,218)@2
    fracR_uid219_Convert1_in <= expFracR_uid218_Convert1_q(23 downto 0);
    fracR_uid219_Convert1_b <= fracR_uid219_Convert1_in(23 downto 1);

	--reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2(REG,1096)@2
    reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2_q <= fracR_uid219_Convert1_b;
        END IF;
    END PROCESS;


	--excSelector_uid224_Convert1(LOGICAL,223)@3
    excSelector_uid224_Convert1_a <= inIsZero_uid213_Convert1_q;
    excSelector_uid224_Convert1_b <= ovf_uid223_Convert1_n;
    excSelector_uid224_Convert1_q <= excSelector_uid224_Convert1_a or excSelector_uid224_Convert1_b;

	--fracRPostExc_uid226_Convert1(MUX,225)@3
    fracRPostExc_uid226_Convert1_s <= excSelector_uid224_Convert1_q;
    fracRPostExc_uid226_Convert1: PROCESS (fracRPostExc_uid226_Convert1_s, reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2_q, fracZ_uid195_Convert_q)
    BEGIN
            CASE fracRPostExc_uid226_Convert1_s IS
                  WHEN "0" => fracRPostExc_uid226_Convert1_q <= reg_fracR_uid219_Convert1_0_to_fracRPostExc_uid226_Convert1_2_q;
                  WHEN "1" => fracRPostExc_uid226_Convert1_q <= fracZ_uid195_Convert_q;
                  WHEN OTHERS => fracRPostExc_uid226_Convert1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--outRes_uid234_Convert1(BITJOIN,233)@3
    outRes_uid234_Convert1_q <= ld_signX_uid207_Convert1_b_to_outRes_uid234_Convert1_c_q & expRPostExc_uid233_Convert1_q & fracRPostExc_uid226_Convert1_q;

	--Sub_R_sub_f_1_cast(FLOATCAST,61)@3
    Sub_R_sub_f_1_cast_reset <= areset;
    Sub_R_sub_f_1_cast_a <= outRes_uid234_Convert1_q;
    Sub_R_sub_f_1_cast_inst : cast_sIEEE_2_sInternal
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Sub_R_sub_f_1_cast_reset,
    		dataa	 => Sub_R_sub_f_1_cast_a,
    		result	 => Sub_R_sub_f_1_cast_q
    	);
    -- synopsys translate off
    Sub_R_sub_f_1_cast_q_real <= sInternal_2_real(Sub_R_sub_f_1_cast_q);
    -- synopsys translate on

	--signX_uid177_Convert(BITSELECT,176)@0
    signX_uid177_Convert_in <= ref_px;
    signX_uid177_Convert_b <= signX_uid177_Convert_in(31 downto 31);

	--ld_signX_uid177_Convert_b_to_outRes_uid204_Convert_c(DELAY,1350)@0
    ld_signX_uid177_Convert_b_to_outRes_uid204_Convert_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => signX_uid177_Convert_b, xout => ld_signX_uid177_Convert_b_to_outRes_uid204_Convert_c_q, clk => clk, aclr => areset );

	--xXorSign_uid178_Convert(LOGICAL,177)@0
    xXorSign_uid178_Convert_a <= ref_px;
    xXorSign_uid178_Convert_b <= STD_LOGIC_VECTOR((31 downto 1 => signX_uid177_Convert_b(0)) & signX_uid177_Convert_b);
    xXorSign_uid178_Convert_q <= xXorSign_uid178_Convert_a xor xXorSign_uid178_Convert_b;

	--yE_uid179_Convert(ADD,178)@0
    yE_uid179_Convert_a <= STD_LOGIC_VECTOR((33 downto 32 => xXorSign_uid178_Convert_q(31)) & xXorSign_uid178_Convert_q);
    yE_uid179_Convert_b <= STD_LOGIC_VECTOR('0' & "00000000000000000000000000000000" & signX_uid177_Convert_b);
            yE_uid179_Convert_o <= STD_LOGIC_VECTOR(SIGNED(yE_uid179_Convert_a) + SIGNED(yE_uid179_Convert_b));
    yE_uid179_Convert_q <= yE_uid179_Convert_o(32 downto 0);


	--y_uid180_Convert(BITSELECT,179)@0
    y_uid180_Convert_in <= yE_uid179_Convert_q(31 downto 0);
    y_uid180_Convert_b <= y_uid180_Convert_in(31 downto 0);

	--vCount_uid692_lzcShifterZ1_uid181_Convert(LOGICAL,691)@0
    vCount_uid692_lzcShifterZ1_uid181_Convert_a <= y_uid180_Convert_b;
    vCount_uid692_lzcShifterZ1_uid181_Convert_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid692_lzcShifterZ1_uid181_Convert_q <= "1" when vCount_uid692_lzcShifterZ1_uid181_Convert_a = vCount_uid692_lzcShifterZ1_uid181_Convert_b else "0";

	--ld_vCount_uid692_lzcShifterZ1_uid181_Convert_q_to_vCount_uid730_lzcShifterZ1_uid181_Convert_f(DELAY,1870)@0
    ld_vCount_uid692_lzcShifterZ1_uid181_Convert_q_to_vCount_uid730_lzcShifterZ1_uid181_Convert_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid692_lzcShifterZ1_uid181_Convert_q, xout => ld_vCount_uid692_lzcShifterZ1_uid181_Convert_q_to_vCount_uid730_lzcShifterZ1_uid181_Convert_f_q, clk => clk, aclr => areset );

	--vStagei_uid694_lzcShifterZ1_uid181_Convert(MUX,693)@0
    vStagei_uid694_lzcShifterZ1_uid181_Convert_s <= vCount_uid692_lzcShifterZ1_uid181_Convert_q;
    vStagei_uid694_lzcShifterZ1_uid181_Convert: PROCESS (vStagei_uid694_lzcShifterZ1_uid181_Convert_s, y_uid180_Convert_b, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE vStagei_uid694_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vStagei_uid694_lzcShifterZ1_uid181_Convert_q <= y_uid180_Convert_b;
                  WHEN "1" => vStagei_uid694_lzcShifterZ1_uid181_Convert_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => vStagei_uid694_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid696_lzcShifterZ1_uid181_Convert(BITSELECT,695)@0
    rVStage_uid696_lzcShifterZ1_uid181_Convert_in <= vStagei_uid694_lzcShifterZ1_uid181_Convert_q;
    rVStage_uid696_lzcShifterZ1_uid181_Convert_b <= rVStage_uid696_lzcShifterZ1_uid181_Convert_in(31 downto 16);

	--vCount_uid697_lzcShifterZ1_uid181_Convert(LOGICAL,696)@0
    vCount_uid697_lzcShifterZ1_uid181_Convert_a <= rVStage_uid696_lzcShifterZ1_uid181_Convert_b;
    vCount_uid697_lzcShifterZ1_uid181_Convert_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid697_lzcShifterZ1_uid181_Convert_q_i <= "1" when vCount_uid697_lzcShifterZ1_uid181_Convert_a = vCount_uid697_lzcShifterZ1_uid181_Convert_b else "0";
    vCount_uid697_lzcShifterZ1_uid181_Convert_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid697_lzcShifterZ1_uid181_Convert_q, xin => vCount_uid697_lzcShifterZ1_uid181_Convert_q_i, clk => clk, aclr => areset);

	--vStage_uid699_lzcShifterZ1_uid181_Convert(BITSELECT,698)@0
    vStage_uid699_lzcShifterZ1_uid181_Convert_in <= vStagei_uid694_lzcShifterZ1_uid181_Convert_q(15 downto 0);
    vStage_uid699_lzcShifterZ1_uid181_Convert_b <= vStage_uid699_lzcShifterZ1_uid181_Convert_in(15 downto 0);

	--cStage_uid700_lzcShifterZ1_uid181_Convert(BITJOIN,699)@0
    cStage_uid700_lzcShifterZ1_uid181_Convert_q <= vStage_uid699_lzcShifterZ1_uid181_Convert_b & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3(REG,1081)@0
    reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3_q <= cStage_uid700_lzcShifterZ1_uid181_Convert_q;
        END IF;
    END PROCESS;


	--reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2(REG,1080)@0
    reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2_q <= vStagei_uid694_lzcShifterZ1_uid181_Convert_q;
        END IF;
    END PROCESS;


	--vStagei_uid701_lzcShifterZ1_uid181_Convert(MUX,700)@1
    vStagei_uid701_lzcShifterZ1_uid181_Convert_s <= vCount_uid697_lzcShifterZ1_uid181_Convert_q;
    vStagei_uid701_lzcShifterZ1_uid181_Convert: PROCESS (vStagei_uid701_lzcShifterZ1_uid181_Convert_s, reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2_q, reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3_q)
    BEGIN
            CASE vStagei_uid701_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vStagei_uid701_lzcShifterZ1_uid181_Convert_q <= reg_vStagei_uid694_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_2_q;
                  WHEN "1" => vStagei_uid701_lzcShifterZ1_uid181_Convert_q <= reg_cStage_uid700_lzcShifterZ1_uid181_Convert_0_to_vStagei_uid701_lzcShifterZ1_uid181_Convert_3_q;
                  WHEN OTHERS => vStagei_uid701_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid703_lzcShifterZ1_uid181_Convert(BITSELECT,702)@1
    rVStage_uid703_lzcShifterZ1_uid181_Convert_in <= vStagei_uid701_lzcShifterZ1_uid181_Convert_q;
    rVStage_uid703_lzcShifterZ1_uid181_Convert_b <= rVStage_uid703_lzcShifterZ1_uid181_Convert_in(31 downto 24);

	--vCount_uid704_lzcShifterZ1_uid181_Convert(LOGICAL,703)@1
    vCount_uid704_lzcShifterZ1_uid181_Convert_a <= rVStage_uid703_lzcShifterZ1_uid181_Convert_b;
    vCount_uid704_lzcShifterZ1_uid181_Convert_b <= zeroExponent_uid99_Acc_q;
    vCount_uid704_lzcShifterZ1_uid181_Convert_q <= "1" when vCount_uid704_lzcShifterZ1_uid181_Convert_a = vCount_uid704_lzcShifterZ1_uid181_Convert_b else "0";

	--vStage_uid706_lzcShifterZ1_uid181_Convert(BITSELECT,705)@1
    vStage_uid706_lzcShifterZ1_uid181_Convert_in <= vStagei_uid701_lzcShifterZ1_uid181_Convert_q(23 downto 0);
    vStage_uid706_lzcShifterZ1_uid181_Convert_b <= vStage_uid706_lzcShifterZ1_uid181_Convert_in(23 downto 0);

	--cStage_uid707_lzcShifterZ1_uid181_Convert(BITJOIN,706)@1
    cStage_uid707_lzcShifterZ1_uid181_Convert_q <= vStage_uid706_lzcShifterZ1_uid181_Convert_b & zeroExponent_uid99_Acc_q;

	--vStagei_uid708_lzcShifterZ1_uid181_Convert(MUX,707)@1
    vStagei_uid708_lzcShifterZ1_uid181_Convert_s <= vCount_uid704_lzcShifterZ1_uid181_Convert_q;
    vStagei_uid708_lzcShifterZ1_uid181_Convert: PROCESS (vStagei_uid708_lzcShifterZ1_uid181_Convert_s, vStagei_uid701_lzcShifterZ1_uid181_Convert_q, cStage_uid707_lzcShifterZ1_uid181_Convert_q)
    BEGIN
            CASE vStagei_uid708_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vStagei_uid708_lzcShifterZ1_uid181_Convert_q <= vStagei_uid701_lzcShifterZ1_uid181_Convert_q;
                  WHEN "1" => vStagei_uid708_lzcShifterZ1_uid181_Convert_q <= cStage_uid707_lzcShifterZ1_uid181_Convert_q;
                  WHEN OTHERS => vStagei_uid708_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid710_lzcShifterZ1_uid181_Convert(BITSELECT,709)@1
    rVStage_uid710_lzcShifterZ1_uid181_Convert_in <= vStagei_uid708_lzcShifterZ1_uid181_Convert_q;
    rVStage_uid710_lzcShifterZ1_uid181_Convert_b <= rVStage_uid710_lzcShifterZ1_uid181_Convert_in(31 downto 28);

	--vCount_uid711_lzcShifterZ1_uid181_Convert(LOGICAL,710)@1
    vCount_uid711_lzcShifterZ1_uid181_Convert_a <= rVStage_uid710_lzcShifterZ1_uid181_Convert_b;
    vCount_uid711_lzcShifterZ1_uid181_Convert_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid711_lzcShifterZ1_uid181_Convert_q <= "1" when vCount_uid711_lzcShifterZ1_uid181_Convert_a = vCount_uid711_lzcShifterZ1_uid181_Convert_b else "0";

	--vStage_uid713_lzcShifterZ1_uid181_Convert(BITSELECT,712)@1
    vStage_uid713_lzcShifterZ1_uid181_Convert_in <= vStagei_uid708_lzcShifterZ1_uid181_Convert_q(27 downto 0);
    vStage_uid713_lzcShifterZ1_uid181_Convert_b <= vStage_uid713_lzcShifterZ1_uid181_Convert_in(27 downto 0);

	--cStage_uid714_lzcShifterZ1_uid181_Convert(BITJOIN,713)@1
    cStage_uid714_lzcShifterZ1_uid181_Convert_q <= vStage_uid713_lzcShifterZ1_uid181_Convert_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--vStagei_uid715_lzcShifterZ1_uid181_Convert(MUX,714)@1
    vStagei_uid715_lzcShifterZ1_uid181_Convert_s <= vCount_uid711_lzcShifterZ1_uid181_Convert_q;
    vStagei_uid715_lzcShifterZ1_uid181_Convert: PROCESS (vStagei_uid715_lzcShifterZ1_uid181_Convert_s, vStagei_uid708_lzcShifterZ1_uid181_Convert_q, cStage_uid714_lzcShifterZ1_uid181_Convert_q)
    BEGIN
            CASE vStagei_uid715_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vStagei_uid715_lzcShifterZ1_uid181_Convert_q <= vStagei_uid708_lzcShifterZ1_uid181_Convert_q;
                  WHEN "1" => vStagei_uid715_lzcShifterZ1_uid181_Convert_q <= cStage_uid714_lzcShifterZ1_uid181_Convert_q;
                  WHEN OTHERS => vStagei_uid715_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid717_lzcShifterZ1_uid181_Convert(BITSELECT,716)@1
    rVStage_uid717_lzcShifterZ1_uid181_Convert_in <= vStagei_uid715_lzcShifterZ1_uid181_Convert_q;
    rVStage_uid717_lzcShifterZ1_uid181_Convert_b <= rVStage_uid717_lzcShifterZ1_uid181_Convert_in(31 downto 30);

	--vCount_uid718_lzcShifterZ1_uid181_Convert(LOGICAL,717)@1
    vCount_uid718_lzcShifterZ1_uid181_Convert_a <= rVStage_uid717_lzcShifterZ1_uid181_Convert_b;
    vCount_uid718_lzcShifterZ1_uid181_Convert_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid718_lzcShifterZ1_uid181_Convert_q <= "1" when vCount_uid718_lzcShifterZ1_uid181_Convert_a = vCount_uid718_lzcShifterZ1_uid181_Convert_b else "0";

	--vStage_uid720_lzcShifterZ1_uid181_Convert(BITSELECT,719)@1
    vStage_uid720_lzcShifterZ1_uid181_Convert_in <= vStagei_uid715_lzcShifterZ1_uid181_Convert_q(29 downto 0);
    vStage_uid720_lzcShifterZ1_uid181_Convert_b <= vStage_uid720_lzcShifterZ1_uid181_Convert_in(29 downto 0);

	--cStage_uid721_lzcShifterZ1_uid181_Convert(BITJOIN,720)@1
    cStage_uid721_lzcShifterZ1_uid181_Convert_q <= vStage_uid720_lzcShifterZ1_uid181_Convert_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--vStagei_uid722_lzcShifterZ1_uid181_Convert(MUX,721)@1
    vStagei_uid722_lzcShifterZ1_uid181_Convert_s <= vCount_uid718_lzcShifterZ1_uid181_Convert_q;
    vStagei_uid722_lzcShifterZ1_uid181_Convert: PROCESS (vStagei_uid722_lzcShifterZ1_uid181_Convert_s, vStagei_uid715_lzcShifterZ1_uid181_Convert_q, cStage_uid721_lzcShifterZ1_uid181_Convert_q)
    BEGIN
            CASE vStagei_uid722_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vStagei_uid722_lzcShifterZ1_uid181_Convert_q <= vStagei_uid715_lzcShifterZ1_uid181_Convert_q;
                  WHEN "1" => vStagei_uid722_lzcShifterZ1_uid181_Convert_q <= cStage_uid721_lzcShifterZ1_uid181_Convert_q;
                  WHEN OTHERS => vStagei_uid722_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid724_lzcShifterZ1_uid181_Convert(BITSELECT,723)@1
    rVStage_uid724_lzcShifterZ1_uid181_Convert_in <= vStagei_uid722_lzcShifterZ1_uid181_Convert_q;
    rVStage_uid724_lzcShifterZ1_uid181_Convert_b <= rVStage_uid724_lzcShifterZ1_uid181_Convert_in(31 downto 31);

	--vCount_uid725_lzcShifterZ1_uid181_Convert(LOGICAL,724)@1
    vCount_uid725_lzcShifterZ1_uid181_Convert_a <= rVStage_uid724_lzcShifterZ1_uid181_Convert_b;
    vCount_uid725_lzcShifterZ1_uid181_Convert_b <= GND_q;
    vCount_uid725_lzcShifterZ1_uid181_Convert_q <= "1" when vCount_uid725_lzcShifterZ1_uid181_Convert_a = vCount_uid725_lzcShifterZ1_uid181_Convert_b else "0";

	--vCount_uid730_lzcShifterZ1_uid181_Convert(BITJOIN,729)@1
    vCount_uid730_lzcShifterZ1_uid181_Convert_q <= ld_vCount_uid692_lzcShifterZ1_uid181_Convert_q_to_vCount_uid730_lzcShifterZ1_uid181_Convert_f_q & vCount_uid697_lzcShifterZ1_uid181_Convert_q & vCount_uid704_lzcShifterZ1_uid181_Convert_q & vCount_uid711_lzcShifterZ1_uid181_Convert_q & vCount_uid718_lzcShifterZ1_uid181_Convert_q & vCount_uid725_lzcShifterZ1_uid181_Convert_q;

	--reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1(REG,1082)@1
    reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1_q <= "000000";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1_q <= vCount_uid730_lzcShifterZ1_uid181_Convert_q;
        END IF;
    END PROCESS;


	--vCountBig_uid732_lzcShifterZ1_uid181_Convert(COMPARE,731)@2
    vCountBig_uid732_lzcShifterZ1_uid181_Convert_cin <= GND_q;
    vCountBig_uid732_lzcShifterZ1_uid181_Convert_a <= STD_LOGIC_VECTOR("00" & maxCount_uid182_Convert_q) & '0';
    vCountBig_uid732_lzcShifterZ1_uid181_Convert_b <= STD_LOGIC_VECTOR("00" & reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1_q) & vCountBig_uid732_lzcShifterZ1_uid181_Convert_cin(0);
            vCountBig_uid732_lzcShifterZ1_uid181_Convert_o <= STD_LOGIC_VECTOR(UNSIGNED(vCountBig_uid732_lzcShifterZ1_uid181_Convert_a) - UNSIGNED(vCountBig_uid732_lzcShifterZ1_uid181_Convert_b));
    vCountBig_uid732_lzcShifterZ1_uid181_Convert_c(0) <= vCountBig_uid732_lzcShifterZ1_uid181_Convert_o(8);


	--vCountFinal_uid734_lzcShifterZ1_uid181_Convert(MUX,733)@2
    vCountFinal_uid734_lzcShifterZ1_uid181_Convert_s <= vCountBig_uid732_lzcShifterZ1_uid181_Convert_c;
    vCountFinal_uid734_lzcShifterZ1_uid181_Convert: PROCESS (vCountFinal_uid734_lzcShifterZ1_uid181_Convert_s, reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1_q, maxCount_uid182_Convert_q)
    BEGIN
            CASE vCountFinal_uid734_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vCountFinal_uid734_lzcShifterZ1_uid181_Convert_q <= reg_vCount_uid730_lzcShifterZ1_uid181_Convert_0_to_vCountBig_uid732_lzcShifterZ1_uid181_Convert_1_q;
                  WHEN "1" => vCountFinal_uid734_lzcShifterZ1_uid181_Convert_q <= maxCount_uid182_Convert_q;
                  WHEN OTHERS => vCountFinal_uid734_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--expPreRnd_uid185_Convert(SUB,184)@2
    expPreRnd_uid185_Convert_a <= STD_LOGIC_VECTOR("0" & msbIn_uid184_Convert_q);
    expPreRnd_uid185_Convert_b <= STD_LOGIC_VECTOR("000" & vCountFinal_uid734_lzcShifterZ1_uid181_Convert_q);
            expPreRnd_uid185_Convert_o <= STD_LOGIC_VECTOR(UNSIGNED(expPreRnd_uid185_Convert_a) - UNSIGNED(expPreRnd_uid185_Convert_b));
    expPreRnd_uid185_Convert_q <= expPreRnd_uid185_Convert_o(8 downto 0);


	--vStage_uid727_lzcShifterZ1_uid181_Convert(BITSELECT,726)@1
    vStage_uid727_lzcShifterZ1_uid181_Convert_in <= vStagei_uid722_lzcShifterZ1_uid181_Convert_q(30 downto 0);
    vStage_uid727_lzcShifterZ1_uid181_Convert_b <= vStage_uid727_lzcShifterZ1_uid181_Convert_in(30 downto 0);

	--cStage_uid728_lzcShifterZ1_uid181_Convert(BITJOIN,727)@1
    cStage_uid728_lzcShifterZ1_uid181_Convert_q <= vStage_uid727_lzcShifterZ1_uid181_Convert_b & GND_q;

	--vStagei_uid729_lzcShifterZ1_uid181_Convert(MUX,728)@1
    vStagei_uid729_lzcShifterZ1_uid181_Convert_s <= vCount_uid725_lzcShifterZ1_uid181_Convert_q;
    vStagei_uid729_lzcShifterZ1_uid181_Convert: PROCESS (vStagei_uid729_lzcShifterZ1_uid181_Convert_s, vStagei_uid722_lzcShifterZ1_uid181_Convert_q, cStage_uid728_lzcShifterZ1_uid181_Convert_q)
    BEGIN
            CASE vStagei_uid729_lzcShifterZ1_uid181_Convert_s IS
                  WHEN "0" => vStagei_uid729_lzcShifterZ1_uid181_Convert_q <= vStagei_uid722_lzcShifterZ1_uid181_Convert_q;
                  WHEN "1" => vStagei_uid729_lzcShifterZ1_uid181_Convert_q <= cStage_uid728_lzcShifterZ1_uid181_Convert_q;
                  WHEN OTHERS => vStagei_uid729_lzcShifterZ1_uid181_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracRnd_uid186_Convert(BITSELECT,185)@1
    fracRnd_uid186_Convert_in <= vStagei_uid729_lzcShifterZ1_uid181_Convert_q(30 downto 0);
    fracRnd_uid186_Convert_b <= fracRnd_uid186_Convert_in(30 downto 7);

	--reg_fracRnd_uid186_Convert_0_to_expFracRnd_uid187_uid187_Convert_0(REG,1084)@1
    reg_fracRnd_uid186_Convert_0_to_expFracRnd_uid187_uid187_Convert_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracRnd_uid186_Convert_0_to_expFracRnd_uid187_uid187_Convert_0_q <= "000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracRnd_uid186_Convert_0_to_expFracRnd_uid187_uid187_Convert_0_q <= fracRnd_uid186_Convert_b;
        END IF;
    END PROCESS;


	--expFracRnd_uid187_uid187_Convert(BITJOIN,186)@2
    expFracRnd_uid187_uid187_Convert_q <= expPreRnd_uid185_Convert_q & reg_fracRnd_uid186_Convert_0_to_expFracRnd_uid187_uid187_Convert_0_q;

	--expFracR_uid188_Convert(ADD,187)@2
    expFracR_uid188_Convert_a <= STD_LOGIC_VECTOR((34 downto 33 => expFracRnd_uid187_uid187_Convert_q(32)) & expFracRnd_uid187_uid187_Convert_q);
    expFracR_uid188_Convert_b <= STD_LOGIC_VECTOR('0' & "000000000000000000000000000000000" & VCC_q);
            expFracR_uid188_Convert_o <= STD_LOGIC_VECTOR(SIGNED(expFracR_uid188_Convert_a) + SIGNED(expFracR_uid188_Convert_b));
    expFracR_uid188_Convert_q <= expFracR_uid188_Convert_o(33 downto 0);


	--expR_uid190_Convert(BITSELECT,189)@2
    expR_uid190_Convert_in <= expFracR_uid188_Convert_q;
    expR_uid190_Convert_b <= expR_uid190_Convert_in(33 downto 24);

	--expR_uid202_Convert(BITSELECT,201)@2
    expR_uid202_Convert_in <= expR_uid190_Convert_b(7 downto 0);
    expR_uid202_Convert_b <= expR_uid202_Convert_in(7 downto 0);

	--reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2(REG,1088)@2
    reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2_q <= "00000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2_q <= expR_uid202_Convert_b;
        END IF;
    END PROCESS;


	--reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1(REG,1085)@2
    reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q <= "0000000000";
        ELSIF rising_edge(clk) THEN
            reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q <= expR_uid190_Convert_b;
        END IF;
    END PROCESS;


	--ovf_uid193_Convert(COMPARE,192)@3
    ovf_uid193_Convert_cin <= GND_q;
    ovf_uid193_Convert_a <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q(9)) & reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q) & '0';
    ovf_uid193_Convert_b <= STD_LOGIC_VECTOR('0' & "000" & expInf_uid192_Convert_q) & ovf_uid193_Convert_cin(0);
            ovf_uid193_Convert_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid193_Convert_a) - SIGNED(ovf_uid193_Convert_b));
    ovf_uid193_Convert_n(0) <= not ovf_uid193_Convert_o(12);


	--inIsZero_uid183_Convert(LOGICAL,182)@2
    inIsZero_uid183_Convert_a <= vCountFinal_uid734_lzcShifterZ1_uid181_Convert_q;
    inIsZero_uid183_Convert_b <= maxCount_uid182_Convert_q;
    inIsZero_uid183_Convert_q_i <= "1" when inIsZero_uid183_Convert_a = inIsZero_uid183_Convert_b else "0";
    inIsZero_uid183_Convert_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => inIsZero_uid183_Convert_q, xin => inIsZero_uid183_Convert_q_i, clk => clk, aclr => areset);

	--ovf_uid191_Convert(COMPARE,190)@3
    ovf_uid191_Convert_cin <= GND_q;
    ovf_uid191_Convert_a <= STD_LOGIC_VECTOR('0' & "0000000000" & GND_q) & '0';
    ovf_uid191_Convert_b <= STD_LOGIC_VECTOR((11 downto 10 => reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q(9)) & reg_expR_uid190_Convert_0_to_ovf_uid191_Convert_1_q) & ovf_uid191_Convert_cin(0);
            ovf_uid191_Convert_o <= STD_LOGIC_VECTOR(SIGNED(ovf_uid191_Convert_a) - SIGNED(ovf_uid191_Convert_b));
    ovf_uid191_Convert_n(0) <= not ovf_uid191_Convert_o(12);


	--udfOrInZero_uid197_Convert(LOGICAL,196)@3
    udfOrInZero_uid197_Convert_a <= ovf_uid191_Convert_n;
    udfOrInZero_uid197_Convert_b <= inIsZero_uid183_Convert_q;
    udfOrInZero_uid197_Convert_q <= udfOrInZero_uid197_Convert_a or udfOrInZero_uid197_Convert_b;

	--excSelector_uid198_Convert(BITJOIN,197)@3
    excSelector_uid198_Convert_q <= ovf_uid193_Convert_n & udfOrInZero_uid197_Convert_q;

	--expRPostExc_uid203_Convert(MUX,202)@3
    expRPostExc_uid203_Convert_s <= excSelector_uid198_Convert_q;
    expRPostExc_uid203_Convert: PROCESS (expRPostExc_uid203_Convert_s, reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2_q, zeroExponent_uid99_Acc_q, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid203_Convert_s IS
                  WHEN "00" => expRPostExc_uid203_Convert_q <= reg_expR_uid202_Convert_0_to_expRPostExc_uid203_Convert_2_q;
                  WHEN "01" => expRPostExc_uid203_Convert_q <= zeroExponent_uid99_Acc_q;
                  WHEN "10" => expRPostExc_uid203_Convert_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid203_Convert_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid203_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid189_Convert(BITSELECT,188)@2
    fracR_uid189_Convert_in <= expFracR_uid188_Convert_q(23 downto 0);
    fracR_uid189_Convert_b <= fracR_uid189_Convert_in(23 downto 1);

	--reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2(REG,1087)@2
    reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2_q <= fracR_uid189_Convert_b;
        END IF;
    END PROCESS;


	--excSelector_uid194_Convert(LOGICAL,193)@3
    excSelector_uid194_Convert_a <= inIsZero_uid183_Convert_q;
    excSelector_uid194_Convert_b <= ovf_uid193_Convert_n;
    excSelector_uid194_Convert_q <= excSelector_uid194_Convert_a or excSelector_uid194_Convert_b;

	--fracRPostExc_uid196_Convert(MUX,195)@3
    fracRPostExc_uid196_Convert_s <= excSelector_uid194_Convert_q;
    fracRPostExc_uid196_Convert: PROCESS (fracRPostExc_uid196_Convert_s, reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2_q, fracZ_uid195_Convert_q)
    BEGIN
            CASE fracRPostExc_uid196_Convert_s IS
                  WHEN "0" => fracRPostExc_uid196_Convert_q <= reg_fracR_uid189_Convert_0_to_fracRPostExc_uid196_Convert_2_q;
                  WHEN "1" => fracRPostExc_uid196_Convert_q <= fracZ_uid195_Convert_q;
                  WHEN OTHERS => fracRPostExc_uid196_Convert_q <= (others => '0');
            END CASE;
    END PROCESS;


	--outRes_uid204_Convert(BITJOIN,203)@3
    outRes_uid204_Convert_q <= ld_signX_uid177_Convert_b_to_outRes_uid204_Convert_c_q & expRPostExc_uid203_Convert_q & fracRPostExc_uid196_Convert_q;

	--Sub_R_sub_f_0_cast(FLOATCAST,60)@3
    Sub_R_sub_f_0_cast_reset <= areset;
    Sub_R_sub_f_0_cast_a <= outRes_uid204_Convert_q;
    Sub_R_sub_f_0_cast_inst : cast_sIEEE_2_sInternal
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Sub_R_sub_f_0_cast_reset,
    		dataa	 => Sub_R_sub_f_0_cast_a,
    		result	 => Sub_R_sub_f_0_cast_q
    	);
    -- synopsys translate off
    Sub_R_sub_f_0_cast_q_real <= sInternal_2_real(Sub_R_sub_f_0_cast_q);
    -- synopsys translate on

	--Sub_R_sub_f(FLOATADDSUB,48)@5
    Sub_R_sub_f_reset <= areset;
    Sub_R_sub_f_add_sub	 <= not GND_q;
    Sub_R_sub_f_inst : fp_addsub_sInternal_2_sInternal
    GENERIC MAP (
       addsub_resetval => '1'
    )
    PORT MAP (
    	add_sub	 => Sub_R_sub_f_add_sub,
    	clk_en	 => '1',
    	clock	 => clk,
    	reset    => Sub_R_sub_f_reset,
    	dataa	 => Sub_R_sub_f_0_cast_q,
    	datab	 => Sub_R_sub_f_1_cast_q,
    	result	 => Sub_R_sub_f_q
   	);
    Sub_R_sub_f_p <= not Sub_R_sub_f_q(41 downto 41);
    Sub_R_sub_f_n <= Sub_R_sub_f_q(41 downto 41);
    -- synopsys translate off
    Sub_R_sub_f_a_real <= sInternal_2_real(Sub_R_sub_f_0_cast_q);
    Sub_R_sub_f_b_real <= sInternal_2_real(Sub_R_sub_f_1_cast_q);
    Sub_R_sub_f_q_real <= sInternal_2_real(Sub_R_sub_f_q);
    -- synopsys translate on

	--Mult_f_0_cast(FLOATCAST,53)@10
    Mult_f_0_cast_reset <= areset;
    Mult_f_0_cast_a <= Sub_R_sub_f_q;
    Mult_f_0_cast_inst : cast_sInternal_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult_f_0_cast_reset,
    		dataa	 => Mult_f_0_cast_a,
    		result	 => Mult_f_0_cast_q
    	);
    -- synopsys translate off
    Mult_f_0_cast_q_real <= sNorm_2_real(Mult_f_0_cast_q);
    -- synopsys translate on

	--Mult_f(FLOATMULT,40)@14
    Mult_f_reset <= areset;
    Mult_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult_f_reset,
    		dataa	 => Mult_f_0_cast_q,
    		datab	 => Mult_f_0_cast_q,
    		result	 => Mult_f_q
    	);
    -- synopsys translate off
    Mult_f_a_real <= sNorm_2_real(Mult_f_0_cast_q);
    Mult_f_b_real <= sNorm_2_real(Mult_f_0_cast_q);
    Mult_f_q_real <= sInternal_2_real(Mult_f_q);
    -- synopsys translate on

	--Add_add_f(FLOATADDSUB,39)@17
    Add_add_f_reset <= areset;
    Add_add_f_add_sub	 <= not VCC_q;
    Add_add_f_inst : fp_addsub_sInternal_2_sInternal
    GENERIC MAP (
       addsub_resetval => '0'
    )
    PORT MAP (
    	add_sub	 => Add_add_f_add_sub,
    	clk_en	 => '1',
    	clock	 => clk,
    	reset    => Add_add_f_reset,
    	dataa	 => Mult_f_q,
    	datab	 => Mult1_f_q,
    	result	 => Add_add_f_q
   	);
    Add_add_f_p <= not Add_add_f_q(41 downto 41);
    Add_add_f_n <= Add_add_f_q(41 downto 41);
    -- synopsys translate off
    Add_add_f_a_real <= sInternal_2_real(Mult_f_q);
    Add_add_f_b_real <= sInternal_2_real(Mult1_f_q);
    Add_add_f_q_real <= sInternal_2_real(Add_add_f_q);
    -- synopsys translate on

	--RecipSqRt_0_cast(FLOATCAST,52)@22
    RecipSqRt_0_cast_reset <= areset;
    RecipSqRt_0_cast_a <= Add_add_f_q;
    RecipSqRt_0_cast_inst : cast_sInternal_2_sIEEE
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => RecipSqRt_0_cast_reset,
    		dataa	 => RecipSqRt_0_cast_a,
    		result	 => RecipSqRt_0_cast_q
    	);
    -- synopsys translate off
    RecipSqRt_0_cast_q_real <= sIEEE_2_real(RecipSqRt_0_cast_q);
    -- synopsys translate on

	--exp_uid433_RecipSqRt(BITSELECT,432)@29
    exp_uid433_RecipSqRt_in <= RecipSqRt_0_cast_q(30 downto 0);
    exp_uid433_RecipSqRt_b <= exp_uid433_RecipSqRt_in(30 downto 23);

	--expRExt_uid460_RecipSqRt(BITSELECT,459)@29
    expRExt_uid460_RecipSqRt_in <= exp_uid433_RecipSqRt_b;
    expRExt_uid460_RecipSqRt_b <= expRExt_uid460_RecipSqRt_in(7 downto 1);

	--cst3BiasM1o2M1_uid427_RecipSqRt(CONSTANT,426)
    cst3BiasM1o2M1_uid427_RecipSqRt_q <= "10111101";

	--cst3BiasP1o2M1_uid428_RecipSqRt(CONSTANT,427)
    cst3BiasP1o2M1_uid428_RecipSqRt_q <= "10111110";

	--frac_uid437_RecipSqRt(BITSELECT,436)@29
    frac_uid437_RecipSqRt_in <= RecipSqRt_0_cast_q(22 downto 0);
    frac_uid437_RecipSqRt_b <= frac_uid437_RecipSqRt_in(22 downto 0);

	--fracXIsZero_uid438_RecipSqRt(LOGICAL,437)@29
    fracXIsZero_uid438_RecipSqRt_a <= frac_uid437_RecipSqRt_b;
    fracXIsZero_uid438_RecipSqRt_b <= fracZ_uid195_Convert_q;
    fracXIsZero_uid438_RecipSqRt_q <= "1" when fracXIsZero_uid438_RecipSqRt_a = fracXIsZero_uid438_RecipSqRt_b else "0";

	--evenOddExp_uid450_RecipSqRt(BITSELECT,449)@29
    evenOddExp_uid450_RecipSqRt_in <= exp_uid433_RecipSqRt_b(0 downto 0);
    evenOddExp_uid450_RecipSqRt_b <= evenOddExp_uid450_RecipSqRt_in(0 downto 0);

	--join_uid458_RecipSqRt(BITJOIN,457)@29
    join_uid458_RecipSqRt_q <= fracXIsZero_uid438_RecipSqRt_q & evenOddExp_uid450_RecipSqRt_b;

	--cstSel_uid459_RecipSqRt(MUX,458)@29
    cstSel_uid459_RecipSqRt_s <= join_uid458_RecipSqRt_q;
    cstSel_uid459_RecipSqRt: PROCESS (cstSel_uid459_RecipSqRt_s, cst3BiasP1o2M1_uid428_RecipSqRt_q, cst3BiasM1o2M1_uid427_RecipSqRt_q, cst3BiasP1o2M1_uid428_RecipSqRt_q, cst3BiasP1o2M1_uid428_RecipSqRt_q)
    BEGIN
            CASE cstSel_uid459_RecipSqRt_s IS
                  WHEN "00" => cstSel_uid459_RecipSqRt_q <= cst3BiasP1o2M1_uid428_RecipSqRt_q;
                  WHEN "01" => cstSel_uid459_RecipSqRt_q <= cst3BiasM1o2M1_uid427_RecipSqRt_q;
                  WHEN "10" => cstSel_uid459_RecipSqRt_q <= cst3BiasP1o2M1_uid428_RecipSqRt_q;
                  WHEN "11" => cstSel_uid459_RecipSqRt_q <= cst3BiasP1o2M1_uid428_RecipSqRt_q;
                  WHEN OTHERS => cstSel_uid459_RecipSqRt_q <= (others => '0');
            END CASE;
    END PROCESS;


	--expRExt_uid461_RecipSqRt(SUB,460)@29
    expRExt_uid461_RecipSqRt_a <= STD_LOGIC_VECTOR("0" & cstSel_uid459_RecipSqRt_q);
    expRExt_uid461_RecipSqRt_b <= STD_LOGIC_VECTOR("00" & expRExt_uid460_RecipSqRt_b);
            expRExt_uid461_RecipSqRt_o <= STD_LOGIC_VECTOR(UNSIGNED(expRExt_uid461_RecipSqRt_a) - UNSIGNED(expRExt_uid461_RecipSqRt_b));
    expRExt_uid461_RecipSqRt_q <= expRExt_uid461_RecipSqRt_o(8 downto 0);


	--expR_uid462_RecipSqRt(BITSELECT,461)@29
    expR_uid462_RecipSqRt_in <= expRExt_uid461_RecipSqRt_q(7 downto 0);
    expR_uid462_RecipSqRt_b <= expR_uid462_RecipSqRt_in(7 downto 0);

	--signX_uid448_RecipSqRt(BITSELECT,447)@29
    signX_uid448_RecipSqRt_in <= RecipSqRt_0_cast_q;
    signX_uid448_RecipSqRt_b <= signX_uid448_RecipSqRt_in(31 downto 31);

	--InvExc_N_uid442_RecipSqRt(LOGICAL,441)@29
    InvExc_N_uid442_RecipSqRt_a <= exc_N_uid441_RecipSqRt_q;
    InvExc_N_uid442_RecipSqRt_q <= not InvExc_N_uid442_RecipSqRt_a;

	--InvExc_I_uid443_RecipSqRt(LOGICAL,442)@29
    InvExc_I_uid443_RecipSqRt_a <= exc_I_uid439_RecipSqRt_q;
    InvExc_I_uid443_RecipSqRt_q <= not InvExc_I_uid443_RecipSqRt_a;

	--InvExpXIsZero_uid444_RecipSqRt(LOGICAL,443)@29
    InvExpXIsZero_uid444_RecipSqRt_a <= expXIsZero_uid434_RecipSqRt_q;
    InvExpXIsZero_uid444_RecipSqRt_q <= not InvExpXIsZero_uid444_RecipSqRt_a;

	--exc_R_uid445_RecipSqRt(LOGICAL,444)@29
    exc_R_uid445_RecipSqRt_a <= InvExpXIsZero_uid444_RecipSqRt_q;
    exc_R_uid445_RecipSqRt_b <= InvExc_I_uid443_RecipSqRt_q;
    exc_R_uid445_RecipSqRt_c <= InvExc_N_uid442_RecipSqRt_q;
    exc_R_uid445_RecipSqRt_q <= exc_R_uid445_RecipSqRt_a and exc_R_uid445_RecipSqRt_b and exc_R_uid445_RecipSqRt_c;

	--xRegNeg_uid464_RecipSqRt(LOGICAL,463)@29
    xRegNeg_uid464_RecipSqRt_a <= exc_R_uid445_RecipSqRt_q;
    xRegNeg_uid464_RecipSqRt_b <= signX_uid448_RecipSqRt_b;
    xRegNeg_uid464_RecipSqRt_q <= xRegNeg_uid464_RecipSqRt_a and xRegNeg_uid464_RecipSqRt_b;

	--InvFracXIsZero_uid440_RecipSqRt(LOGICAL,439)@29
    InvFracXIsZero_uid440_RecipSqRt_a <= fracXIsZero_uid438_RecipSqRt_q;
    InvFracXIsZero_uid440_RecipSqRt_q <= not InvFracXIsZero_uid440_RecipSqRt_a;

	--expXIsMax_uid436_RecipSqRt(LOGICAL,435)@29
    expXIsMax_uid436_RecipSqRt_a <= exp_uid433_RecipSqRt_b;
    expXIsMax_uid436_RecipSqRt_b <= expInf_uid192_Convert_q;
    expXIsMax_uid436_RecipSqRt_q <= "1" when expXIsMax_uid436_RecipSqRt_a = expXIsMax_uid436_RecipSqRt_b else "0";

	--exc_N_uid441_RecipSqRt(LOGICAL,440)@29
    exc_N_uid441_RecipSqRt_a <= expXIsMax_uid436_RecipSqRt_q;
    exc_N_uid441_RecipSqRt_b <= InvFracXIsZero_uid440_RecipSqRt_q;
    exc_N_uid441_RecipSqRt_q <= exc_N_uid441_RecipSqRt_a and exc_N_uid441_RecipSqRt_b;

	--xNOxRNeg_uid465_RecipSqRt(LOGICAL,464)@29
    xNOxRNeg_uid465_RecipSqRt_a <= exc_N_uid441_RecipSqRt_q;
    xNOxRNeg_uid465_RecipSqRt_b <= xRegNeg_uid464_RecipSqRt_q;
    xNOxRNeg_uid465_RecipSqRt_q <= xNOxRNeg_uid465_RecipSqRt_a or xNOxRNeg_uid465_RecipSqRt_b;

	--expXIsZero_uid434_RecipSqRt(LOGICAL,433)@29
    expXIsZero_uid434_RecipSqRt_a <= exp_uid433_RecipSqRt_b;
    expXIsZero_uid434_RecipSqRt_b <= zeroExponent_uid99_Acc_q;
    expXIsZero_uid434_RecipSqRt_q <= "1" when expXIsZero_uid434_RecipSqRt_a = expXIsZero_uid434_RecipSqRt_b else "0";

	--exc_I_uid439_RecipSqRt(LOGICAL,438)@29
    exc_I_uid439_RecipSqRt_a <= expXIsMax_uid436_RecipSqRt_q;
    exc_I_uid439_RecipSqRt_b <= fracXIsZero_uid438_RecipSqRt_q;
    exc_I_uid439_RecipSqRt_q <= exc_I_uid439_RecipSqRt_a and exc_I_uid439_RecipSqRt_b;

	--excRConc_uid466_RecipSqRt(BITJOIN,465)@29
    excRConc_uid466_RecipSqRt_q <= xNOxRNeg_uid465_RecipSqRt_q & expXIsZero_uid434_RecipSqRt_q & exc_I_uid439_RecipSqRt_q;

	--outMuxSelEnc_uid467_RecipSqRt(LOOKUP,466)@29
    outMuxSelEnc_uid467_RecipSqRt: PROCESS (excRConc_uid466_RecipSqRt_q)
    BEGIN
        -- Begin reserved scope level
            CASE excRConc_uid466_RecipSqRt_q IS
                WHEN "000" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "01";
                WHEN "001" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "00";
                WHEN "010" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "10";
                WHEN "011" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "00";
                WHEN "100" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "11";
                WHEN "101" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "00";
                WHEN "110" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "10";
                WHEN "111" =>  outMuxSelEnc_uid467_RecipSqRt_q <= "01";
                WHEN OTHERS =>
                    outMuxSelEnc_uid467_RecipSqRt_q <= (others => '-');
            END CASE;
        -- End reserved scope level
    END PROCESS;


	--expRPostExc_uid469_RecipSqRt(MUX,468)@29
    expRPostExc_uid469_RecipSqRt_s <= outMuxSelEnc_uid467_RecipSqRt_q;
    expRPostExc_uid469_RecipSqRt: PROCESS (expRPostExc_uid469_RecipSqRt_s, zeroExponent_uid99_Acc_q, expR_uid462_RecipSqRt_b, expInf_uid192_Convert_q, expInf_uid192_Convert_q)
    BEGIN
            CASE expRPostExc_uid469_RecipSqRt_s IS
                  WHEN "00" => expRPostExc_uid469_RecipSqRt_q <= zeroExponent_uid99_Acc_q;
                  WHEN "01" => expRPostExc_uid469_RecipSqRt_q <= expR_uid462_RecipSqRt_b;
                  WHEN "10" => expRPostExc_uid469_RecipSqRt_q <= expInf_uid192_Convert_q;
                  WHEN "11" => expRPostExc_uid469_RecipSqRt_q <= expInf_uid192_Convert_q;
                  WHEN OTHERS => expRPostExc_uid469_RecipSqRt_q <= (others => '0');
            END CASE;
    END PROCESS;


	--ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_inputreg(DELAY,2390)
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_inputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1 )
    PORT MAP ( xin => expRPostExc_uid469_RecipSqRt_q, xout => ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_inputreg_q, clk => clk, aclr => areset );

	--ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_wrreg(REG,2393)
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_wrreg_q <= "0000";
        ELSIF rising_edge(clk) THEN
            ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_wrreg_q <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt(COUNTER,2392)
    -- every=1, low=0, high=8, step=1, init=1
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i <= TO_UNSIGNED(1,4);
            ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i = 7 THEN
                  ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_eq <= '1';
                ELSE
                  ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_eq = '1') THEN
                    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i - 8;
                ELSE
                    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_i,4));


	--ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem(DUALMEM,2391)
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_ia <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_inputreg_q;
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_aa <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_wrreg_q;
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_ab <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_rdcnt_q;
    ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 4,
        numwords_a => 9,
        width_b => 8,
        widthad_b => 4,
        numwords_b => 9,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_iq,
        address_a => ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_aa,
        data_a => ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_ia
    );
        ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_q <= ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_iq(7 downto 0);

	--cstNaNWF_uid425_RecipSqRt(CONSTANT,424)
    cstNaNWF_uid425_RecipSqRt_q <= "00000000000000000000001";

	--yAddr_uid452_RecipSqRt(BITSELECT,451)@29
    yAddr_uid452_RecipSqRt_in <= frac_uid437_RecipSqRt_b;
    yAddr_uid452_RecipSqRt_b <= yAddr_uid452_RecipSqRt_in(22 downto 15);

	--yAddrPEvenOdd_uid453_RecipSqRt(BITJOIN,452)@29
    yAddrPEvenOdd_uid453_RecipSqRt_q <= evenOddExp_uid450_RecipSqRt_b & yAddr_uid452_RecipSqRt_b;

	--memoryC2_uid1058_invSqrtTabGen_lutmem(DUALMEM,1079)@29
    memoryC2_uid1058_invSqrtTabGen_lutmem_ia <= (others => '0');
    memoryC2_uid1058_invSqrtTabGen_lutmem_aa <= (others => '0');
    memoryC2_uid1058_invSqrtTabGen_lutmem_ab <= yAddrPEvenOdd_uid453_RecipSqRt_q;
    memoryC2_uid1058_invSqrtTabGen_lutmem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 9,
        numwords_a => 512,
        width_b => 12,
        widthad_b => 9,
        numwords_b => 512,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("Galaxy/dut/prim/Galaxy_dut_prim_memoryC2_uid1058_invSqrtTabGen_lutmem.hex"),
        init_file_layout         => "PORT_B",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => '0',
        aclr0 => memoryC2_uid1058_invSqrtTabGen_lutmem_reset0,
        clock0 => clk,
        address_b => memoryC2_uid1058_invSqrtTabGen_lutmem_ab,
        -- data_b => (others => '0'),
        q_b => memoryC2_uid1058_invSqrtTabGen_lutmem_iq,
        address_a => memoryC2_uid1058_invSqrtTabGen_lutmem_aa,
        data_a => memoryC2_uid1058_invSqrtTabGen_lutmem_ia
    );
    memoryC2_uid1058_invSqrtTabGen_lutmem_reset0 <= areset;
        memoryC2_uid1058_invSqrtTabGen_lutmem_q <= memoryC2_uid1058_invSqrtTabGen_lutmem_iq(11 downto 0);

	--reg_memoryC2_uid1058_invSqrtTabGen_lutmem_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_1(REG,1117)@31
    reg_memoryC2_uid1058_invSqrtTabGen_lutmem_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_memoryC2_uid1058_invSqrtTabGen_lutmem_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_1_q <= "000000000000";
        ELSIF rising_edge(clk) THEN
            reg_memoryC2_uid1058_invSqrtTabGen_lutmem_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_1_q <= memoryC2_uid1058_invSqrtTabGen_lutmem_q;
        END IF;
    END PROCESS;


	--ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_wrreg(REG,2388)
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_wrreg_q <= "0";
        ELSIF rising_edge(clk) THEN
            ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_wrreg_q <= ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt(COUNTER,2387)
    -- every=1, low=0, high=1, step=1, init=1
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_i <= TO_UNSIGNED(1,1);
        ELSIF (clk'EVENT AND clk = '1') THEN
                ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_i <= ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_i + 1;
        END IF;
    END PROCESS;
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_i,1));


	--ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem(DUALMEM,2386)
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_ia <= frac_uid437_RecipSqRt_b;
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_aa <= ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_wrreg_q;
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_ab <= ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_rdcnt_q;
    ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 23,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_iq,
        address_a => ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_aa,
        data_a => ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_ia
    );
        ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_q <= ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_iq(22 downto 0);

	--yPPolyEval_uid454_RecipSqRt(BITSELECT,453)@31
    yPPolyEval_uid454_RecipSqRt_in <= ld_frac_uid437_RecipSqRt_b_to_yPPolyEval_uid454_RecipSqRt_a_replace_mem_q(14 downto 0);
    yPPolyEval_uid454_RecipSqRt_b <= yPPolyEval_uid454_RecipSqRt_in(14 downto 0);

	--yT1_uid1059_invSqrtPolyEval(BITSELECT,1058)@31
    yT1_uid1059_invSqrtPolyEval_in <= yPPolyEval_uid454_RecipSqRt_b;
    yT1_uid1059_invSqrtPolyEval_b <= yT1_uid1059_invSqrtPolyEval_in(14 downto 3);

	--reg_yT1_uid1059_invSqrtPolyEval_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_0(REG,1116)@31
    reg_yT1_uid1059_invSqrtPolyEval_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_yT1_uid1059_invSqrtPolyEval_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_0_q <= "000000000000";
        ELSIF rising_edge(clk) THEN
            reg_yT1_uid1059_invSqrtPolyEval_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_0_q <= yT1_uid1059_invSqrtPolyEval_b;
        END IF;
    END PROCESS;


	--prodXY_uid1072_pT1_uid1060_invSqrtPolyEval(MULT,1071)@32
    prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_a <= '0' & reg_yT1_uid1059_invSqrtPolyEval_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_0_q;
    prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_b <= reg_memoryC2_uid1058_invSqrtTabGen_lutmem_0_to_prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_1_q;
    prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_reset <= areset;

    prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_component : lpm_mult
    GENERIC MAP (
    lpm_widtha => 13,
    lpm_widthb => 12,
    lpm_widthp => 25,
    lpm_widths => 1,
    lpm_type => "LPM_MULT",
    lpm_representation => "SIGNED",
    lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES,MAXIMIZE_SPEED=5",
    lpm_pipeline => 3
    )
    PORT MAP (
    dataa => prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_a,
    datab => prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_b,
    clken => VCC_q(0),
    aclr => prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_reset,
    clock => clk,
    result => prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_s1
    );
    prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_q <= prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_s1(23 downto 0);

	--prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval(BITSELECT,1072)@35
    prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_in <= prodXY_uid1072_pT1_uid1060_invSqrtPolyEval_q;
    prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_b <= prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_in(23 downto 11);

	--highBBits_uid1062_invSqrtPolyEval(BITSELECT,1061)@35
    highBBits_uid1062_invSqrtPolyEval_in <= prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_b;
    highBBits_uid1062_invSqrtPolyEval_b <= highBBits_uid1062_invSqrtPolyEval_in(12 downto 1);

	--ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_wrreg(REG,2404)
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_wrreg_q <= "00";
        ELSIF rising_edge(clk) THEN
            ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_wrreg_q <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt(COUNTER,2403)
    -- every=1, low=0, high=2, step=1, init=1
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i <= TO_UNSIGNED(1,2);
            ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i = 1 THEN
                  ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_eq <= '1';
                ELSE
                  ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_eq = '1') THEN
                    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i - 2;
                ELSE
                    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_i,2));


	--ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem(DUALMEM,2402)
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_ia <= yAddrPEvenOdd_uid453_RecipSqRt_q;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_aa <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_wrreg_q;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_ab <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_rdcnt_q;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 9,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 9,
        widthad_b => 2,
        numwords_b => 3,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_iq,
        address_a => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_aa,
        data_a => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_ia
    );
        ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_q <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_iq(8 downto 0);

	--ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_outputreg(DELAY,2401)
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_outputreg : dspba_delay
    GENERIC MAP ( width => 9, depth => 1 )
    PORT MAP ( xin => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_replace_mem_q, xout => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_outputreg_q, clk => clk, aclr => areset );

	--memoryC1_uid1057_invSqrtTabGen_lutmem(DUALMEM,1078)@33
    memoryC1_uid1057_invSqrtTabGen_lutmem_ia <= (others => '0');
    memoryC1_uid1057_invSqrtTabGen_lutmem_aa <= (others => '0');
    memoryC1_uid1057_invSqrtTabGen_lutmem_ab <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC1_uid1057_invSqrtTabGen_lutmem_a_outputreg_q;
    memoryC1_uid1057_invSqrtTabGen_lutmem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 21,
        widthad_a => 9,
        numwords_a => 512,
        width_b => 21,
        widthad_b => 9,
        numwords_b => 512,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("Galaxy/dut/prim/Galaxy_dut_prim_memoryC1_uid1057_invSqrtTabGen_lutmem.hex"),
        init_file_layout         => "PORT_B",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => '0',
        aclr0 => memoryC1_uid1057_invSqrtTabGen_lutmem_reset0,
        clock0 => clk,
        address_b => memoryC1_uid1057_invSqrtTabGen_lutmem_ab,
        -- data_b => (others => '0'),
        q_b => memoryC1_uid1057_invSqrtTabGen_lutmem_iq,
        address_a => memoryC1_uid1057_invSqrtTabGen_lutmem_aa,
        data_a => memoryC1_uid1057_invSqrtTabGen_lutmem_ia
    );
    memoryC1_uid1057_invSqrtTabGen_lutmem_reset0 <= areset;
        memoryC1_uid1057_invSqrtTabGen_lutmem_q <= memoryC1_uid1057_invSqrtTabGen_lutmem_iq(20 downto 0);

	--sumAHighB_uid1063_invSqrtPolyEval(ADD,1062)@35
    sumAHighB_uid1063_invSqrtPolyEval_a <= STD_LOGIC_VECTOR((21 downto 21 => memoryC1_uid1057_invSqrtTabGen_lutmem_q(20)) & memoryC1_uid1057_invSqrtTabGen_lutmem_q);
    sumAHighB_uid1063_invSqrtPolyEval_b <= STD_LOGIC_VECTOR((21 downto 12 => highBBits_uid1062_invSqrtPolyEval_b(11)) & highBBits_uid1062_invSqrtPolyEval_b);
            sumAHighB_uid1063_invSqrtPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(sumAHighB_uid1063_invSqrtPolyEval_a) + SIGNED(sumAHighB_uid1063_invSqrtPolyEval_b));
    sumAHighB_uid1063_invSqrtPolyEval_q <= sumAHighB_uid1063_invSqrtPolyEval_o(21 downto 0);


	--lowRangeB_uid1061_invSqrtPolyEval(BITSELECT,1060)@35
    lowRangeB_uid1061_invSqrtPolyEval_in <= prodXYTruncFR_uid1073_pT1_uid1060_invSqrtPolyEval_b(0 downto 0);
    lowRangeB_uid1061_invSqrtPolyEval_b <= lowRangeB_uid1061_invSqrtPolyEval_in(0 downto 0);

	--s1_uid1061_uid1064_invSqrtPolyEval(BITJOIN,1063)@35
    s1_uid1061_uid1064_invSqrtPolyEval_q <= sumAHighB_uid1063_invSqrtPolyEval_q & lowRangeB_uid1061_invSqrtPolyEval_b;

	--reg_s1_uid1061_uid1064_invSqrtPolyEval_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_1(REG,1119)@35
    reg_s1_uid1061_uid1064_invSqrtPolyEval_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_s1_uid1061_uid1064_invSqrtPolyEval_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_1_q <= "00000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_s1_uid1061_uid1064_invSqrtPolyEval_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_1_q <= s1_uid1061_uid1064_invSqrtPolyEval_q;
        END IF;
    END PROCESS;


	--reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0(REG,1118)@31
    reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q <= "000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q <= yPPolyEval_uid454_RecipSqRt_b;
        END IF;
    END PROCESS;


	--ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_wrreg(REG,2396)
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_wrreg_q <= "00";
        ELSIF rising_edge(clk) THEN
            ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_wrreg_q <= ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt(COUNTER,2395)
    -- every=1, low=0, high=3, step=1, init=1
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_i <= TO_UNSIGNED(1,2);
        ELSIF (clk'EVENT AND clk = '1') THEN
                ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_i <= ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_i + 1;
        END IF;
    END PROCESS;
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_i,2));


	--ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem(DUALMEM,2394)
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_ia <= reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q;
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_aa <= ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_wrreg_q;
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_ab <= ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_rdcnt_q;
    ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 15,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 15,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_iq,
        address_a => ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_aa,
        data_a => ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_ia
    );
        ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_q <= ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_iq(14 downto 0);

	--prodXY_uid1075_pT2_uid1066_invSqrtPolyEval(MULT,1074)@36
    prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a <= '0' & ld_reg_yPPolyEval_uid454_RecipSqRt_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_0_q_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a_replace_mem_q;
    prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_b <= reg_s1_uid1061_uid1064_invSqrtPolyEval_0_to_prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_1_q;
    prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_reset <= areset;

    prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_component : lpm_mult
    GENERIC MAP (
    lpm_widtha => 16,
    lpm_widthb => 23,
    lpm_widthp => 39,
    lpm_widths => 1,
    lpm_type => "LPM_MULT",
    lpm_representation => "SIGNED",
    lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES,MAXIMIZE_SPEED=5",
    lpm_pipeline => 3
    )
    PORT MAP (
    dataa => prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_a,
    datab => prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_b,
    clken => VCC_q(0),
    aclr => prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_reset,
    clock => clk,
    result => prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_s1
    );
    prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_q <= prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_s1(37 downto 0);

	--prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval(BITSELECT,1075)@39
    prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_in <= prodXY_uid1075_pT2_uid1066_invSqrtPolyEval_q;
    prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_b <= prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_in(37 downto 14);

	--highBBits_uid1068_invSqrtPolyEval(BITSELECT,1067)@39
    highBBits_uid1068_invSqrtPolyEval_in <= prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_b;
    highBBits_uid1068_invSqrtPolyEval_b <= highBBits_uid1068_invSqrtPolyEval_in(23 downto 2);

	--ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg(REG,2358)
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg_q <= "000";
        ELSIF rising_edge(clk) THEN
            ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg_q <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt(COUNTER,2357)
    -- every=1, low=0, high=6, step=1, init=1
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i <= TO_UNSIGNED(1,3);
            ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i = 5 THEN
                  ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_eq <= '1';
                ELSE
                  ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_eq = '1') THEN
                    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i - 6;
                ELSE
                    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_i,3));


	--ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem(DUALMEM,2398)
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_ia <= yAddrPEvenOdd_uid453_RecipSqRt_q;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_aa <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg_q;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_ab <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_q;
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 9,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 9,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_iq,
        address_a => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_aa,
        data_a => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_ia
    );
        ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_q <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_iq(8 downto 0);

	--ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_outputreg(DELAY,2397)
    ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_outputreg : dspba_delay
    GENERIC MAP ( width => 9, depth => 1 )
    PORT MAP ( xin => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_replace_mem_q, xout => ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_outputreg_q, clk => clk, aclr => areset );

	--memoryC0_uid1056_invSqrtTabGen_lutmem(DUALMEM,1077)@37
    memoryC0_uid1056_invSqrtTabGen_lutmem_ia <= (others => '0');
    memoryC0_uid1056_invSqrtTabGen_lutmem_aa <= (others => '0');
    memoryC0_uid1056_invSqrtTabGen_lutmem_ab <= ld_yAddrPEvenOdd_uid453_RecipSqRt_q_to_memoryC0_uid1056_invSqrtTabGen_lutmem_a_outputreg_q;
    memoryC0_uid1056_invSqrtTabGen_lutmem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 30,
        widthad_a => 9,
        numwords_a => 512,
        width_b => 30,
        widthad_b => 9,
        numwords_b => 512,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("Galaxy/dut/prim/Galaxy_dut_prim_memoryC0_uid1056_invSqrtTabGen_lutmem.hex"),
        init_file_layout         => "PORT_B",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => '0',
        aclr0 => memoryC0_uid1056_invSqrtTabGen_lutmem_reset0,
        clock0 => clk,
        address_b => memoryC0_uid1056_invSqrtTabGen_lutmem_ab,
        -- data_b => (others => '0'),
        q_b => memoryC0_uid1056_invSqrtTabGen_lutmem_iq,
        address_a => memoryC0_uid1056_invSqrtTabGen_lutmem_aa,
        data_a => memoryC0_uid1056_invSqrtTabGen_lutmem_ia
    );
    memoryC0_uid1056_invSqrtTabGen_lutmem_reset0 <= areset;
        memoryC0_uid1056_invSqrtTabGen_lutmem_q <= memoryC0_uid1056_invSqrtTabGen_lutmem_iq(29 downto 0);

	--sumAHighB_uid1069_invSqrtPolyEval(ADD,1068)@39
    sumAHighB_uid1069_invSqrtPolyEval_a <= STD_LOGIC_VECTOR((30 downto 30 => memoryC0_uid1056_invSqrtTabGen_lutmem_q(29)) & memoryC0_uid1056_invSqrtTabGen_lutmem_q);
    sumAHighB_uid1069_invSqrtPolyEval_b <= STD_LOGIC_VECTOR((30 downto 22 => highBBits_uid1068_invSqrtPolyEval_b(21)) & highBBits_uid1068_invSqrtPolyEval_b);
            sumAHighB_uid1069_invSqrtPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(sumAHighB_uid1069_invSqrtPolyEval_a) + SIGNED(sumAHighB_uid1069_invSqrtPolyEval_b));
    sumAHighB_uid1069_invSqrtPolyEval_q <= sumAHighB_uid1069_invSqrtPolyEval_o(30 downto 0);


	--lowRangeB_uid1067_invSqrtPolyEval(BITSELECT,1066)@39
    lowRangeB_uid1067_invSqrtPolyEval_in <= prodXYTruncFR_uid1076_pT2_uid1066_invSqrtPolyEval_b(1 downto 0);
    lowRangeB_uid1067_invSqrtPolyEval_b <= lowRangeB_uid1067_invSqrtPolyEval_in(1 downto 0);

	--s2_uid1067_uid1070_invSqrtPolyEval(BITJOIN,1069)@39
    s2_uid1067_uid1070_invSqrtPolyEval_q <= sumAHighB_uid1069_invSqrtPolyEval_q & lowRangeB_uid1067_invSqrtPolyEval_b;

	--fxpInvSqrtRes_uid456_RecipSqRt(BITSELECT,455)@39
    fxpInvSqrtRes_uid456_RecipSqRt_in <= s2_uid1067_uid1070_invSqrtPolyEval_q(29 downto 0);
    fxpInvSqrtRes_uid456_RecipSqRt_b <= fxpInvSqrtRes_uid456_RecipSqRt_in(29 downto 6);

	--fxpInverseResFrac_uid463_RecipSqRt(BITSELECT,462)@39
    fxpInverseResFrac_uid463_RecipSqRt_in <= fxpInvSqrtRes_uid456_RecipSqRt_b(22 downto 0);
    fxpInverseResFrac_uid463_RecipSqRt_b <= fxpInverseResFrac_uid463_RecipSqRt_in(22 downto 0);

	--ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_inputreg(DELAY,2389)
    ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_inputreg : dspba_delay
    GENERIC MAP ( width => 2, depth => 1 )
    PORT MAP ( xin => outMuxSelEnc_uid467_RecipSqRt_q, xout => ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_inputreg_q, clk => clk, aclr => areset );

	--ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b(DELAY,1599)@29
    ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b : dspba_delay
    GENERIC MAP ( width => 2, depth => 9 )
    PORT MAP ( xin => ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_inputreg_q, xout => ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_q, clk => clk, aclr => areset );

	--fracRPostExc_uid468_RecipSqRt(MUX,467)@39
    fracRPostExc_uid468_RecipSqRt_s <= ld_outMuxSelEnc_uid467_RecipSqRt_q_to_fracRPostExc_uid468_RecipSqRt_b_q;
    fracRPostExc_uid468_RecipSqRt: PROCESS (fracRPostExc_uid468_RecipSqRt_s, fracZ_uid195_Convert_q, fxpInverseResFrac_uid463_RecipSqRt_b, fracZ_uid195_Convert_q, cstNaNWF_uid425_RecipSqRt_q)
    BEGIN
            CASE fracRPostExc_uid468_RecipSqRt_s IS
                  WHEN "00" => fracRPostExc_uid468_RecipSqRt_q <= fracZ_uid195_Convert_q;
                  WHEN "01" => fracRPostExc_uid468_RecipSqRt_q <= fxpInverseResFrac_uid463_RecipSqRt_b;
                  WHEN "10" => fracRPostExc_uid468_RecipSqRt_q <= fracZ_uid195_Convert_q;
                  WHEN "11" => fracRPostExc_uid468_RecipSqRt_q <= cstNaNWF_uid425_RecipSqRt_q;
                  WHEN OTHERS => fracRPostExc_uid468_RecipSqRt_q <= (others => '0');
            END CASE;
    END PROCESS;


	--R_uid470_RecipSqRt(BITJOIN,469)@39
    R_uid470_RecipSqRt_q <= GND_q & ld_expRPostExc_uid469_RecipSqRt_q_to_R_uid470_RecipSqRt_b_replace_mem_q & fracRPostExc_uid468_RecipSqRt_q;

	--Mult3_f_0_cast(FLOATCAST,55)@39
    Mult3_f_0_cast_reset <= areset;
    Mult3_f_0_cast_a <= R_uid470_RecipSqRt_q;
    Mult3_f_0_cast_inst : cast_sIEEE_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult3_f_0_cast_reset,
    		dataa	 => Mult3_f_0_cast_a,
    		result	 => Mult3_f_0_cast_q
    	);
    -- synopsys translate off
    Mult3_f_0_cast_q_real <= sNorm_2_real(Mult3_f_0_cast_q);
    -- synopsys translate on

	--Mult3_f(FLOATMULT,43)@41
    Mult3_f_reset <= areset;
    Mult3_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult3_f_reset,
    		dataa	 => Mult3_f_0_cast_q,
    		datab	 => ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_q,
    		result	 => Mult3_f_q
    	);
    -- synopsys translate off
    Mult3_f_a_real <= sNorm_2_real(Mult3_f_0_cast_q);
    Mult3_f_b_real <= sNorm_2_real(ld_Mult3_f_1_cast_q_to_Mult3_f_b_replace_mem_q);
    Mult3_f_q_real <= sInternal_2_real(Mult3_f_q);
    -- synopsys translate on

	--Mult4_f_1_cast(FLOATCAST,57)@44
    Mult4_f_1_cast_reset <= areset;
    Mult4_f_1_cast_a <= Mult3_f_q;
    Mult4_f_1_cast_inst : cast_sInternal_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult4_f_1_cast_reset,
    		dataa	 => Mult4_f_1_cast_a,
    		result	 => Mult4_f_1_cast_q
    	);
    -- synopsys translate off
    Mult4_f_1_cast_q_real <= sNorm_2_real(Mult4_f_1_cast_q);
    -- synopsys translate on

	--ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem(DUALMEM,2356)
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_ia <= Mult3_f_0_cast_q;
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_aa <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_wrreg_q;
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_ab <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_rdcnt_q;
    ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 45,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 45,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_iq,
        address_a => ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_aa,
        data_a => ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_ia
    );
        ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_q <= ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_iq(44 downto 0);

	--Mult4_f(FLOATMULT,44)@48
    Mult4_f_reset <= areset;
    Mult4_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult4_f_reset,
    		dataa	 => ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_q,
    		datab	 => Mult4_f_1_cast_q,
    		result	 => Mult4_f_q
    	);
    -- synopsys translate off
    Mult4_f_a_real <= sNorm_2_real(ld_Mult3_f_0_cast_q_to_Mult4_f_a_replace_mem_q);
    Mult4_f_b_real <= sNorm_2_real(Mult4_f_1_cast_q);
    Mult4_f_q_real <= sInternal_2_real(Mult4_f_q);
    -- synopsys translate on

	--Mult5_f_1_cast(FLOATCAST,58)@51
    Mult5_f_1_cast_reset <= areset;
    Mult5_f_1_cast_a <= Mult4_f_q;
    Mult5_f_1_cast_inst : cast_sInternal_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult5_f_1_cast_reset,
    		dataa	 => Mult5_f_1_cast_a,
    		result	 => Mult5_f_1_cast_q
    	);
    -- synopsys translate off
    Mult5_f_1_cast_q_real <= sNorm_2_real(Mult5_f_1_cast_q);
    -- synopsys translate on

	--ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_wrreg(REG,2361)
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_wrreg_q <= "0000";
        ELSIF rising_edge(clk) THEN
            ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_wrreg_q <= ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt(COUNTER,2360)
    -- every=1, low=0, high=13, step=1, init=1
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i <= TO_UNSIGNED(1,4);
            ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i = 12 THEN
                  ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_eq <= '1';
                ELSE
                  ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_eq = '1') THEN
                    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i <= ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i - 13;
                ELSE
                    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i <= ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_i,4));


	--ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem(DUALMEM,2359)
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_ia <= Mult3_f_0_cast_q;
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_aa <= ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_wrreg_q;
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_ab <= ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_rdcnt_q;
    ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 45,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 45,
        widthad_b => 4,
        numwords_b => 14,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_iq,
        address_a => ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_aa,
        data_a => ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_ia
    );
        ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_q <= ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_iq(44 downto 0);

	--Mult5_f(FLOATMULT,45)@55
    Mult5_f_reset <= areset;
    Mult5_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult5_f_reset,
    		dataa	 => ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_q,
    		datab	 => Mult5_f_1_cast_q,
    		result	 => Mult5_f_q
    	);
    -- synopsys translate off
    Mult5_f_a_real <= sNorm_2_real(ld_Mult3_f_0_cast_q_to_Mult5_f_a_replace_mem_q);
    Mult5_f_b_real <= sNorm_2_real(Mult5_f_1_cast_q);
    Mult5_f_q_real <= sInternal_2_real(Mult5_f_q);
    -- synopsys translate on

	--Mult6_f_1_cast(FLOATCAST,59)@58
    Mult6_f_1_cast_reset <= areset;
    Mult6_f_1_cast_a <= Mult5_f_q;
    Mult6_f_1_cast_inst : cast_sInternal_2_sNorm
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult6_f_1_cast_reset,
    		dataa	 => Mult6_f_1_cast_a,
    		result	 => Mult6_f_1_cast_q
    	);
    -- synopsys translate off
    Mult6_f_1_cast_q_real <= sNorm_2_real(Mult6_f_1_cast_q);
    -- synopsys translate on

	--Mult7_f(FLOATMULT,47)@62
    Mult7_f_reset <= areset;
    Mult7_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult7_f_reset,
    		dataa	 => Mult6_f_1_cast_q,
    		datab	 => ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_q,
    		result	 => Mult7_f_q
    	);
    -- synopsys translate off
    Mult7_f_a_real <= sNorm_2_real(Mult6_f_1_cast_q);
    Mult7_f_b_real <= sNorm_2_real(ld_Mult1_f_0_cast_q_to_Mult7_f_b_replace_mem_q);
    Mult7_f_q_real <= sInternal_2_real(Mult7_f_q);
    -- synopsys translate on

	--Acc1_0_cast(FLOATCAST,51)@65
    Acc1_0_cast_reset <= areset;
    Acc1_0_cast_a <= Mult7_f_q;
    Acc1_0_cast_inst : cast_sInternal_2_sIEEE
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Acc1_0_cast_reset,
    		dataa	 => Acc1_0_cast_a,
    		result	 => Acc1_0_cast_q
    	);
    -- synopsys translate off
    Acc1_0_cast_q_real <= sIEEE_2_real(Acc1_0_cast_q);
    -- synopsys translate on

	--signX_uid123_Acc1(BITSELECT,122)@72
    signX_uid123_Acc1_in <= Acc1_0_cast_q;
    signX_uid123_Acc1_b <= signX_uid123_Acc1_in(31 downto 31);

	--ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b(DELAY,1284)@72
    ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => signX_uid123_Acc1_b, xout => ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b_q, clk => clk, aclr => areset );

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg(REG,2407)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg_q <= "000000";
        ELSIF rising_edge(clk) THEN
            ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt(COUNTER,2406)
    -- every=1, low=0, high=63, step=1, init=1
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_i <= TO_UNSIGNED(1,6);
        ELSIF (clk'EVENT AND clk = '1') THEN
                ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_i <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_i + 1;
        END IF;
    END PROCESS;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_i,6));


	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem(DUALMEM,2419)
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_ia <= start;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_aa <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_ab <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 1,
        widthad_a => 6,
        numwords_a => 64,
        width_b => 1,
        widthad_b => 6,
        numwords_b => 64,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_iq,
        address_a => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_aa,
        data_a => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_ia
    );
        ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_q <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_iq(0 downto 0);

	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor(LOGICAL,2426)
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_b <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_q <= not (ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_a or ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_b);

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_mem_top(CONSTANT,2408)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_mem_top_q <= "0111111";

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp(LOGICAL,2409)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_a <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_mem_top_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_b <= STD_LOGIC_VECTOR("0" & ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q);
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_q <= "1" when ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_a = ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_b else "0";

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg(REG,2410)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg_q <= "0";
        ELSIF rising_edge(clk) THEN
            ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmp_q;
        END IF;
    END PROCESS;


	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena(REG,2427)
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena_q <= "0";
        ELSIF rising_edge(clk) THEN
            IF (ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_nor_q = "1") THEN
                ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg_q;
            END IF;
        END IF;
    END PROCESS;


	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd(LOGICAL,2428)
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_a <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_sticky_ena_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_b <= VCC_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_q <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_a and ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_b;

	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux(MUX,2429)
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_s <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaAnd_q;
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux: PROCESS (ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_s, GND_q, ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_q)
    BEGIN
            CASE ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_s IS
                  WHEN "0" => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_q <= GND_q;
                  WHEN "1" => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_q <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_q;
                  WHEN OTHERS => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_q <= (others => '0');
            END CASE;
    END PROCESS;


	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l(DELAY,1239)@0
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l : dspba_delay
    GENERIC MAP ( width => 1, depth => 8 )
    PORT MAP ( xin => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_enaMux_q, xout => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_q, clk => clk, aclr => areset );

	--ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg(DELAY,2382)
    ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_q, xout => ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg_q, clk => clk, aclr => areset );

	--zeroOutCst_uid508_alignmentShifter_uid75_Acc(CONSTANT,507)
    zeroOutCst_uid508_alignmentShifter_uid75_Acc_q <= "00000000000000000000000000000000000000000000000000000000000000";

	--rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc(CONSTANT,503)
    rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q <= "000";

	--RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1(BITSELECT,611)@72
    RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1_in <= rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q;
    RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1_b <= RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1_in(61 downto 3);

	--rightShiftStage2Idx3_uid614_alignmentShifter_uid131_Acc1(BITJOIN,613)@72
    rightShiftStage2Idx3_uid614_alignmentShifter_uid131_Acc1_q <= rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q & RightShiftStage161dto3_uid612_alignmentShifter_uid131_Acc1_b;

	--RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1(BITSELECT,608)@72
    RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1_in <= rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q;
    RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1_b <= RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1_in(61 downto 2);

	--rightShiftStage2Idx2_uid611_alignmentShifter_uid131_Acc1(BITJOIN,610)@72
    rightShiftStage2Idx2_uid611_alignmentShifter_uid131_Acc1_q <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q & RightShiftStage161dto2_uid609_alignmentShifter_uid131_Acc1_b;

	--RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1(BITSELECT,605)@72
    RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1_in <= rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q;
    RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1_b <= RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1_in(61 downto 1);

	--rightShiftStage2Idx1_uid608_alignmentShifter_uid131_Acc1(BITJOIN,607)@72
    rightShiftStage2Idx1_uid608_alignmentShifter_uid131_Acc1_q <= GND_q & RightShiftStage161dto1_uid606_alignmentShifter_uid131_Acc1_b;

	--rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc(CONSTANT,492)
    rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q <= "000000000000";

	--RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1(BITSELECT,600)@72
    RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1_in <= rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q;
    RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1_b <= RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1_in(61 downto 12);

	--rightShiftStage1Idx3_uid603_alignmentShifter_uid131_Acc1(BITJOIN,602)@72
    rightShiftStage1Idx3_uid603_alignmentShifter_uid131_Acc1_q <= rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q & RightShiftStage061dto12_uid601_alignmentShifter_uid131_Acc1_b;

	--RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1(BITSELECT,597)@72
    RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1_in <= rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q;
    RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1_b <= RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1_in(61 downto 8);

	--rightShiftStage1Idx2_uid600_alignmentShifter_uid131_Acc1(BITJOIN,599)@72
    rightShiftStage1Idx2_uid600_alignmentShifter_uid131_Acc1_q <= zeroExponent_uid99_Acc_q & RightShiftStage061dto8_uid598_alignmentShifter_uid131_Acc1_b;

	--RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1(BITSELECT,594)@72
    RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1_in <= rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q;
    RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1_b <= RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1_in(61 downto 4);

	--rightShiftStage1Idx1_uid597_alignmentShifter_uid131_Acc1(BITJOIN,596)@72
    rightShiftStage1Idx1_uid597_alignmentShifter_uid131_Acc1_q <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q & RightShiftStage061dto4_uid595_alignmentShifter_uid131_Acc1_b;

	--rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc(CONSTANT,481)
    rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q <= "000000000000000000000000000000000000000000000000";

	--X61dto48_uid590_alignmentShifter_uid131_Acc1(BITSELECT,589)@72
    X61dto48_uid590_alignmentShifter_uid131_Acc1_in <= rightPaddedIn_uid132_Acc1_q;
    X61dto48_uid590_alignmentShifter_uid131_Acc1_b <= X61dto48_uid590_alignmentShifter_uid131_Acc1_in(61 downto 48);

	--rightShiftStage0Idx3_uid592_alignmentShifter_uid131_Acc1(BITJOIN,591)@72
    rightShiftStage0Idx3_uid592_alignmentShifter_uid131_Acc1_q <= rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q & X61dto48_uid590_alignmentShifter_uid131_Acc1_b;

	--X61dto32_uid587_alignmentShifter_uid131_Acc1(BITSELECT,586)@72
    X61dto32_uid587_alignmentShifter_uid131_Acc1_in <= rightPaddedIn_uid132_Acc1_q;
    X61dto32_uid587_alignmentShifter_uid131_Acc1_b <= X61dto32_uid587_alignmentShifter_uid131_Acc1_in(61 downto 32);

	--rightShiftStage0Idx2_uid589_alignmentShifter_uid131_Acc1(BITJOIN,588)@72
    rightShiftStage0Idx2_uid589_alignmentShifter_uid131_Acc1_q <= maxNegValueU_uid387_Convert7_q & X61dto32_uid587_alignmentShifter_uid131_Acc1_b;

	--X61dto16_uid584_alignmentShifter_uid131_Acc1(BITSELECT,583)@72
    X61dto16_uid584_alignmentShifter_uid131_Acc1_in <= rightPaddedIn_uid132_Acc1_q;
    X61dto16_uid584_alignmentShifter_uid131_Acc1_b <= X61dto16_uid584_alignmentShifter_uid131_Acc1_in(61 downto 16);

	--rightShiftStage0Idx1_uid586_alignmentShifter_uid131_Acc1(BITJOIN,585)@72
    rightShiftStage0Idx1_uid586_alignmentShifter_uid131_Acc1_q <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q & X61dto16_uid584_alignmentShifter_uid131_Acc1_b;

	--fracX_uid122_Acc1(BITSELECT,121)@72
    fracX_uid122_Acc1_in <= Acc1_0_cast_q(22 downto 0);
    fracX_uid122_Acc1_b <= fracX_uid122_Acc1_in(22 downto 0);

	--oFracX_uid124_uid124_Acc1(BITJOIN,123)@72
    oFracX_uid124_uid124_Acc1_q <= VCC_q & fracX_uid122_Acc1_b;

	--padConst_uid75_Acc(CONSTANT,74)
    padConst_uid75_Acc_q <= "00000000000000000000000000000000000000";

	--rightPaddedIn_uid132_Acc1(BITJOIN,131)@72
    rightPaddedIn_uid132_Acc1_q <= oFracX_uid124_uid124_Acc1_q & padConst_uid75_Acc_q;

	--expX_uid121_Acc1(BITSELECT,120)@72
    expX_uid121_Acc1_in <= Acc1_0_cast_q(30 downto 0);
    expX_uid121_Acc1_b <= expX_uid121_Acc1_in(30 downto 23);

	--rShiftConstant_uid73_Acc(CONSTANT,72)
    rShiftConstant_uid73_Acc_q <= "010001011";

	--rightShiftValue_uid130_Acc1(SUB,129)@72
    rightShiftValue_uid130_Acc1_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid73_Acc_q);
    rightShiftValue_uid130_Acc1_b <= STD_LOGIC_VECTOR("00" & expX_uid121_Acc1_b);
            rightShiftValue_uid130_Acc1_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid130_Acc1_a) - UNSIGNED(rightShiftValue_uid130_Acc1_b));
    rightShiftValue_uid130_Acc1_q <= rightShiftValue_uid130_Acc1_o(9 downto 0);


	--rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1(BITSELECT,592)@72
    rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1_in <= rightShiftValue_uid130_Acc1_q(5 downto 0);
    rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1_b <= rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1_in(5 downto 4);

	--rightShiftStage0_uid594_alignmentShifter_uid131_Acc1(MUX,593)@72
    rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_s <= rightShiftStageSel5Dto4_uid593_alignmentShifter_uid131_Acc1_b;
    rightShiftStage0_uid594_alignmentShifter_uid131_Acc1: PROCESS (rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_s, rightPaddedIn_uid132_Acc1_q, rightShiftStage0Idx1_uid586_alignmentShifter_uid131_Acc1_q, rightShiftStage0Idx2_uid589_alignmentShifter_uid131_Acc1_q, rightShiftStage0Idx3_uid592_alignmentShifter_uid131_Acc1_q)
    BEGIN
            CASE rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_s IS
                  WHEN "00" => rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q <= rightPaddedIn_uid132_Acc1_q;
                  WHEN "01" => rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q <= rightShiftStage0Idx1_uid586_alignmentShifter_uid131_Acc1_q;
                  WHEN "10" => rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q <= rightShiftStage0Idx2_uid589_alignmentShifter_uid131_Acc1_q;
                  WHEN "11" => rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q <= rightShiftStage0Idx3_uid592_alignmentShifter_uid131_Acc1_q;
                  WHEN OTHERS => rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1(BITSELECT,603)@72
    rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1_in <= rightShiftValue_uid130_Acc1_q(3 downto 0);
    rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1_b <= rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1_in(3 downto 2);

	--rightShiftStage1_uid605_alignmentShifter_uid131_Acc1(MUX,604)@72
    rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_s <= rightShiftStageSel3Dto2_uid604_alignmentShifter_uid131_Acc1_b;
    rightShiftStage1_uid605_alignmentShifter_uid131_Acc1: PROCESS (rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_s, rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q, rightShiftStage1Idx1_uid597_alignmentShifter_uid131_Acc1_q, rightShiftStage1Idx2_uid600_alignmentShifter_uid131_Acc1_q, rightShiftStage1Idx3_uid603_alignmentShifter_uid131_Acc1_q)
    BEGIN
            CASE rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_s IS
                  WHEN "00" => rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q <= rightShiftStage0_uid594_alignmentShifter_uid131_Acc1_q;
                  WHEN "01" => rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q <= rightShiftStage1Idx1_uid597_alignmentShifter_uid131_Acc1_q;
                  WHEN "10" => rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q <= rightShiftStage1Idx2_uid600_alignmentShifter_uid131_Acc1_q;
                  WHEN "11" => rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q <= rightShiftStage1Idx3_uid603_alignmentShifter_uid131_Acc1_q;
                  WHEN OTHERS => rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1(BITSELECT,614)@72
    rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1_in <= rightShiftValue_uid130_Acc1_q(1 downto 0);
    rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1_b <= rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1_in(1 downto 0);

	--rightShiftStage2_uid616_alignmentShifter_uid131_Acc1(MUX,615)@72
    rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_s <= rightShiftStageSel1Dto0_uid615_alignmentShifter_uid131_Acc1_b;
    rightShiftStage2_uid616_alignmentShifter_uid131_Acc1: PROCESS (rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_s, rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q, rightShiftStage2Idx1_uid608_alignmentShifter_uid131_Acc1_q, rightShiftStage2Idx2_uid611_alignmentShifter_uid131_Acc1_q, rightShiftStage2Idx3_uid614_alignmentShifter_uid131_Acc1_q)
    BEGIN
            CASE rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_s IS
                  WHEN "00" => rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q <= rightShiftStage1_uid605_alignmentShifter_uid131_Acc1_q;
                  WHEN "01" => rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q <= rightShiftStage2Idx1_uid608_alignmentShifter_uid131_Acc1_q;
                  WHEN "10" => rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q <= rightShiftStage2Idx2_uid611_alignmentShifter_uid131_Acc1_q;
                  WHEN "11" => rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q <= rightShiftStage2Idx3_uid614_alignmentShifter_uid131_Acc1_q;
                  WHEN OTHERS => rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--wIntCst_uid473_alignmentShifter_uid75_Acc(CONSTANT,472)
    wIntCst_uid473_alignmentShifter_uid75_Acc_q <= "111110";

	--shiftedOut_uid583_alignmentShifter_uid131_Acc1(COMPARE,582)@72
    shiftedOut_uid583_alignmentShifter_uid131_Acc1_cin <= GND_q;
    shiftedOut_uid583_alignmentShifter_uid131_Acc1_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid130_Acc1_q) & '0';
    shiftedOut_uid583_alignmentShifter_uid131_Acc1_b <= STD_LOGIC_VECTOR("000000" & wIntCst_uid473_alignmentShifter_uid75_Acc_q) & shiftedOut_uid583_alignmentShifter_uid131_Acc1_cin(0);
            shiftedOut_uid583_alignmentShifter_uid131_Acc1_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid583_alignmentShifter_uid131_Acc1_a) - UNSIGNED(shiftedOut_uid583_alignmentShifter_uid131_Acc1_b));
    shiftedOut_uid583_alignmentShifter_uid131_Acc1_n(0) <= not shiftedOut_uid583_alignmentShifter_uid131_Acc1_o(12);


	--r_uid618_alignmentShifter_uid131_Acc1(MUX,617)@72
    r_uid618_alignmentShifter_uid131_Acc1_s <= shiftedOut_uid583_alignmentShifter_uid131_Acc1_n;
    r_uid618_alignmentShifter_uid131_Acc1: PROCESS (r_uid618_alignmentShifter_uid131_Acc1_s, rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q, zeroOutCst_uid508_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE r_uid618_alignmentShifter_uid131_Acc1_s IS
                  WHEN "0" => r_uid618_alignmentShifter_uid131_Acc1_q <= rightShiftStage2_uid616_alignmentShifter_uid131_Acc1_q;
                  WHEN "1" => r_uid618_alignmentShifter_uid131_Acc1_q <= zeroOutCst_uid508_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => r_uid618_alignmentShifter_uid131_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--shiftedFracUpper_uid134_Acc1(BITSELECT,133)@72
    shiftedFracUpper_uid134_Acc1_in <= r_uid618_alignmentShifter_uid131_Acc1_q;
    shiftedFracUpper_uid134_Acc1_b <= shiftedFracUpper_uid134_Acc1_in(61 downto 24);

	--extendedAlignedShiftedFrac_uid135_Acc1(BITJOIN,134)@72
    extendedAlignedShiftedFrac_uid135_Acc1_q <= GND_q & shiftedFracUpper_uid134_Acc1_b;

	--reg_extendedAlignedShiftedFrac_uid135_Acc1_0_to_onesComplementExtendedFrac_uid136_Acc1_1(REG,1162)@72
    reg_extendedAlignedShiftedFrac_uid135_Acc1_0_to_onesComplementExtendedFrac_uid136_Acc1_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_extendedAlignedShiftedFrac_uid135_Acc1_0_to_onesComplementExtendedFrac_uid136_Acc1_1_q <= "000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_extendedAlignedShiftedFrac_uid135_Acc1_0_to_onesComplementExtendedFrac_uid136_Acc1_1_q <= extendedAlignedShiftedFrac_uid135_Acc1_q;
        END IF;
    END PROCESS;


	--onesComplementExtendedFrac_uid136_Acc1(LOGICAL,135)@73
    onesComplementExtendedFrac_uid136_Acc1_a <= reg_extendedAlignedShiftedFrac_uid135_Acc1_0_to_onesComplementExtendedFrac_uid136_Acc1_1_q;
    onesComplementExtendedFrac_uid136_Acc1_b <= STD_LOGIC_VECTOR((38 downto 1 => ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b_q(0)) & ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b_q);
    onesComplementExtendedFrac_uid136_Acc1_q <= onesComplementExtendedFrac_uid136_Acc1_a xor onesComplementExtendedFrac_uid136_Acc1_b;

	--accumulator_uid138_Acc1(ADD,137)@73
    accumulator_uid138_Acc1_cin <= ld_signX_uid123_Acc1_b_to_onesComplementExtendedFrac_uid136_Acc1_b_q;
    accumulator_uid138_Acc1_a <= STD_LOGIC_VECTOR((49 downto 48 => sum_uid140_Acc1_b(47)) & sum_uid140_Acc1_b) & '1';
    accumulator_uid138_Acc1_b <= STD_LOGIC_VECTOR((49 downto 39 => onesComplementExtendedFrac_uid136_Acc1_q(38)) & onesComplementExtendedFrac_uid136_Acc1_q) & accumulator_uid138_Acc1_cin(0);
    accumulator_uid138_Acc1_i <= accumulator_uid138_Acc1_b;
    accumulator_uid138_Acc1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid138_Acc1_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            IF (ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg_q = "1") THEN
                accumulator_uid138_Acc1_o <= accumulator_uid138_Acc1_i;
            ELSE
                accumulator_uid138_Acc1_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid138_Acc1_a) + SIGNED(accumulator_uid138_Acc1_b));
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid138_Acc1_c(0) <= accumulator_uid138_Acc1_o(50);
    accumulator_uid138_Acc1_q <= accumulator_uid138_Acc1_o(49 downto 1);


	--join_uid139_Acc1(BITJOIN,138)@74
    join_uid139_Acc1_q <= accumulator_uid138_Acc1_c & accumulator_uid138_Acc1_q;

	--sum_uid140_Acc1(BITSELECT,139)@74
    sum_uid140_Acc1_in <= join_uid139_Acc1_q(47 downto 0);
    sum_uid140_Acc1_b <= sum_uid140_Acc1_in(47 downto 0);

	--accumulatorSign_uid142_Acc1(BITSELECT,141)@74
    accumulatorSign_uid142_Acc1_in <= sum_uid140_Acc1_b(46 downto 0);
    accumulatorSign_uid142_Acc1_b <= accumulatorSign_uid142_Acc1_in(46 downto 46);

	--ld_accumulatorSign_uid142_Acc1_b_to_R_uid160_Acc1_c(DELAY,1310)@74
    ld_accumulatorSign_uid142_Acc1_b_to_R_uid160_Acc1_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => accumulatorSign_uid142_Acc1_b, xout => ld_accumulatorSign_uid142_Acc1_b_to_R_uid160_Acc1_c_q, clk => clk, aclr => areset );

	--accValidRange_uid146_Acc1(BITSELECT,145)@74
    accValidRange_uid146_Acc1_in <= sum_uid140_Acc1_b(46 downto 0);
    accValidRange_uid146_Acc1_b <= accValidRange_uid146_Acc1_in(46 downto 0);

	--accOnesComplement_uid147_Acc1(LOGICAL,146)@74
    accOnesComplement_uid147_Acc1_a <= accValidRange_uid146_Acc1_b;
    accOnesComplement_uid147_Acc1_b <= STD_LOGIC_VECTOR((46 downto 1 => accumulatorSign_uid142_Acc1_b(0)) & accumulatorSign_uid142_Acc1_b);
    accOnesComplement_uid147_Acc1_q <= accOnesComplement_uid147_Acc1_a xor accOnesComplement_uid147_Acc1_b;

	--accValuePositive_uid148_Acc1(ADD,147)@74
    accValuePositive_uid148_Acc1_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid147_Acc1_q);
    accValuePositive_uid148_Acc1_b <= STD_LOGIC_VECTOR("00000000000000000000000000000000000000000000000" & accumulatorSign_uid142_Acc1_b);
            accValuePositive_uid148_Acc1_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid148_Acc1_a) + UNSIGNED(accValuePositive_uid148_Acc1_b));
    accValuePositive_uid148_Acc1_q <= accValuePositive_uid148_Acc1_o(47 downto 0);


	--posAccWoLeadingZeroBit_uid149_Acc1(BITSELECT,148)@74
    posAccWoLeadingZeroBit_uid149_Acc1_in <= accValuePositive_uid148_Acc1_q(45 downto 0);
    posAccWoLeadingZeroBit_uid149_Acc1_b <= posAccWoLeadingZeroBit_uid149_Acc1_in(45 downto 0);

	--rVStage_uid621_zeroCounter_uid150_Acc1(BITSELECT,620)@74
    rVStage_uid621_zeroCounter_uid150_Acc1_in <= posAccWoLeadingZeroBit_uid149_Acc1_b;
    rVStage_uid621_zeroCounter_uid150_Acc1_b <= rVStage_uid621_zeroCounter_uid150_Acc1_in(45 downto 14);

	--vCount_uid622_zeroCounter_uid150_Acc1(LOGICAL,621)@74
    vCount_uid622_zeroCounter_uid150_Acc1_a <= rVStage_uid621_zeroCounter_uid150_Acc1_b;
    vCount_uid622_zeroCounter_uid150_Acc1_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid622_zeroCounter_uid150_Acc1_q <= "1" when vCount_uid622_zeroCounter_uid150_Acc1_a = vCount_uid622_zeroCounter_uid150_Acc1_b else "0";

	--reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5(REG,1171)@74
    reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q <= vCount_uid622_zeroCounter_uid150_Acc1_q;
        END IF;
    END PROCESS;


	--ld_reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q_to_r_uid655_zeroCounter_uid150_Acc1_f(DELAY,1793)@75
    ld_reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q_to_r_uid655_zeroCounter_uid150_Acc1_f : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q, xout => ld_reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q_to_r_uid655_zeroCounter_uid150_Acc1_f_q, clk => clk, aclr => areset );

	--vStage_uid624_zeroCounter_uid150_Acc1(BITSELECT,623)@74
    vStage_uid624_zeroCounter_uid150_Acc1_in <= posAccWoLeadingZeroBit_uid149_Acc1_b(13 downto 0);
    vStage_uid624_zeroCounter_uid150_Acc1_b <= vStage_uid624_zeroCounter_uid150_Acc1_in(13 downto 0);

	--mO_uid514_zeroCounter_uid94_Acc(CONSTANT,513)
    mO_uid514_zeroCounter_uid94_Acc_q <= "111111111111111111";

	--cStage_uid625_zeroCounter_uid150_Acc1(BITJOIN,624)@74
    cStage_uid625_zeroCounter_uid150_Acc1_q <= vStage_uid624_zeroCounter_uid150_Acc1_b & mO_uid514_zeroCounter_uid94_Acc_q;

	--vStagei_uid627_zeroCounter_uid150_Acc1(MUX,626)@74
    vStagei_uid627_zeroCounter_uid150_Acc1_s <= vCount_uid622_zeroCounter_uid150_Acc1_q;
    vStagei_uid627_zeroCounter_uid150_Acc1: PROCESS (vStagei_uid627_zeroCounter_uid150_Acc1_s, rVStage_uid621_zeroCounter_uid150_Acc1_b, cStage_uid625_zeroCounter_uid150_Acc1_q)
    BEGIN
            CASE vStagei_uid627_zeroCounter_uid150_Acc1_s IS
                  WHEN "0" => vStagei_uid627_zeroCounter_uid150_Acc1_q <= rVStage_uid621_zeroCounter_uid150_Acc1_b;
                  WHEN "1" => vStagei_uid627_zeroCounter_uid150_Acc1_q <= cStage_uid625_zeroCounter_uid150_Acc1_q;
                  WHEN OTHERS => vStagei_uid627_zeroCounter_uid150_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid629_zeroCounter_uid150_Acc1(BITSELECT,628)@74
    rVStage_uid629_zeroCounter_uid150_Acc1_in <= vStagei_uid627_zeroCounter_uid150_Acc1_q;
    rVStage_uid629_zeroCounter_uid150_Acc1_b <= rVStage_uid629_zeroCounter_uid150_Acc1_in(31 downto 16);

	--reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1(REG,1163)@74
    reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1_q <= "0000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1_q <= rVStage_uid629_zeroCounter_uid150_Acc1_b;
        END IF;
    END PROCESS;


	--vCount_uid630_zeroCounter_uid150_Acc1(LOGICAL,629)@75
    vCount_uid630_zeroCounter_uid150_Acc1_a <= reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1_q;
    vCount_uid630_zeroCounter_uid150_Acc1_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid630_zeroCounter_uid150_Acc1_q <= "1" when vCount_uid630_zeroCounter_uid150_Acc1_a = vCount_uid630_zeroCounter_uid150_Acc1_b else "0";

	--reg_vCount_uid630_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_4(REG,1170)@75
    reg_vCount_uid630_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid630_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_4_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid630_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_4_q <= vCount_uid630_zeroCounter_uid150_Acc1_q;
        END IF;
    END PROCESS;


	--vStage_uid631_zeroCounter_uid150_Acc1(BITSELECT,630)@74
    vStage_uid631_zeroCounter_uid150_Acc1_in <= vStagei_uid627_zeroCounter_uid150_Acc1_q(15 downto 0);
    vStage_uid631_zeroCounter_uid150_Acc1_b <= vStage_uid631_zeroCounter_uid150_Acc1_in(15 downto 0);

	--reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3(REG,1165)@74
    reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3_q <= "0000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3_q <= vStage_uid631_zeroCounter_uid150_Acc1_b;
        END IF;
    END PROCESS;


	--vStagei_uid633_zeroCounter_uid150_Acc1(MUX,632)@75
    vStagei_uid633_zeroCounter_uid150_Acc1_s <= vCount_uid630_zeroCounter_uid150_Acc1_q;
    vStagei_uid633_zeroCounter_uid150_Acc1: PROCESS (vStagei_uid633_zeroCounter_uid150_Acc1_s, reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1_q, reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3_q)
    BEGIN
            CASE vStagei_uid633_zeroCounter_uid150_Acc1_s IS
                  WHEN "0" => vStagei_uid633_zeroCounter_uid150_Acc1_q <= reg_rVStage_uid629_zeroCounter_uid150_Acc1_0_to_vCount_uid630_zeroCounter_uid150_Acc1_1_q;
                  WHEN "1" => vStagei_uid633_zeroCounter_uid150_Acc1_q <= reg_vStage_uid631_zeroCounter_uid150_Acc1_0_to_vStagei_uid633_zeroCounter_uid150_Acc1_3_q;
                  WHEN OTHERS => vStagei_uid633_zeroCounter_uid150_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid635_zeroCounter_uid150_Acc1(BITSELECT,634)@75
    rVStage_uid635_zeroCounter_uid150_Acc1_in <= vStagei_uid633_zeroCounter_uid150_Acc1_q;
    rVStage_uid635_zeroCounter_uid150_Acc1_b <= rVStage_uid635_zeroCounter_uid150_Acc1_in(15 downto 8);

	--vCount_uid636_zeroCounter_uid150_Acc1(LOGICAL,635)@75
    vCount_uid636_zeroCounter_uid150_Acc1_a <= rVStage_uid635_zeroCounter_uid150_Acc1_b;
    vCount_uid636_zeroCounter_uid150_Acc1_b <= zeroExponent_uid99_Acc_q;
    vCount_uid636_zeroCounter_uid150_Acc1_q <= "1" when vCount_uid636_zeroCounter_uid150_Acc1_a = vCount_uid636_zeroCounter_uid150_Acc1_b else "0";

	--reg_vCount_uid636_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_3(REG,1169)@75
    reg_vCount_uid636_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid636_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_3_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid636_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_3_q <= vCount_uid636_zeroCounter_uid150_Acc1_q;
        END IF;
    END PROCESS;


	--vStage_uid637_zeroCounter_uid150_Acc1(BITSELECT,636)@75
    vStage_uid637_zeroCounter_uid150_Acc1_in <= vStagei_uid633_zeroCounter_uid150_Acc1_q(7 downto 0);
    vStage_uid637_zeroCounter_uid150_Acc1_b <= vStage_uid637_zeroCounter_uid150_Acc1_in(7 downto 0);

	--vStagei_uid639_zeroCounter_uid150_Acc1(MUX,638)@75
    vStagei_uid639_zeroCounter_uid150_Acc1_s <= vCount_uid636_zeroCounter_uid150_Acc1_q;
    vStagei_uid639_zeroCounter_uid150_Acc1: PROCESS (vStagei_uid639_zeroCounter_uid150_Acc1_s, rVStage_uid635_zeroCounter_uid150_Acc1_b, vStage_uid637_zeroCounter_uid150_Acc1_b)
    BEGIN
            CASE vStagei_uid639_zeroCounter_uid150_Acc1_s IS
                  WHEN "0" => vStagei_uid639_zeroCounter_uid150_Acc1_q <= rVStage_uid635_zeroCounter_uid150_Acc1_b;
                  WHEN "1" => vStagei_uid639_zeroCounter_uid150_Acc1_q <= vStage_uid637_zeroCounter_uid150_Acc1_b;
                  WHEN OTHERS => vStagei_uid639_zeroCounter_uid150_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid641_zeroCounter_uid150_Acc1(BITSELECT,640)@75
    rVStage_uid641_zeroCounter_uid150_Acc1_in <= vStagei_uid639_zeroCounter_uid150_Acc1_q;
    rVStage_uid641_zeroCounter_uid150_Acc1_b <= rVStage_uid641_zeroCounter_uid150_Acc1_in(7 downto 4);

	--vCount_uid642_zeroCounter_uid150_Acc1(LOGICAL,641)@75
    vCount_uid642_zeroCounter_uid150_Acc1_a <= rVStage_uid641_zeroCounter_uid150_Acc1_b;
    vCount_uid642_zeroCounter_uid150_Acc1_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid642_zeroCounter_uid150_Acc1_q <= "1" when vCount_uid642_zeroCounter_uid150_Acc1_a = vCount_uid642_zeroCounter_uid150_Acc1_b else "0";

	--reg_vCount_uid642_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_2(REG,1168)@75
    reg_vCount_uid642_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid642_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_2_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid642_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_2_q <= vCount_uid642_zeroCounter_uid150_Acc1_q;
        END IF;
    END PROCESS;


	--vStage_uid643_zeroCounter_uid150_Acc1(BITSELECT,642)@75
    vStage_uid643_zeroCounter_uid150_Acc1_in <= vStagei_uid639_zeroCounter_uid150_Acc1_q(3 downto 0);
    vStage_uid643_zeroCounter_uid150_Acc1_b <= vStage_uid643_zeroCounter_uid150_Acc1_in(3 downto 0);

	--vStagei_uid645_zeroCounter_uid150_Acc1(MUX,644)@75
    vStagei_uid645_zeroCounter_uid150_Acc1_s <= vCount_uid642_zeroCounter_uid150_Acc1_q;
    vStagei_uid645_zeroCounter_uid150_Acc1: PROCESS (vStagei_uid645_zeroCounter_uid150_Acc1_s, rVStage_uid641_zeroCounter_uid150_Acc1_b, vStage_uid643_zeroCounter_uid150_Acc1_b)
    BEGIN
            CASE vStagei_uid645_zeroCounter_uid150_Acc1_s IS
                  WHEN "0" => vStagei_uid645_zeroCounter_uid150_Acc1_q <= rVStage_uid641_zeroCounter_uid150_Acc1_b;
                  WHEN "1" => vStagei_uid645_zeroCounter_uid150_Acc1_q <= vStage_uid643_zeroCounter_uid150_Acc1_b;
                  WHEN OTHERS => vStagei_uid645_zeroCounter_uid150_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid647_zeroCounter_uid150_Acc1(BITSELECT,646)@75
    rVStage_uid647_zeroCounter_uid150_Acc1_in <= vStagei_uid645_zeroCounter_uid150_Acc1_q;
    rVStage_uid647_zeroCounter_uid150_Acc1_b <= rVStage_uid647_zeroCounter_uid150_Acc1_in(3 downto 2);

	--vCount_uid648_zeroCounter_uid150_Acc1(LOGICAL,647)@75
    vCount_uid648_zeroCounter_uid150_Acc1_a <= rVStage_uid647_zeroCounter_uid150_Acc1_b;
    vCount_uid648_zeroCounter_uid150_Acc1_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid648_zeroCounter_uid150_Acc1_q_i <= "1" when vCount_uid648_zeroCounter_uid150_Acc1_a = vCount_uid648_zeroCounter_uid150_Acc1_b else "0";
    vCount_uid648_zeroCounter_uid150_Acc1_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid648_zeroCounter_uid150_Acc1_q, xin => vCount_uid648_zeroCounter_uid150_Acc1_q_i, clk => clk, aclr => areset);

	--vStage_uid649_zeroCounter_uid150_Acc1(BITSELECT,648)@75
    vStage_uid649_zeroCounter_uid150_Acc1_in <= vStagei_uid645_zeroCounter_uid150_Acc1_q(1 downto 0);
    vStage_uid649_zeroCounter_uid150_Acc1_b <= vStage_uid649_zeroCounter_uid150_Acc1_in(1 downto 0);

	--reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3(REG,1167)@75
    reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3_q <= vStage_uid649_zeroCounter_uid150_Acc1_b;
        END IF;
    END PROCESS;


	--reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2(REG,1166)@75
    reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2_q <= rVStage_uid647_zeroCounter_uid150_Acc1_b;
        END IF;
    END PROCESS;


	--vStagei_uid651_zeroCounter_uid150_Acc1(MUX,650)@76
    vStagei_uid651_zeroCounter_uid150_Acc1_s <= vCount_uid648_zeroCounter_uid150_Acc1_q;
    vStagei_uid651_zeroCounter_uid150_Acc1: PROCESS (vStagei_uid651_zeroCounter_uid150_Acc1_s, reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2_q, reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3_q)
    BEGIN
            CASE vStagei_uid651_zeroCounter_uid150_Acc1_s IS
                  WHEN "0" => vStagei_uid651_zeroCounter_uid150_Acc1_q <= reg_rVStage_uid647_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_2_q;
                  WHEN "1" => vStagei_uid651_zeroCounter_uid150_Acc1_q <= reg_vStage_uid649_zeroCounter_uid150_Acc1_0_to_vStagei_uid651_zeroCounter_uid150_Acc1_3_q;
                  WHEN OTHERS => vStagei_uid651_zeroCounter_uid150_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid653_zeroCounter_uid150_Acc1(BITSELECT,652)@76
    rVStage_uid653_zeroCounter_uid150_Acc1_in <= vStagei_uid651_zeroCounter_uid150_Acc1_q;
    rVStage_uid653_zeroCounter_uid150_Acc1_b <= rVStage_uid653_zeroCounter_uid150_Acc1_in(1 downto 1);

	--vCount_uid654_zeroCounter_uid150_Acc1(LOGICAL,653)@76
    vCount_uid654_zeroCounter_uid150_Acc1_a <= rVStage_uid653_zeroCounter_uid150_Acc1_b;
    vCount_uid654_zeroCounter_uid150_Acc1_b <= GND_q;
    vCount_uid654_zeroCounter_uid150_Acc1_q <= "1" when vCount_uid654_zeroCounter_uid150_Acc1_a = vCount_uid654_zeroCounter_uid150_Acc1_b else "0";

	--r_uid655_zeroCounter_uid150_Acc1(BITJOIN,654)@76
    r_uid655_zeroCounter_uid150_Acc1_q <= ld_reg_vCount_uid622_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_5_q_to_r_uid655_zeroCounter_uid150_Acc1_f_q & reg_vCount_uid630_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_4_q & reg_vCount_uid636_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_3_q & reg_vCount_uid642_zeroCounter_uid150_Acc1_0_to_r_uid655_zeroCounter_uid150_Acc1_2_q & vCount_uid648_zeroCounter_uid150_Acc1_q & vCount_uid654_zeroCounter_uid150_Acc1_q;

	--expRBias_uid98_Acc(CONSTANT,97)
    expRBias_uid98_Acc_q <= "010010011";

	--resExpSub_uid156_Acc1(SUB,155)@76
    resExpSub_uid156_Acc1_a <= STD_LOGIC_VECTOR("0" & expRBias_uid98_Acc_q);
    resExpSub_uid156_Acc1_b <= STD_LOGIC_VECTOR("0000" & r_uid655_zeroCounter_uid150_Acc1_q);
            resExpSub_uid156_Acc1_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid156_Acc1_a) - UNSIGNED(resExpSub_uid156_Acc1_b));
    resExpSub_uid156_Acc1_q <= resExpSub_uid156_Acc1_o(9 downto 0);


	--finalExponent_uid157_Acc1(BITSELECT,156)@76
    finalExponent_uid157_Acc1_in <= resExpSub_uid156_Acc1_q(7 downto 0);
    finalExponent_uid157_Acc1_b <= finalExponent_uid157_Acc1_in(7 downto 0);

	--ShiftedOutComparator_uid95_Acc(CONSTANT,94)
    ShiftedOutComparator_uid95_Acc_q <= "101110";

	--accResOutOfExpRange_uid152_Acc1(LOGICAL,151)@76
    accResOutOfExpRange_uid152_Acc1_a <= ShiftedOutComparator_uid95_Acc_q;
    accResOutOfExpRange_uid152_Acc1_b <= r_uid655_zeroCounter_uid150_Acc1_q;
    accResOutOfExpRange_uid152_Acc1_q <= "1" when accResOutOfExpRange_uid152_Acc1_a = accResOutOfExpRange_uid152_Acc1_b else "0";

	--finalExpUpdated_uid158_Acc1(MUX,157)@76
    finalExpUpdated_uid158_Acc1_s <= accResOutOfExpRange_uid152_Acc1_q;
    finalExpUpdated_uid158_Acc1: PROCESS (finalExpUpdated_uid158_Acc1_s, finalExponent_uid157_Acc1_b, zeroExponent_uid99_Acc_q)
    BEGIN
            CASE finalExpUpdated_uid158_Acc1_s IS
                  WHEN "0" => finalExpUpdated_uid158_Acc1_q <= finalExponent_uid157_Acc1_b;
                  WHEN "1" => finalExpUpdated_uid158_Acc1_q <= zeroExponent_uid99_Acc_q;
                  WHEN OTHERS => finalExpUpdated_uid158_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1(BITSELECT,684)@76
    LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1_in <= leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q(44 downto 0);
    LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1_b <= LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1_in(44 downto 0);

	--leftShiftStage2Idx3_uid686_normalizationShifter_uid153_Acc1(BITJOIN,685)@76
    leftShiftStage2Idx3_uid686_normalizationShifter_uid153_Acc1_q <= LeftShiftStage144dto0_uid685_normalizationShifter_uid153_Acc1_b & rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q;

	--LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1(BITSELECT,681)@76
    LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1_in <= leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q(45 downto 0);
    LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1_b <= LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1_in(45 downto 0);

	--leftShiftStage2Idx2_uid683_normalizationShifter_uid153_Acc1(BITJOIN,682)@76
    leftShiftStage2Idx2_uid683_normalizationShifter_uid153_Acc1_q <= LeftShiftStage145dto0_uid682_normalizationShifter_uid153_Acc1_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1(BITSELECT,678)@76
    LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1_in <= leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q(46 downto 0);
    LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1_b <= LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1_in(46 downto 0);

	--leftShiftStage2Idx1_uid680_normalizationShifter_uid153_Acc1(BITJOIN,679)@76
    leftShiftStage2Idx1_uid680_normalizationShifter_uid153_Acc1_q <= LeftShiftStage146dto0_uid679_normalizationShifter_uid153_Acc1_b & GND_q;

	--LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1(BITSELECT,673)@76
    LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1_in <= leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q(35 downto 0);
    LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1_b <= LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1_in(35 downto 0);

	--leftShiftStage1Idx3_uid675_normalizationShifter_uid153_Acc1(BITJOIN,674)@76
    leftShiftStage1Idx3_uid675_normalizationShifter_uid153_Acc1_q <= LeftShiftStage035dto0_uid674_normalizationShifter_uid153_Acc1_b & rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q;

	--LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1(BITSELECT,670)@76
    LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1_in <= leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q(39 downto 0);
    LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1_b <= LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1_in(39 downto 0);

	--leftShiftStage1Idx2_uid672_normalizationShifter_uid153_Acc1(BITJOIN,671)@76
    leftShiftStage1Idx2_uid672_normalizationShifter_uid153_Acc1_q <= LeftShiftStage039dto0_uid671_normalizationShifter_uid153_Acc1_b & zeroExponent_uid99_Acc_q;

	--LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1(BITSELECT,667)@76
    LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1_in <= leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q(43 downto 0);
    LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1_b <= LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1_in(43 downto 0);

	--leftShiftStage1Idx1_uid669_normalizationShifter_uid153_Acc1(BITJOIN,668)@76
    leftShiftStage1Idx1_uid669_normalizationShifter_uid153_Acc1_q <= LeftShiftStage043dto0_uid668_normalizationShifter_uid153_Acc1_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--X15dto0_uid662_normalizationShifter_uid153_Acc1(BITSELECT,661)@74
    X15dto0_uid662_normalizationShifter_uid153_Acc1_in <= accValuePositive_uid148_Acc1_q(15 downto 0);
    X15dto0_uid662_normalizationShifter_uid153_Acc1_b <= X15dto0_uid662_normalizationShifter_uid153_Acc1_in(15 downto 0);

	--ld_X15dto0_uid662_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_b(DELAY,1797)@74
    ld_X15dto0_uid662_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_b : dspba_delay
    GENERIC MAP ( width => 16, depth => 1 )
    PORT MAP ( xin => X15dto0_uid662_normalizationShifter_uid153_Acc1_b, xout => ld_X15dto0_uid662_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_b_q, clk => clk, aclr => areset );

	--leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1(BITJOIN,662)@75
    leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_q <= ld_X15dto0_uid662_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_b_q & maxNegValueU_uid387_Convert7_q;

	--reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4(REG,1174)@75
    reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4_q <= "000000000000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4_q <= leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_q;
        END IF;
    END PROCESS;


	--X31dto0_uid659_normalizationShifter_uid153_Acc1(BITSELECT,658)@74
    X31dto0_uid659_normalizationShifter_uid153_Acc1_in <= accValuePositive_uid148_Acc1_q(31 downto 0);
    X31dto0_uid659_normalizationShifter_uid153_Acc1_b <= X31dto0_uid659_normalizationShifter_uid153_Acc1_in(31 downto 0);

	--ld_X31dto0_uid659_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_b(DELAY,1795)@74
    ld_X31dto0_uid659_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_b : dspba_delay
    GENERIC MAP ( width => 32, depth => 1 )
    PORT MAP ( xin => X31dto0_uid659_normalizationShifter_uid153_Acc1_b, xout => ld_X31dto0_uid659_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_b_q, clk => clk, aclr => areset );

	--leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1(BITJOIN,659)@75
    leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_q <= ld_X31dto0_uid659_normalizationShifter_uid153_Acc1_b_to_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_b_q & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3(REG,1173)@75
    reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3_q <= "000000000000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3_q <= leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_q;
        END IF;
    END PROCESS;


	--reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2(REG,1172)@74
    reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q <= "000000000000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q <= accValuePositive_uid148_Acc1_q;
        END IF;
    END PROCESS;


	--ld_reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_c(DELAY,1800)@75
    ld_reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_c : dspba_delay
    GENERIC MAP ( width => 48, depth => 1 )
    PORT MAP ( xin => reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q, xout => ld_reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_c_q, clk => clk, aclr => areset );

	--leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1(BITSELECT,664)@76
    leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1_in <= r_uid655_zeroCounter_uid150_Acc1_q;
    leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1_b <= leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1_in(5 downto 4);

	--leftShiftStage0_uid666_normalizationShifter_uid153_Acc1(MUX,665)@76
    leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_s <= leftShiftStageSel5Dto4_uid665_normalizationShifter_uid153_Acc1_b;
    leftShiftStage0_uid666_normalizationShifter_uid153_Acc1: PROCESS (leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_s, ld_reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_c_q, reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3_q, reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4_q, rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_s IS
                  WHEN "00" => leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q <= ld_reg_accValuePositive_uid148_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_2_q_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_c_q;
                  WHEN "01" => leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q <= reg_leftShiftStage0Idx1_uid660_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_3_q;
                  WHEN "10" => leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q <= reg_leftShiftStage0Idx2_uid663_normalizationShifter_uid153_Acc1_0_to_leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_4_q;
                  WHEN "11" => leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q <= rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1(BITSELECT,675)@76
    leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1_in <= r_uid655_zeroCounter_uid150_Acc1_q(3 downto 0);
    leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1_b <= leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1_in(3 downto 2);

	--leftShiftStage1_uid677_normalizationShifter_uid153_Acc1(MUX,676)@76
    leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_s <= leftShiftStageSel3Dto2_uid676_normalizationShifter_uid153_Acc1_b;
    leftShiftStage1_uid677_normalizationShifter_uid153_Acc1: PROCESS (leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_s, leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q, leftShiftStage1Idx1_uid669_normalizationShifter_uid153_Acc1_q, leftShiftStage1Idx2_uid672_normalizationShifter_uid153_Acc1_q, leftShiftStage1Idx3_uid675_normalizationShifter_uid153_Acc1_q)
    BEGIN
            CASE leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_s IS
                  WHEN "00" => leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q <= leftShiftStage0_uid666_normalizationShifter_uid153_Acc1_q;
                  WHEN "01" => leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q <= leftShiftStage1Idx1_uid669_normalizationShifter_uid153_Acc1_q;
                  WHEN "10" => leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q <= leftShiftStage1Idx2_uid672_normalizationShifter_uid153_Acc1_q;
                  WHEN "11" => leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q <= leftShiftStage1Idx3_uid675_normalizationShifter_uid153_Acc1_q;
                  WHEN OTHERS => leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1(BITSELECT,686)@76
    leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1_in <= r_uid655_zeroCounter_uid150_Acc1_q(1 downto 0);
    leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1_b <= leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1_in(1 downto 0);

	--leftShiftStage2_uid688_normalizationShifter_uid153_Acc1(MUX,687)@76
    leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_s <= leftShiftStageSel1Dto0_uid687_normalizationShifter_uid153_Acc1_b;
    leftShiftStage2_uid688_normalizationShifter_uid153_Acc1: PROCESS (leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_s, leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q, leftShiftStage2Idx1_uid680_normalizationShifter_uid153_Acc1_q, leftShiftStage2Idx2_uid683_normalizationShifter_uid153_Acc1_q, leftShiftStage2Idx3_uid686_normalizationShifter_uid153_Acc1_q)
    BEGIN
            CASE leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_s IS
                  WHEN "00" => leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q <= leftShiftStage1_uid677_normalizationShifter_uid153_Acc1_q;
                  WHEN "01" => leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q <= leftShiftStage2Idx1_uid680_normalizationShifter_uid153_Acc1_q;
                  WHEN "10" => leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q <= leftShiftStage2Idx2_uid683_normalizationShifter_uid153_Acc1_q;
                  WHEN "11" => leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q <= leftShiftStage2Idx3_uid686_normalizationShifter_uid153_Acc1_q;
                  WHEN OTHERS => leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid159_Acc1(BITSELECT,158)@76
    fracR_uid159_Acc1_in <= leftShiftStage2_uid688_normalizationShifter_uid153_Acc1_q(44 downto 0);
    fracR_uid159_Acc1_b <= fracR_uid159_Acc1_in(44 downto 22);

	--R_uid160_Acc1(BITJOIN,159)@76
    R_uid160_Acc1_q <= ld_accumulatorSign_uid142_Acc1_b_to_R_uid160_Acc1_c_q & finalExpUpdated_uid158_Acc1_q & fracR_uid159_Acc1_b;

	--signX_uid395_Convert8(BITSELECT,394)@76
    signX_uid395_Convert8_in <= R_uid160_Acc1_q;
    signX_uid395_Convert8_b <= signX_uid395_Convert8_in(31 downto 31);

	--reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2(REG,1181)@76
    reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2_q <= signX_uid395_Convert8_b;
        END IF;
    END PROCESS;


	--fracX_uid392_Convert8(BITSELECT,391)@76
    fracX_uid392_Convert8_in <= R_uid160_Acc1_q(22 downto 0);
    fracX_uid392_Convert8_b <= fracX_uid392_Convert8_in(22 downto 0);

	--oFracX_uid393_uid393_Convert8(BITJOIN,392)@76
    oFracX_uid393_uid393_Convert8_q <= VCC_q & fracX_uid392_Convert8_b;

	--zOFracX_uid403_Convert8(BITJOIN,402)@76
    zOFracX_uid403_Convert8_q <= GND_q & oFracX_uid393_uid393_Convert8_q;

	--shifterIn_uid405_Convert8(BITJOIN,404)@76
    shifterIn_uid405_Convert8_q <= zOFracX_uid403_Convert8_q & zeroExponent_uid99_Acc_q;

	--msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1013)@76
    msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_in <= shifterIn_uid405_Convert8_q;
    msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b <= msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 32);

	--rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1049)@76
    rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_a <= rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q;
    rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((2 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 3, depth => 1)
    PORT MAP (xout => rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1050)@77
    RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8_in <= rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q;
    RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8_b <= RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 3);

	--rightShiftStage2Idx3_uid1052_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1051)@77
    rightShiftStage2Idx3_uid1052_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage2Idx3Pad3_uid1050_rightShiferNoStickyOut_uid406_Convert8_q & RightShiftStage132dto3_uid1051_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1045)@76
    rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_a <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((1 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 2, depth => 1)
    PORT MAP (xout => rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1046)@77
    RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8_in <= rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q;
    RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8_b <= RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 2);

	--rightShiftStage2Idx2_uid1048_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1047)@77
    rightShiftStage2Idx2_uid1048_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage2Idx2Pad2_uid1046_rightShiferNoStickyOut_uid406_Convert8_q & RightShiftStage132dto2_uid1047_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1041)@76
    rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_a <= GND_q;
    rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_b <= msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1042)@77
    RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8_in <= rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q;
    RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8_b <= RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 1);

	--rightShiftStage2Idx1_uid1044_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1043)@77
    rightShiftStage2Idx1_uid1044_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage2Idx1Pad1_uid1042_rightShiferNoStickyOut_uid406_Convert8_q & RightShiftStage132dto1_uid1043_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1035)@76
    rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_a <= rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q;
    rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((11 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 12, depth => 1)
    PORT MAP (xout => rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1036)@77
    RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8_in <= rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q;
    RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8_b <= RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 12);

	--rightShiftStage1Idx3_uid1038_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1037)@77
    rightShiftStage1Idx3_uid1038_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1Idx3Pad12_uid1036_rightShiferNoStickyOut_uid406_Convert8_q & RightShiftStage032dto12_uid1037_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1031)@76
    rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_a <= zeroExponent_uid99_Acc_q;
    rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((7 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 8, depth => 1)
    PORT MAP (xout => rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1032)@77
    RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8_in <= rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q;
    RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8_b <= RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 8);

	--rightShiftStage1Idx2_uid1034_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1033)@77
    rightShiftStage1Idx2_uid1034_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1Idx2Pad8_uid1032_rightShiferNoStickyOut_uid406_Convert8_q & RightShiftStage032dto8_uid1033_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1027)@76
    rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_a <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((3 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 4, depth => 1)
    PORT MAP (xout => rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1028)@77
    RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8_in <= rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q;
    RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8_b <= RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 4);

	--rightShiftStage1Idx1_uid1030_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1029)@77
    rightShiftStage1Idx1_uid1030_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1Idx1Pad4_uid1028_rightShiferNoStickyOut_uid406_Convert8_q & RightShiftStage032dto4_uid1029_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage0Idx3_uid981_rightShiferNoStickyOut_uid373_Convert7(CONSTANT,980)
    rightShiftStage0Idx3_uid981_rightShiferNoStickyOut_uid373_Convert7_q <= "000000000000000000000000000000000";

	--rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1023)@76
    rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_a <= rightShiftStage0Idx3_uid981_rightShiferNoStickyOut_uid373_Convert7_q;
    rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((32 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q_i <= rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_b;
    rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_delay : dspba_delay
    GENERIC MAP (width => 33, depth => 1)
    PORT MAP (xout => rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q, xin => rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q_i, clk => clk, aclr => areset);

	--rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1019)@76
    rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_a <= maxNegValueU_uid387_Convert7_q;
    rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((31 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_b;

	--rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1021)@76
    rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage0Idx2Pad32_uid1020_rightShiferNoStickyOut_uid406_Convert8_q & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b;

	--reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4(REG,1178)@76
    reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4_q <= "000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4_q <= rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_q;
        END IF;
    END PROCESS;


	--rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8(LOGICAL,1015)@76
    rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_a <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_b <= STD_LOGIC_VECTOR((15 downto 1 => msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b(0)) & msbx_uid1014_rightShiferNoStickyOut_uid406_Convert8_b);
    rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_a or rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_b;

	--X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1016)@76
    X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8_in <= shifterIn_uid405_Convert8_q;
    X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8_b <= X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8_in(32 downto 16);

	--rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8(BITJOIN,1017)@76
    rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage0Idx1Pad16_uid1016_rightShiferNoStickyOut_uid406_Convert8_q & X32dto16_uid1017_rightShiferNoStickyOut_uid406_Convert8_b;

	--reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3(REG,1177)@76
    reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3_q <= "000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3_q <= rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_q;
        END IF;
    END PROCESS;


	--reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2(REG,1176)@76
    reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2_q <= "000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2_q <= shifterIn_uid405_Convert8_q;
        END IF;
    END PROCESS;


	--expX_uid394_Convert8(BITSELECT,393)@76
    expX_uid394_Convert8_in <= R_uid160_Acc1_q(30 downto 0);
    expX_uid394_Convert8_b <= expX_uid394_Convert8_in(30 downto 23);

	--ovfExpVal_uid367_Convert7(CONSTANT,366)
    ovfExpVal_uid367_Convert7_q <= "10001101";

	--shiftValE_uid401_Convert8(SUB,400)@76
    shiftValE_uid401_Convert8_a <= STD_LOGIC_VECTOR("0" & ovfExpVal_uid367_Convert7_q);
    shiftValE_uid401_Convert8_b <= STD_LOGIC_VECTOR("0" & expX_uid394_Convert8_b);
            shiftValE_uid401_Convert8_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftValE_uid401_Convert8_a) - UNSIGNED(shiftValE_uid401_Convert8_b));
    shiftValE_uid401_Convert8_q <= shiftValE_uid401_Convert8_o(8 downto 0);


	--shiftVal_uid402_Convert8(BITSELECT,401)@76
    shiftVal_uid402_Convert8_in <= shiftValE_uid401_Convert8_q(5 downto 0);
    shiftVal_uid402_Convert8_b <= shiftVal_uid402_Convert8_in(5 downto 0);

	--rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1024)@76
    rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_in <= shiftVal_uid402_Convert8_b;
    rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_b <= rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_in(5 downto 4);

	--reg_rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_1(REG,1175)@76
    reg_rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_1_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_1_q <= rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_b;
        END IF;
    END PROCESS;


	--rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8(MUX,1025)@77
    rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_s <= reg_rightShiftStageSel5Dto4_uid1025_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_1_q;
    rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8: PROCESS (rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_s, reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2_q, reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3_q, reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4_q, rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q)
    BEGIN
            CASE rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_s IS
                  WHEN "00" => rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q <= reg_shifterIn_uid405_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_2_q;
                  WHEN "01" => rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q <= reg_rightShiftStage0Idx1_uid1018_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_3_q;
                  WHEN "10" => rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q <= reg_rightShiftStage0Idx2_uid1022_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_4_q;
                  WHEN "11" => rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage0Idx3_uid1024_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN OTHERS => rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1038)@76
    rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_in <= shiftVal_uid402_Convert8_b(3 downto 0);
    rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_b <= rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_in(3 downto 2);

	--reg_rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_1(REG,1179)@76
    reg_rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_1_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_1_q <= rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_b;
        END IF;
    END PROCESS;


	--rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8(MUX,1039)@77
    rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_s <= reg_rightShiftStageSel3Dto2_uid1039_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_1_q;
    rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8: PROCESS (rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_s, rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q, rightShiftStage1Idx1_uid1030_rightShiferNoStickyOut_uid406_Convert8_q, rightShiftStage1Idx2_uid1034_rightShiferNoStickyOut_uid406_Convert8_q, rightShiftStage1Idx3_uid1038_rightShiferNoStickyOut_uid406_Convert8_q)
    BEGIN
            CASE rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_s IS
                  WHEN "00" => rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage0_uid1026_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN "01" => rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1Idx1_uid1030_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN "10" => rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1Idx2_uid1034_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN "11" => rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1Idx3_uid1038_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN OTHERS => rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8(BITSELECT,1052)@76
    rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_in <= shiftVal_uid402_Convert8_b(1 downto 0);
    rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_b <= rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_in(1 downto 0);

	--reg_rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_1(REG,1180)@76
    reg_rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_1_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_1_q <= rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_b;
        END IF;
    END PROCESS;


	--rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8(MUX,1053)@77
    rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_s <= reg_rightShiftStageSel1Dto0_uid1053_rightShiferNoStickyOut_uid406_Convert8_0_to_rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_1_q;
    rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8: PROCESS (rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_s, rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q, rightShiftStage2Idx1_uid1044_rightShiferNoStickyOut_uid406_Convert8_q, rightShiftStage2Idx2_uid1048_rightShiferNoStickyOut_uid406_Convert8_q, rightShiftStage2Idx3_uid1052_rightShiferNoStickyOut_uid406_Convert8_q)
    BEGIN
            CASE rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_s IS
                  WHEN "00" => rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage1_uid1040_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN "01" => rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage2Idx1_uid1044_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN "10" => rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage2Idx2_uid1048_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN "11" => rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q <= rightShiftStage2Idx3_uid1052_rightShiferNoStickyOut_uid406_Convert8_q;
                  WHEN OTHERS => rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q <= (others => '0');
            END CASE;
    END PROCESS;


	--zRightShiferNoStickyOut_uid407_Convert8(BITJOIN,406)@77
    zRightShiferNoStickyOut_uid407_Convert8_q <= GND_q & rightShiftStage2_uid1054_rightShiferNoStickyOut_uid406_Convert8_q;

	--xXorSign_uid408_Convert8(LOGICAL,407)@77
    xXorSign_uid408_Convert8_a <= zRightShiferNoStickyOut_uid407_Convert8_q;
    xXorSign_uid408_Convert8_b <= STD_LOGIC_VECTOR((33 downto 1 => reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2_q(0)) & reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2_q);
    xXorSign_uid408_Convert8_q <= xXorSign_uid408_Convert8_a xor xXorSign_uid408_Convert8_b;

	--sPostRndFull_uid410_Convert8(ADD,409)@77
    sPostRndFull_uid410_Convert8_a <= STD_LOGIC_VECTOR((34 downto 34 => xXorSign_uid408_Convert8_q(33)) & xXorSign_uid408_Convert8_q);
    sPostRndFull_uid410_Convert8_b <= STD_LOGIC_VECTOR((34 downto 3 => d0_uid376_Convert7_q(2)) & d0_uid376_Convert7_q);
            sPostRndFull_uid410_Convert8_o <= STD_LOGIC_VECTOR(SIGNED(sPostRndFull_uid410_Convert8_a) + SIGNED(sPostRndFull_uid410_Convert8_b));
    sPostRndFull_uid410_Convert8_q <= sPostRndFull_uid410_Convert8_o(34 downto 0);


	--sPostRnd_uid411_Convert8(BITSELECT,410)@77
    sPostRnd_uid411_Convert8_in <= sPostRndFull_uid410_Convert8_q(32 downto 0);
    sPostRnd_uid411_Convert8_b <= sPostRnd_uid411_Convert8_in(32 downto 1);

	--reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2(REG,1185)@77
    reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2_q <= sPostRnd_uid411_Convert8_b;
        END IF;
    END PROCESS;


	--ld_reg_signX_uid395_Convert8_0_to_muxSelConc_uid418_Convert8_2_q_to_muxSelConc_uid418_Convert8_c(DELAY,1556)@77
    ld_reg_signX_uid395_Convert8_0_to_muxSelConc_uid418_Convert8_2_q_to_muxSelConc_uid418_Convert8_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => reg_signX_uid395_Convert8_0_to_xXorSign_uid408_Convert8_2_q, xout => ld_reg_signX_uid395_Convert8_0_to_muxSelConc_uid418_Convert8_2_q_to_muxSelConc_uid418_Convert8_c_q, clk => clk, aclr => areset );

	--udfExpVal_uid365_Convert7(CONSTANT,364)
    udfExpVal_uid365_Convert7_q <= "01101101";

	--udf_uid399_Convert8(COMPARE,398)@76
    udf_uid399_Convert8_cin <= GND_q;
    udf_uid399_Convert8_a <= STD_LOGIC_VECTOR("00" & udfExpVal_uid365_Convert7_q) & '0';
    udf_uid399_Convert8_b <= STD_LOGIC_VECTOR("00" & expX_uid394_Convert8_b) & udf_uid399_Convert8_cin(0);
    udf_uid399_Convert8: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            udf_uid399_Convert8_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            udf_uid399_Convert8_o <= STD_LOGIC_VECTOR(UNSIGNED(udf_uid399_Convert8_a) - UNSIGNED(udf_uid399_Convert8_b));
        END IF;
    END PROCESS;
    udf_uid399_Convert8_n(0) <= not udf_uid399_Convert8_o(10);


	--ld_udf_uid399_Convert8_n_to_muxSelConc_uid418_Convert8_b(DELAY,1555)@77
    ld_udf_uid399_Convert8_n_to_muxSelConc_uid418_Convert8_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => udf_uid399_Convert8_n, xout => ld_udf_uid399_Convert8_n_to_muxSelConc_uid418_Convert8_b_q, clk => clk, aclr => areset );

	--sPostRndFullMSBU_uid412_Convert8(BITSELECT,411)@77
    sPostRndFullMSBU_uid412_Convert8_in <= sPostRndFull_uid410_Convert8_q(33 downto 0);
    sPostRndFullMSBU_uid412_Convert8_b <= sPostRndFullMSBU_uid412_Convert8_in(33 downto 33);

	--reg_sPostRndFullMSBU_uid412_Convert8_0_to_rndOvf_uid414_Convert8_2(REG,1183)@77
    reg_sPostRndFullMSBU_uid412_Convert8_0_to_rndOvf_uid414_Convert8_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_sPostRndFullMSBU_uid412_Convert8_0_to_rndOvf_uid414_Convert8_2_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_sPostRndFullMSBU_uid412_Convert8_0_to_rndOvf_uid414_Convert8_2_q <= sPostRndFullMSBU_uid412_Convert8_b;
        END IF;
    END PROCESS;


	--sPostRndFullMSBU_uid413_Convert8(BITSELECT,412)@77
    sPostRndFullMSBU_uid413_Convert8_in <= sPostRndFull_uid410_Convert8_q;
    sPostRndFullMSBU_uid413_Convert8_b <= sPostRndFullMSBU_uid413_Convert8_in(34 downto 34);

	--reg_sPostRndFullMSBU_uid413_Convert8_0_to_rndOvf_uid414_Convert8_1(REG,1182)@77
    reg_sPostRndFullMSBU_uid413_Convert8_0_to_rndOvf_uid414_Convert8_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_sPostRndFullMSBU_uid413_Convert8_0_to_rndOvf_uid414_Convert8_1_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_sPostRndFullMSBU_uid413_Convert8_0_to_rndOvf_uid414_Convert8_1_q <= sPostRndFullMSBU_uid413_Convert8_b;
        END IF;
    END PROCESS;


	--rndOvf_uid414_Convert8(LOGICAL,413)@78
    rndOvf_uid414_Convert8_a <= reg_sPostRndFullMSBU_uid413_Convert8_0_to_rndOvf_uid414_Convert8_1_q;
    rndOvf_uid414_Convert8_b <= reg_sPostRndFullMSBU_uid412_Convert8_0_to_rndOvf_uid414_Convert8_2_q;
    rndOvf_uid414_Convert8_q <= rndOvf_uid414_Convert8_a xor rndOvf_uid414_Convert8_b;

	--ovf_uid397_Convert8(COMPARE,396)@76
    ovf_uid397_Convert8_cin <= GND_q;
    ovf_uid397_Convert8_a <= STD_LOGIC_VECTOR("00" & expX_uid394_Convert8_b) & '0';
    ovf_uid397_Convert8_b <= STD_LOGIC_VECTOR("00" & msbIn_uid184_Convert_q) & ovf_uid397_Convert8_cin(0);
    ovf_uid397_Convert8: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ovf_uid397_Convert8_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            ovf_uid397_Convert8_o <= STD_LOGIC_VECTOR(UNSIGNED(ovf_uid397_Convert8_a) - UNSIGNED(ovf_uid397_Convert8_b));
        END IF;
    END PROCESS;
    ovf_uid397_Convert8_n(0) <= not ovf_uid397_Convert8_o(10);


	--ld_ovf_uid397_Convert8_n_to_ovfPostRnd_uid417_Convert8_a(DELAY,1552)@77
    ld_ovf_uid397_Convert8_n_to_ovfPostRnd_uid417_Convert8_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => ovf_uid397_Convert8_n, xout => ld_ovf_uid397_Convert8_n_to_ovfPostRnd_uid417_Convert8_a_q, clk => clk, aclr => areset );

	--ovfPostRnd_uid417_Convert8(LOGICAL,416)@78
    ovfPostRnd_uid417_Convert8_a <= ld_ovf_uid397_Convert8_n_to_ovfPostRnd_uid417_Convert8_a_q;
    ovfPostRnd_uid417_Convert8_b <= rndOvf_uid414_Convert8_q;
    ovfPostRnd_uid417_Convert8_q <= ovfPostRnd_uid417_Convert8_a or ovfPostRnd_uid417_Convert8_b;

	--muxSelConc_uid418_Convert8(BITJOIN,417)@78
    muxSelConc_uid418_Convert8_q <= ld_reg_signX_uid395_Convert8_0_to_muxSelConc_uid418_Convert8_2_q_to_muxSelConc_uid418_Convert8_c_q & ld_udf_uid399_Convert8_n_to_muxSelConc_uid418_Convert8_b_q & ovfPostRnd_uid417_Convert8_q;

	--muxSel_uid419_Convert8(LOOKUP,418)@78
    muxSel_uid419_Convert8: PROCESS (muxSelConc_uid418_Convert8_q)
    BEGIN
        -- Begin reserved scope level
            CASE muxSelConc_uid418_Convert8_q IS
                WHEN "000" =>  muxSel_uid419_Convert8_q <= "00";
                WHEN "001" =>  muxSel_uid419_Convert8_q <= "01";
                WHEN "010" =>  muxSel_uid419_Convert8_q <= "11";
                WHEN "011" =>  muxSel_uid419_Convert8_q <= "00";
                WHEN "100" =>  muxSel_uid419_Convert8_q <= "00";
                WHEN "101" =>  muxSel_uid419_Convert8_q <= "10";
                WHEN "110" =>  muxSel_uid419_Convert8_q <= "11";
                WHEN "111" =>  muxSel_uid419_Convert8_q <= "00";
                WHEN OTHERS =>
                    muxSel_uid419_Convert8_q <= (others => '-');
            END CASE;
        -- End reserved scope level
    END PROCESS;


	--VCC(CONSTANT,1)
    VCC_q <= "1";

	--finalOut_uid421_Convert8(MUX,420)@78
    finalOut_uid421_Convert8_s <= muxSel_uid419_Convert8_q;
    finalOut_uid421_Convert8: PROCESS (finalOut_uid421_Convert8_s, reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2_q, maxPosValueS_uid382_Convert7_q, maxNegValueS_uid383_Convert7_q, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE finalOut_uid421_Convert8_s IS
                  WHEN "00" => finalOut_uid421_Convert8_q <= reg_sPostRnd_uid411_Convert8_0_to_finalOut_uid421_Convert8_2_q;
                  WHEN "01" => finalOut_uid421_Convert8_q <= maxPosValueS_uid382_Convert7_q;
                  WHEN "10" => finalOut_uid421_Convert8_q <= maxNegValueS_uid383_Convert7_q;
                  WHEN "11" => finalOut_uid421_Convert8_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => finalOut_uid421_Convert8_q <= (others => '0');
            END CASE;
    END PROCESS;


	--ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem(DUALMEM,2362)
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_ia <= Mult_f_0_cast_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_aa <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_wrreg_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_ab <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_rdcnt_q;
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 45,
        widthad_a => 6,
        numwords_a => 47,
        width_b => 45,
        widthad_b => 6,
        numwords_b => 47,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken1 => ld_Mult_f_0_cast_q_to_Mult6_f_a_enaAnd_q(0),
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        aclr1 => ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_reset0,
        clock1 => clk,
        address_b => ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_iq,
        address_a => ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_aa,
        data_a => ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_ia
    );
    ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_reset0 <= areset;
        ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_q <= ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_iq(44 downto 0);

	--Mult6_f(FLOATMULT,46)@62
    Mult6_f_reset <= areset;
    Mult6_f_inst : fp_mult_sNorm_2_sInternal
        GENERIC MAP ( m_family => "Stratix IV")
        PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Mult6_f_reset,
    		dataa	 => ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_q,
    		datab	 => Mult6_f_1_cast_q,
    		result	 => Mult6_f_q
    	);
    -- synopsys translate off
    Mult6_f_a_real <= sNorm_2_real(ld_Mult_f_0_cast_q_to_Mult6_f_a_replace_mem_q);
    Mult6_f_b_real <= sNorm_2_real(Mult6_f_1_cast_q);
    Mult6_f_q_real <= sInternal_2_real(Mult6_f_q);
    -- synopsys translate on

	--Acc_0_cast(FLOATCAST,50)@65
    Acc_0_cast_reset <= areset;
    Acc_0_cast_a <= Mult6_f_q;
    Acc_0_cast_inst : cast_sInternal_2_sIEEE
      PORT MAP (
    		clk_en	 => '1',
    		clock	 => clk,
    		reset    => Acc_0_cast_reset,
    		dataa	 => Acc_0_cast_a,
    		result	 => Acc_0_cast_q
    	);
    -- synopsys translate off
    Acc_0_cast_q_real <= sIEEE_2_real(Acc_0_cast_q);
    -- synopsys translate on

	--signX_uid67_Acc(BITSELECT,66)@72
    signX_uid67_Acc_in <= Acc_0_cast_q;
    signX_uid67_Acc_b <= signX_uid67_Acc_in(31 downto 31);

	--ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b(DELAY,1237)@72
    ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => signX_uid67_Acc_b, xout => ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b_q, clk => clk, aclr => areset );

	--RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc(BITSELECT,502)@72
    RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc_in <= rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q;
    RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc_b <= RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc_in(61 downto 3);

	--rightShiftStage2Idx3_uid505_alignmentShifter_uid75_Acc(BITJOIN,504)@72
    rightShiftStage2Idx3_uid505_alignmentShifter_uid75_Acc_q <= rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q & RightShiftStage161dto3_uid503_alignmentShifter_uid75_Acc_b;

	--RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc(BITSELECT,499)@72
    RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc_in <= rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q;
    RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc_b <= RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc_in(61 downto 2);

	--rightShiftStage2Idx2_uid502_alignmentShifter_uid75_Acc(BITJOIN,501)@72
    rightShiftStage2Idx2_uid502_alignmentShifter_uid75_Acc_q <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q & RightShiftStage161dto2_uid500_alignmentShifter_uid75_Acc_b;

	--RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc(BITSELECT,496)@72
    RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc_in <= rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q;
    RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc_b <= RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc_in(61 downto 1);

	--rightShiftStage2Idx1_uid499_alignmentShifter_uid75_Acc(BITJOIN,498)@72
    rightShiftStage2Idx1_uid499_alignmentShifter_uid75_Acc_q <= GND_q & RightShiftStage161dto1_uid497_alignmentShifter_uid75_Acc_b;

	--RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc(BITSELECT,491)@72
    RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc_in <= rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q;
    RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc_b <= RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc_in(61 downto 12);

	--rightShiftStage1Idx3_uid494_alignmentShifter_uid75_Acc(BITJOIN,493)@72
    rightShiftStage1Idx3_uid494_alignmentShifter_uid75_Acc_q <= rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q & RightShiftStage061dto12_uid492_alignmentShifter_uid75_Acc_b;

	--RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc(BITSELECT,488)@72
    RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc_in <= rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q;
    RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc_b <= RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc_in(61 downto 8);

	--rightShiftStage1Idx2_uid491_alignmentShifter_uid75_Acc(BITJOIN,490)@72
    rightShiftStage1Idx2_uid491_alignmentShifter_uid75_Acc_q <= zeroExponent_uid99_Acc_q & RightShiftStage061dto8_uid489_alignmentShifter_uid75_Acc_b;

	--RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc(BITSELECT,485)@72
    RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc_in <= rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q;
    RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc_b <= RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc_in(61 downto 4);

	--rightShiftStage1Idx1_uid488_alignmentShifter_uid75_Acc(BITJOIN,487)@72
    rightShiftStage1Idx1_uid488_alignmentShifter_uid75_Acc_q <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q & RightShiftStage061dto4_uid486_alignmentShifter_uid75_Acc_b;

	--X61dto48_uid481_alignmentShifter_uid75_Acc(BITSELECT,480)@72
    X61dto48_uid481_alignmentShifter_uid75_Acc_in <= rightPaddedIn_uid76_Acc_q;
    X61dto48_uid481_alignmentShifter_uid75_Acc_b <= X61dto48_uid481_alignmentShifter_uid75_Acc_in(61 downto 48);

	--rightShiftStage0Idx3_uid483_alignmentShifter_uid75_Acc(BITJOIN,482)@72
    rightShiftStage0Idx3_uid483_alignmentShifter_uid75_Acc_q <= rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q & X61dto48_uid481_alignmentShifter_uid75_Acc_b;

	--X61dto32_uid478_alignmentShifter_uid75_Acc(BITSELECT,477)@72
    X61dto32_uid478_alignmentShifter_uid75_Acc_in <= rightPaddedIn_uid76_Acc_q;
    X61dto32_uid478_alignmentShifter_uid75_Acc_b <= X61dto32_uid478_alignmentShifter_uid75_Acc_in(61 downto 32);

	--rightShiftStage0Idx2_uid480_alignmentShifter_uid75_Acc(BITJOIN,479)@72
    rightShiftStage0Idx2_uid480_alignmentShifter_uid75_Acc_q <= maxNegValueU_uid387_Convert7_q & X61dto32_uid478_alignmentShifter_uid75_Acc_b;

	--X61dto16_uid475_alignmentShifter_uid75_Acc(BITSELECT,474)@72
    X61dto16_uid475_alignmentShifter_uid75_Acc_in <= rightPaddedIn_uid76_Acc_q;
    X61dto16_uid475_alignmentShifter_uid75_Acc_b <= X61dto16_uid475_alignmentShifter_uid75_Acc_in(61 downto 16);

	--rightShiftStage0Idx1_uid477_alignmentShifter_uid75_Acc(BITJOIN,476)@72
    rightShiftStage0Idx1_uid477_alignmentShifter_uid75_Acc_q <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q & X61dto16_uid475_alignmentShifter_uid75_Acc_b;

	--fracX_uid66_Acc(BITSELECT,65)@72
    fracX_uid66_Acc_in <= Acc_0_cast_q(22 downto 0);
    fracX_uid66_Acc_b <= fracX_uid66_Acc_in(22 downto 0);

	--oFracX_uid68_uid68_Acc(BITJOIN,67)@72
    oFracX_uid68_uid68_Acc_q <= VCC_q & fracX_uid66_Acc_b;

	--rightPaddedIn_uid76_Acc(BITJOIN,75)@72
    rightPaddedIn_uid76_Acc_q <= oFracX_uid68_uid68_Acc_q & padConst_uid75_Acc_q;

	--expX_uid65_Acc(BITSELECT,64)@72
    expX_uid65_Acc_in <= Acc_0_cast_q(30 downto 0);
    expX_uid65_Acc_b <= expX_uid65_Acc_in(30 downto 23);

	--rightShiftValue_uid74_Acc(SUB,73)@72
    rightShiftValue_uid74_Acc_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid73_Acc_q);
    rightShiftValue_uid74_Acc_b <= STD_LOGIC_VECTOR("00" & expX_uid65_Acc_b);
            rightShiftValue_uid74_Acc_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid74_Acc_a) - UNSIGNED(rightShiftValue_uid74_Acc_b));
    rightShiftValue_uid74_Acc_q <= rightShiftValue_uid74_Acc_o(9 downto 0);


	--rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc(BITSELECT,483)@72
    rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc_in <= rightShiftValue_uid74_Acc_q(5 downto 0);
    rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc_b <= rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc_in(5 downto 4);

	--rightShiftStage0_uid485_alignmentShifter_uid75_Acc(MUX,484)@72
    rightShiftStage0_uid485_alignmentShifter_uid75_Acc_s <= rightShiftStageSel5Dto4_uid484_alignmentShifter_uid75_Acc_b;
    rightShiftStage0_uid485_alignmentShifter_uid75_Acc: PROCESS (rightShiftStage0_uid485_alignmentShifter_uid75_Acc_s, rightPaddedIn_uid76_Acc_q, rightShiftStage0Idx1_uid477_alignmentShifter_uid75_Acc_q, rightShiftStage0Idx2_uid480_alignmentShifter_uid75_Acc_q, rightShiftStage0Idx3_uid483_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE rightShiftStage0_uid485_alignmentShifter_uid75_Acc_s IS
                  WHEN "00" => rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q <= rightPaddedIn_uid76_Acc_q;
                  WHEN "01" => rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q <= rightShiftStage0Idx1_uid477_alignmentShifter_uid75_Acc_q;
                  WHEN "10" => rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q <= rightShiftStage0Idx2_uid480_alignmentShifter_uid75_Acc_q;
                  WHEN "11" => rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q <= rightShiftStage0Idx3_uid483_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc(BITSELECT,494)@72
    rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc_in <= rightShiftValue_uid74_Acc_q(3 downto 0);
    rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc_b <= rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc_in(3 downto 2);

	--rightShiftStage1_uid496_alignmentShifter_uid75_Acc(MUX,495)@72
    rightShiftStage1_uid496_alignmentShifter_uid75_Acc_s <= rightShiftStageSel3Dto2_uid495_alignmentShifter_uid75_Acc_b;
    rightShiftStage1_uid496_alignmentShifter_uid75_Acc: PROCESS (rightShiftStage1_uid496_alignmentShifter_uid75_Acc_s, rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q, rightShiftStage1Idx1_uid488_alignmentShifter_uid75_Acc_q, rightShiftStage1Idx2_uid491_alignmentShifter_uid75_Acc_q, rightShiftStage1Idx3_uid494_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE rightShiftStage1_uid496_alignmentShifter_uid75_Acc_s IS
                  WHEN "00" => rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q <= rightShiftStage0_uid485_alignmentShifter_uid75_Acc_q;
                  WHEN "01" => rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q <= rightShiftStage1Idx1_uid488_alignmentShifter_uid75_Acc_q;
                  WHEN "10" => rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q <= rightShiftStage1Idx2_uid491_alignmentShifter_uid75_Acc_q;
                  WHEN "11" => rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q <= rightShiftStage1Idx3_uid494_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc(BITSELECT,505)@72
    rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc_in <= rightShiftValue_uid74_Acc_q(1 downto 0);
    rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc_b <= rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc_in(1 downto 0);

	--rightShiftStage2_uid507_alignmentShifter_uid75_Acc(MUX,506)@72
    rightShiftStage2_uid507_alignmentShifter_uid75_Acc_s <= rightShiftStageSel1Dto0_uid506_alignmentShifter_uid75_Acc_b;
    rightShiftStage2_uid507_alignmentShifter_uid75_Acc: PROCESS (rightShiftStage2_uid507_alignmentShifter_uid75_Acc_s, rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q, rightShiftStage2Idx1_uid499_alignmentShifter_uid75_Acc_q, rightShiftStage2Idx2_uid502_alignmentShifter_uid75_Acc_q, rightShiftStage2Idx3_uid505_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE rightShiftStage2_uid507_alignmentShifter_uid75_Acc_s IS
                  WHEN "00" => rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q <= rightShiftStage1_uid496_alignmentShifter_uid75_Acc_q;
                  WHEN "01" => rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q <= rightShiftStage2Idx1_uid499_alignmentShifter_uid75_Acc_q;
                  WHEN "10" => rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q <= rightShiftStage2Idx2_uid502_alignmentShifter_uid75_Acc_q;
                  WHEN "11" => rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q <= rightShiftStage2Idx3_uid505_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--shiftedOut_uid474_alignmentShifter_uid75_Acc(COMPARE,473)@72
    shiftedOut_uid474_alignmentShifter_uid75_Acc_cin <= GND_q;
    shiftedOut_uid474_alignmentShifter_uid75_Acc_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid74_Acc_q) & '0';
    shiftedOut_uid474_alignmentShifter_uid75_Acc_b <= STD_LOGIC_VECTOR("000000" & wIntCst_uid473_alignmentShifter_uid75_Acc_q) & shiftedOut_uid474_alignmentShifter_uid75_Acc_cin(0);
            shiftedOut_uid474_alignmentShifter_uid75_Acc_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid474_alignmentShifter_uid75_Acc_a) - UNSIGNED(shiftedOut_uid474_alignmentShifter_uid75_Acc_b));
    shiftedOut_uid474_alignmentShifter_uid75_Acc_n(0) <= not shiftedOut_uid474_alignmentShifter_uid75_Acc_o(12);


	--r_uid509_alignmentShifter_uid75_Acc(MUX,508)@72
    r_uid509_alignmentShifter_uid75_Acc_s <= shiftedOut_uid474_alignmentShifter_uid75_Acc_n;
    r_uid509_alignmentShifter_uid75_Acc: PROCESS (r_uid509_alignmentShifter_uid75_Acc_s, rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q, zeroOutCst_uid508_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE r_uid509_alignmentShifter_uid75_Acc_s IS
                  WHEN "0" => r_uid509_alignmentShifter_uid75_Acc_q <= rightShiftStage2_uid507_alignmentShifter_uid75_Acc_q;
                  WHEN "1" => r_uid509_alignmentShifter_uid75_Acc_q <= zeroOutCst_uid508_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => r_uid509_alignmentShifter_uid75_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--shiftedFracUpper_uid78_Acc(BITSELECT,77)@72
    shiftedFracUpper_uid78_Acc_in <= r_uid509_alignmentShifter_uid75_Acc_q;
    shiftedFracUpper_uid78_Acc_b <= shiftedFracUpper_uid78_Acc_in(61 downto 24);

	--extendedAlignedShiftedFrac_uid79_Acc(BITJOIN,78)@72
    extendedAlignedShiftedFrac_uid79_Acc_q <= GND_q & shiftedFracUpper_uid78_Acc_b;

	--reg_extendedAlignedShiftedFrac_uid79_Acc_0_to_onesComplementExtendedFrac_uid80_Acc_1(REG,1138)@72
    reg_extendedAlignedShiftedFrac_uid79_Acc_0_to_onesComplementExtendedFrac_uid80_Acc_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_extendedAlignedShiftedFrac_uid79_Acc_0_to_onesComplementExtendedFrac_uid80_Acc_1_q <= "000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_extendedAlignedShiftedFrac_uid79_Acc_0_to_onesComplementExtendedFrac_uid80_Acc_1_q <= extendedAlignedShiftedFrac_uid79_Acc_q;
        END IF;
    END PROCESS;


	--onesComplementExtendedFrac_uid80_Acc(LOGICAL,79)@73
    onesComplementExtendedFrac_uid80_Acc_a <= reg_extendedAlignedShiftedFrac_uid79_Acc_0_to_onesComplementExtendedFrac_uid80_Acc_1_q;
    onesComplementExtendedFrac_uid80_Acc_b <= STD_LOGIC_VECTOR((38 downto 1 => ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b_q(0)) & ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b_q);
    onesComplementExtendedFrac_uid80_Acc_q <= onesComplementExtendedFrac_uid80_Acc_a xor onesComplementExtendedFrac_uid80_Acc_b;

	--accumulator_uid82_Acc(ADD,81)@73
    accumulator_uid82_Acc_cin <= ld_signX_uid67_Acc_b_to_onesComplementExtendedFrac_uid80_Acc_b_q;
    accumulator_uid82_Acc_a <= STD_LOGIC_VECTOR((49 downto 48 => sum_uid84_Acc_b(47)) & sum_uid84_Acc_b) & '1';
    accumulator_uid82_Acc_b <= STD_LOGIC_VECTOR((49 downto 39 => onesComplementExtendedFrac_uid80_Acc_q(38)) & onesComplementExtendedFrac_uid80_Acc_q) & accumulator_uid82_Acc_cin(0);
    accumulator_uid82_Acc_i <= accumulator_uid82_Acc_b;
    accumulator_uid82_Acc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid82_Acc_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            IF (ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg_q = "1") THEN
                accumulator_uid82_Acc_o <= accumulator_uid82_Acc_i;
            ELSE
                accumulator_uid82_Acc_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid82_Acc_a) + SIGNED(accumulator_uid82_Acc_b));
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid82_Acc_c(0) <= accumulator_uid82_Acc_o(50);
    accumulator_uid82_Acc_q <= accumulator_uid82_Acc_o(49 downto 1);


	--join_uid83_Acc(BITJOIN,82)@74
    join_uid83_Acc_q <= accumulator_uid82_Acc_c & accumulator_uid82_Acc_q;

	--sum_uid84_Acc(BITSELECT,83)@74
    sum_uid84_Acc_in <= join_uid83_Acc_q(47 downto 0);
    sum_uid84_Acc_b <= sum_uid84_Acc_in(47 downto 0);

	--accumulatorSign_uid86_Acc(BITSELECT,85)@74
    accumulatorSign_uid86_Acc_in <= sum_uid84_Acc_b(46 downto 0);
    accumulatorSign_uid86_Acc_b <= accumulatorSign_uid86_Acc_in(46 downto 46);

	--ld_accumulatorSign_uid86_Acc_b_to_R_uid104_Acc_c(DELAY,1263)@74
    ld_accumulatorSign_uid86_Acc_b_to_R_uid104_Acc_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => accumulatorSign_uid86_Acc_b, xout => ld_accumulatorSign_uid86_Acc_b_to_R_uid104_Acc_c_q, clk => clk, aclr => areset );

	--accValidRange_uid90_Acc(BITSELECT,89)@74
    accValidRange_uid90_Acc_in <= sum_uid84_Acc_b(46 downto 0);
    accValidRange_uid90_Acc_b <= accValidRange_uid90_Acc_in(46 downto 0);

	--accOnesComplement_uid91_Acc(LOGICAL,90)@74
    accOnesComplement_uid91_Acc_a <= accValidRange_uid90_Acc_b;
    accOnesComplement_uid91_Acc_b <= STD_LOGIC_VECTOR((46 downto 1 => accumulatorSign_uid86_Acc_b(0)) & accumulatorSign_uid86_Acc_b);
    accOnesComplement_uid91_Acc_q <= accOnesComplement_uid91_Acc_a xor accOnesComplement_uid91_Acc_b;

	--accValuePositive_uid92_Acc(ADD,91)@74
    accValuePositive_uid92_Acc_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid91_Acc_q);
    accValuePositive_uid92_Acc_b <= STD_LOGIC_VECTOR("00000000000000000000000000000000000000000000000" & accumulatorSign_uid86_Acc_b);
            accValuePositive_uid92_Acc_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid92_Acc_a) + UNSIGNED(accValuePositive_uid92_Acc_b));
    accValuePositive_uid92_Acc_q <= accValuePositive_uid92_Acc_o(47 downto 0);


	--posAccWoLeadingZeroBit_uid93_Acc(BITSELECT,92)@74
    posAccWoLeadingZeroBit_uid93_Acc_in <= accValuePositive_uid92_Acc_q(45 downto 0);
    posAccWoLeadingZeroBit_uid93_Acc_b <= posAccWoLeadingZeroBit_uid93_Acc_in(45 downto 0);

	--rVStage_uid512_zeroCounter_uid94_Acc(BITSELECT,511)@74
    rVStage_uid512_zeroCounter_uid94_Acc_in <= posAccWoLeadingZeroBit_uid93_Acc_b;
    rVStage_uid512_zeroCounter_uid94_Acc_b <= rVStage_uid512_zeroCounter_uid94_Acc_in(45 downto 14);

	--vCount_uid513_zeroCounter_uid94_Acc(LOGICAL,512)@74
    vCount_uid513_zeroCounter_uid94_Acc_a <= rVStage_uid512_zeroCounter_uid94_Acc_b;
    vCount_uid513_zeroCounter_uid94_Acc_b <= maxNegValueU_uid387_Convert7_q;
    vCount_uid513_zeroCounter_uid94_Acc_q <= "1" when vCount_uid513_zeroCounter_uid94_Acc_a = vCount_uid513_zeroCounter_uid94_Acc_b else "0";

	--ld_vCount_uid513_zeroCounter_uid94_Acc_q_to_reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_a(DELAY,2300)@74
    ld_vCount_uid513_zeroCounter_uid94_Acc_q_to_reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => vCount_uid513_zeroCounter_uid94_Acc_q, xout => ld_vCount_uid513_zeroCounter_uid94_Acc_q_to_reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_a_q, clk => clk, aclr => areset );

	--reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5(REG,1147)@75
    reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_q <= ld_vCount_uid513_zeroCounter_uid94_Acc_q_to_reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_a_q;
        END IF;
    END PROCESS;


	--vStage_uid515_zeroCounter_uid94_Acc(BITSELECT,514)@74
    vStage_uid515_zeroCounter_uid94_Acc_in <= posAccWoLeadingZeroBit_uid93_Acc_b(13 downto 0);
    vStage_uid515_zeroCounter_uid94_Acc_b <= vStage_uid515_zeroCounter_uid94_Acc_in(13 downto 0);

	--cStage_uid516_zeroCounter_uid94_Acc(BITJOIN,515)@74
    cStage_uid516_zeroCounter_uid94_Acc_q <= vStage_uid515_zeroCounter_uid94_Acc_b & mO_uid514_zeroCounter_uid94_Acc_q;

	--vStagei_uid518_zeroCounter_uid94_Acc(MUX,517)@74
    vStagei_uid518_zeroCounter_uid94_Acc_s <= vCount_uid513_zeroCounter_uid94_Acc_q;
    vStagei_uid518_zeroCounter_uid94_Acc: PROCESS (vStagei_uid518_zeroCounter_uid94_Acc_s, rVStage_uid512_zeroCounter_uid94_Acc_b, cStage_uid516_zeroCounter_uid94_Acc_q)
    BEGIN
            CASE vStagei_uid518_zeroCounter_uid94_Acc_s IS
                  WHEN "0" => vStagei_uid518_zeroCounter_uid94_Acc_q <= rVStage_uid512_zeroCounter_uid94_Acc_b;
                  WHEN "1" => vStagei_uid518_zeroCounter_uid94_Acc_q <= cStage_uid516_zeroCounter_uid94_Acc_q;
                  WHEN OTHERS => vStagei_uid518_zeroCounter_uid94_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid520_zeroCounter_uid94_Acc(BITSELECT,519)@74
    rVStage_uid520_zeroCounter_uid94_Acc_in <= vStagei_uid518_zeroCounter_uid94_Acc_q;
    rVStage_uid520_zeroCounter_uid94_Acc_b <= rVStage_uid520_zeroCounter_uid94_Acc_in(31 downto 16);

	--reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1(REG,1139)@74
    reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1_q <= "0000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1_q <= rVStage_uid520_zeroCounter_uid94_Acc_b;
        END IF;
    END PROCESS;


	--vCount_uid521_zeroCounter_uid94_Acc(LOGICAL,520)@75
    vCount_uid521_zeroCounter_uid94_Acc_a <= reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1_q;
    vCount_uid521_zeroCounter_uid94_Acc_b <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    vCount_uid521_zeroCounter_uid94_Acc_q <= "1" when vCount_uid521_zeroCounter_uid94_Acc_a = vCount_uid521_zeroCounter_uid94_Acc_b else "0";

	--reg_vCount_uid521_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_4(REG,1146)@75
    reg_vCount_uid521_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid521_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_4_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid521_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_4_q <= vCount_uid521_zeroCounter_uid94_Acc_q;
        END IF;
    END PROCESS;


	--vStage_uid522_zeroCounter_uid94_Acc(BITSELECT,521)@74
    vStage_uid522_zeroCounter_uid94_Acc_in <= vStagei_uid518_zeroCounter_uid94_Acc_q(15 downto 0);
    vStage_uid522_zeroCounter_uid94_Acc_b <= vStage_uid522_zeroCounter_uid94_Acc_in(15 downto 0);

	--reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3(REG,1141)@74
    reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3_q <= "0000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3_q <= vStage_uid522_zeroCounter_uid94_Acc_b;
        END IF;
    END PROCESS;


	--vStagei_uid524_zeroCounter_uid94_Acc(MUX,523)@75
    vStagei_uid524_zeroCounter_uid94_Acc_s <= vCount_uid521_zeroCounter_uid94_Acc_q;
    vStagei_uid524_zeroCounter_uid94_Acc: PROCESS (vStagei_uid524_zeroCounter_uid94_Acc_s, reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1_q, reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3_q)
    BEGIN
            CASE vStagei_uid524_zeroCounter_uid94_Acc_s IS
                  WHEN "0" => vStagei_uid524_zeroCounter_uid94_Acc_q <= reg_rVStage_uid520_zeroCounter_uid94_Acc_0_to_vCount_uid521_zeroCounter_uid94_Acc_1_q;
                  WHEN "1" => vStagei_uid524_zeroCounter_uid94_Acc_q <= reg_vStage_uid522_zeroCounter_uid94_Acc_0_to_vStagei_uid524_zeroCounter_uid94_Acc_3_q;
                  WHEN OTHERS => vStagei_uid524_zeroCounter_uid94_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid526_zeroCounter_uid94_Acc(BITSELECT,525)@75
    rVStage_uid526_zeroCounter_uid94_Acc_in <= vStagei_uid524_zeroCounter_uid94_Acc_q;
    rVStage_uid526_zeroCounter_uid94_Acc_b <= rVStage_uid526_zeroCounter_uid94_Acc_in(15 downto 8);

	--vCount_uid527_zeroCounter_uid94_Acc(LOGICAL,526)@75
    vCount_uid527_zeroCounter_uid94_Acc_a <= rVStage_uid526_zeroCounter_uid94_Acc_b;
    vCount_uid527_zeroCounter_uid94_Acc_b <= zeroExponent_uid99_Acc_q;
    vCount_uid527_zeroCounter_uid94_Acc_q <= "1" when vCount_uid527_zeroCounter_uid94_Acc_a = vCount_uid527_zeroCounter_uid94_Acc_b else "0";

	--reg_vCount_uid527_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_3(REG,1145)@75
    reg_vCount_uid527_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid527_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_3_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid527_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_3_q <= vCount_uid527_zeroCounter_uid94_Acc_q;
        END IF;
    END PROCESS;


	--vStage_uid528_zeroCounter_uid94_Acc(BITSELECT,527)@75
    vStage_uid528_zeroCounter_uid94_Acc_in <= vStagei_uid524_zeroCounter_uid94_Acc_q(7 downto 0);
    vStage_uid528_zeroCounter_uid94_Acc_b <= vStage_uid528_zeroCounter_uid94_Acc_in(7 downto 0);

	--vStagei_uid530_zeroCounter_uid94_Acc(MUX,529)@75
    vStagei_uid530_zeroCounter_uid94_Acc_s <= vCount_uid527_zeroCounter_uid94_Acc_q;
    vStagei_uid530_zeroCounter_uid94_Acc: PROCESS (vStagei_uid530_zeroCounter_uid94_Acc_s, rVStage_uid526_zeroCounter_uid94_Acc_b, vStage_uid528_zeroCounter_uid94_Acc_b)
    BEGIN
            CASE vStagei_uid530_zeroCounter_uid94_Acc_s IS
                  WHEN "0" => vStagei_uid530_zeroCounter_uid94_Acc_q <= rVStage_uid526_zeroCounter_uid94_Acc_b;
                  WHEN "1" => vStagei_uid530_zeroCounter_uid94_Acc_q <= vStage_uid528_zeroCounter_uid94_Acc_b;
                  WHEN OTHERS => vStagei_uid530_zeroCounter_uid94_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid532_zeroCounter_uid94_Acc(BITSELECT,531)@75
    rVStage_uid532_zeroCounter_uid94_Acc_in <= vStagei_uid530_zeroCounter_uid94_Acc_q;
    rVStage_uid532_zeroCounter_uid94_Acc_b <= rVStage_uid532_zeroCounter_uid94_Acc_in(7 downto 4);

	--vCount_uid533_zeroCounter_uid94_Acc(LOGICAL,532)@75
    vCount_uid533_zeroCounter_uid94_Acc_a <= rVStage_uid532_zeroCounter_uid94_Acc_b;
    vCount_uid533_zeroCounter_uid94_Acc_b <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    vCount_uid533_zeroCounter_uid94_Acc_q <= "1" when vCount_uid533_zeroCounter_uid94_Acc_a = vCount_uid533_zeroCounter_uid94_Acc_b else "0";

	--reg_vCount_uid533_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_2(REG,1144)@75
    reg_vCount_uid533_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vCount_uid533_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_2_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_vCount_uid533_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_2_q <= vCount_uid533_zeroCounter_uid94_Acc_q;
        END IF;
    END PROCESS;


	--vStage_uid534_zeroCounter_uid94_Acc(BITSELECT,533)@75
    vStage_uid534_zeroCounter_uid94_Acc_in <= vStagei_uid530_zeroCounter_uid94_Acc_q(3 downto 0);
    vStage_uid534_zeroCounter_uid94_Acc_b <= vStage_uid534_zeroCounter_uid94_Acc_in(3 downto 0);

	--vStagei_uid536_zeroCounter_uid94_Acc(MUX,535)@75
    vStagei_uid536_zeroCounter_uid94_Acc_s <= vCount_uid533_zeroCounter_uid94_Acc_q;
    vStagei_uid536_zeroCounter_uid94_Acc: PROCESS (vStagei_uid536_zeroCounter_uid94_Acc_s, rVStage_uid532_zeroCounter_uid94_Acc_b, vStage_uid534_zeroCounter_uid94_Acc_b)
    BEGIN
            CASE vStagei_uid536_zeroCounter_uid94_Acc_s IS
                  WHEN "0" => vStagei_uid536_zeroCounter_uid94_Acc_q <= rVStage_uid532_zeroCounter_uid94_Acc_b;
                  WHEN "1" => vStagei_uid536_zeroCounter_uid94_Acc_q <= vStage_uid534_zeroCounter_uid94_Acc_b;
                  WHEN OTHERS => vStagei_uid536_zeroCounter_uid94_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid538_zeroCounter_uid94_Acc(BITSELECT,537)@75
    rVStage_uid538_zeroCounter_uid94_Acc_in <= vStagei_uid536_zeroCounter_uid94_Acc_q;
    rVStage_uid538_zeroCounter_uid94_Acc_b <= rVStage_uid538_zeroCounter_uid94_Acc_in(3 downto 2);

	--vCount_uid539_zeroCounter_uid94_Acc(LOGICAL,538)@75
    vCount_uid539_zeroCounter_uid94_Acc_a <= rVStage_uid538_zeroCounter_uid94_Acc_b;
    vCount_uid539_zeroCounter_uid94_Acc_b <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    vCount_uid539_zeroCounter_uid94_Acc_q_i <= "1" when vCount_uid539_zeroCounter_uid94_Acc_a = vCount_uid539_zeroCounter_uid94_Acc_b else "0";
    vCount_uid539_zeroCounter_uid94_Acc_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => vCount_uid539_zeroCounter_uid94_Acc_q, xin => vCount_uid539_zeroCounter_uid94_Acc_q_i, clk => clk, aclr => areset);

	--vStage_uid540_zeroCounter_uid94_Acc(BITSELECT,539)@75
    vStage_uid540_zeroCounter_uid94_Acc_in <= vStagei_uid536_zeroCounter_uid94_Acc_q(1 downto 0);
    vStage_uid540_zeroCounter_uid94_Acc_b <= vStage_uid540_zeroCounter_uid94_Acc_in(1 downto 0);

	--reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3(REG,1143)@75
    reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3_q <= vStage_uid540_zeroCounter_uid94_Acc_b;
        END IF;
    END PROCESS;


	--reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2(REG,1142)@75
    reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2_q <= rVStage_uid538_zeroCounter_uid94_Acc_b;
        END IF;
    END PROCESS;


	--vStagei_uid542_zeroCounter_uid94_Acc(MUX,541)@76
    vStagei_uid542_zeroCounter_uid94_Acc_s <= vCount_uid539_zeroCounter_uid94_Acc_q;
    vStagei_uid542_zeroCounter_uid94_Acc: PROCESS (vStagei_uid542_zeroCounter_uid94_Acc_s, reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2_q, reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3_q)
    BEGIN
            CASE vStagei_uid542_zeroCounter_uid94_Acc_s IS
                  WHEN "0" => vStagei_uid542_zeroCounter_uid94_Acc_q <= reg_rVStage_uid538_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_2_q;
                  WHEN "1" => vStagei_uid542_zeroCounter_uid94_Acc_q <= reg_vStage_uid540_zeroCounter_uid94_Acc_0_to_vStagei_uid542_zeroCounter_uid94_Acc_3_q;
                  WHEN OTHERS => vStagei_uid542_zeroCounter_uid94_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rVStage_uid544_zeroCounter_uid94_Acc(BITSELECT,543)@76
    rVStage_uid544_zeroCounter_uid94_Acc_in <= vStagei_uid542_zeroCounter_uid94_Acc_q;
    rVStage_uid544_zeroCounter_uid94_Acc_b <= rVStage_uid544_zeroCounter_uid94_Acc_in(1 downto 1);

	--vCount_uid545_zeroCounter_uid94_Acc(LOGICAL,544)@76
    vCount_uid545_zeroCounter_uid94_Acc_a <= rVStage_uid544_zeroCounter_uid94_Acc_b;
    vCount_uid545_zeroCounter_uid94_Acc_b <= GND_q;
    vCount_uid545_zeroCounter_uid94_Acc_q <= "1" when vCount_uid545_zeroCounter_uid94_Acc_a = vCount_uid545_zeroCounter_uid94_Acc_b else "0";

	--r_uid546_zeroCounter_uid94_Acc(BITJOIN,545)@76
    r_uid546_zeroCounter_uid94_Acc_q <= reg_vCount_uid513_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_5_q & reg_vCount_uid521_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_4_q & reg_vCount_uid527_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_3_q & reg_vCount_uid533_zeroCounter_uid94_Acc_0_to_r_uid546_zeroCounter_uid94_Acc_2_q & vCount_uid539_zeroCounter_uid94_Acc_q & vCount_uid545_zeroCounter_uid94_Acc_q;

	--resExpSub_uid100_Acc(SUB,99)@76
    resExpSub_uid100_Acc_a <= STD_LOGIC_VECTOR("0" & expRBias_uid98_Acc_q);
    resExpSub_uid100_Acc_b <= STD_LOGIC_VECTOR("0000" & r_uid546_zeroCounter_uid94_Acc_q);
            resExpSub_uid100_Acc_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid100_Acc_a) - UNSIGNED(resExpSub_uid100_Acc_b));
    resExpSub_uid100_Acc_q <= resExpSub_uid100_Acc_o(9 downto 0);


	--finalExponent_uid101_Acc(BITSELECT,100)@76
    finalExponent_uid101_Acc_in <= resExpSub_uid100_Acc_q(7 downto 0);
    finalExponent_uid101_Acc_b <= finalExponent_uid101_Acc_in(7 downto 0);

	--accResOutOfExpRange_uid96_Acc(LOGICAL,95)@76
    accResOutOfExpRange_uid96_Acc_a <= ShiftedOutComparator_uid95_Acc_q;
    accResOutOfExpRange_uid96_Acc_b <= r_uid546_zeroCounter_uid94_Acc_q;
    accResOutOfExpRange_uid96_Acc_q <= "1" when accResOutOfExpRange_uid96_Acc_a = accResOutOfExpRange_uid96_Acc_b else "0";

	--finalExpUpdated_uid102_Acc(MUX,101)@76
    finalExpUpdated_uid102_Acc_s <= accResOutOfExpRange_uid96_Acc_q;
    finalExpUpdated_uid102_Acc: PROCESS (finalExpUpdated_uid102_Acc_s, finalExponent_uid101_Acc_b, zeroExponent_uid99_Acc_q)
    BEGIN
            CASE finalExpUpdated_uid102_Acc_s IS
                  WHEN "0" => finalExpUpdated_uid102_Acc_q <= finalExponent_uid101_Acc_b;
                  WHEN "1" => finalExpUpdated_uid102_Acc_q <= zeroExponent_uid99_Acc_q;
                  WHEN OTHERS => finalExpUpdated_uid102_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc(BITSELECT,575)@76
    LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc_in <= leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q(44 downto 0);
    LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc_b <= LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc_in(44 downto 0);

	--leftShiftStage2Idx3_uid577_normalizationShifter_uid97_Acc(BITJOIN,576)@76
    leftShiftStage2Idx3_uid577_normalizationShifter_uid97_Acc_q <= LeftShiftStage144dto0_uid576_normalizationShifter_uid97_Acc_b & rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q;

	--LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc(BITSELECT,572)@76
    LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc_in <= leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q(45 downto 0);
    LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc_b <= LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc_in(45 downto 0);

	--leftShiftStage2Idx2_uid574_normalizationShifter_uid97_Acc(BITJOIN,573)@76
    leftShiftStage2Idx2_uid574_normalizationShifter_uid97_Acc_q <= LeftShiftStage145dto0_uid573_normalizationShifter_uid97_Acc_b & rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;

	--LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc(BITSELECT,569)@76
    LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc_in <= leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q(46 downto 0);
    LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc_b <= LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc_in(46 downto 0);

	--leftShiftStage2Idx1_uid571_normalizationShifter_uid97_Acc(BITJOIN,570)@76
    leftShiftStage2Idx1_uid571_normalizationShifter_uid97_Acc_q <= LeftShiftStage146dto0_uid570_normalizationShifter_uid97_Acc_b & GND_q;

	--LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc(BITSELECT,564)@76
    LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc_in <= leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q(35 downto 0);
    LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc_b <= LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc_in(35 downto 0);

	--leftShiftStage1Idx3_uid566_normalizationShifter_uid97_Acc(BITJOIN,565)@76
    leftShiftStage1Idx3_uid566_normalizationShifter_uid97_Acc_q <= LeftShiftStage035dto0_uid565_normalizationShifter_uid97_Acc_b & rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q;

	--LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc(BITSELECT,561)@76
    LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc_in <= leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q(39 downto 0);
    LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc_b <= LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc_in(39 downto 0);

	--leftShiftStage1Idx2_uid563_normalizationShifter_uid97_Acc(BITJOIN,562)@76
    leftShiftStage1Idx2_uid563_normalizationShifter_uid97_Acc_q <= LeftShiftStage039dto0_uid562_normalizationShifter_uid97_Acc_b & zeroExponent_uid99_Acc_q;

	--LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc(BITSELECT,558)@76
    LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc_in <= leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q(43 downto 0);
    LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc_b <= LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc_in(43 downto 0);

	--leftShiftStage1Idx1_uid560_normalizationShifter_uid97_Acc(BITJOIN,559)@76
    leftShiftStage1Idx1_uid560_normalizationShifter_uid97_Acc_q <= LeftShiftStage043dto0_uid559_normalizationShifter_uid97_Acc_b & rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;

	--X15dto0_uid553_normalizationShifter_uid97_Acc(BITSELECT,552)@74
    X15dto0_uid553_normalizationShifter_uid97_Acc_in <= accValuePositive_uid92_Acc_q(15 downto 0);
    X15dto0_uid553_normalizationShifter_uid97_Acc_b <= X15dto0_uid553_normalizationShifter_uid97_Acc_in(15 downto 0);

	--ld_X15dto0_uid553_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_b(DELAY,1686)@74
    ld_X15dto0_uid553_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_b : dspba_delay
    GENERIC MAP ( width => 16, depth => 1 )
    PORT MAP ( xin => X15dto0_uid553_normalizationShifter_uid97_Acc_b, xout => ld_X15dto0_uid553_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_b_q, clk => clk, aclr => areset );

	--leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc(BITJOIN,553)@75
    leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_q <= ld_X15dto0_uid553_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_b_q & maxNegValueU_uid387_Convert7_q;

	--reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4(REG,1150)@75
    reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4_q <= "000000000000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4_q <= leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_q;
        END IF;
    END PROCESS;


	--X31dto0_uid550_normalizationShifter_uid97_Acc(BITSELECT,549)@74
    X31dto0_uid550_normalizationShifter_uid97_Acc_in <= accValuePositive_uid92_Acc_q(31 downto 0);
    X31dto0_uid550_normalizationShifter_uid97_Acc_b <= X31dto0_uid550_normalizationShifter_uid97_Acc_in(31 downto 0);

	--ld_X31dto0_uid550_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_b(DELAY,1684)@74
    ld_X31dto0_uid550_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_b : dspba_delay
    GENERIC MAP ( width => 32, depth => 1 )
    PORT MAP ( xin => X31dto0_uid550_normalizationShifter_uid97_Acc_b, xout => ld_X31dto0_uid550_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_b_q, clk => clk, aclr => areset );

	--leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc(BITJOIN,550)@75
    leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_q <= ld_X31dto0_uid550_normalizationShifter_uid97_Acc_b_to_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_b_q & rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;

	--reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3(REG,1149)@75
    reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3_q <= "000000000000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3_q <= leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_q;
        END IF;
    END PROCESS;


	--reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2(REG,1148)@74
    reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q <= "000000000000000000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q <= accValuePositive_uid92_Acc_q;
        END IF;
    END PROCESS;


	--ld_reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_c(DELAY,1689)@75
    ld_reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_c : dspba_delay
    GENERIC MAP ( width => 48, depth => 1 )
    PORT MAP ( xin => reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q, xout => ld_reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_c_q, clk => clk, aclr => areset );

	--leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc(BITSELECT,555)@76
    leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc_in <= r_uid546_zeroCounter_uid94_Acc_q;
    leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc_b <= leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc_in(5 downto 4);

	--leftShiftStage0_uid557_normalizationShifter_uid97_Acc(MUX,556)@76
    leftShiftStage0_uid557_normalizationShifter_uid97_Acc_s <= leftShiftStageSel5Dto4_uid556_normalizationShifter_uid97_Acc_b;
    leftShiftStage0_uid557_normalizationShifter_uid97_Acc: PROCESS (leftShiftStage0_uid557_normalizationShifter_uid97_Acc_s, ld_reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_c_q, reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3_q, reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4_q, rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q)
    BEGIN
            CASE leftShiftStage0_uid557_normalizationShifter_uid97_Acc_s IS
                  WHEN "00" => leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q <= ld_reg_accValuePositive_uid92_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_2_q_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_c_q;
                  WHEN "01" => leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q <= reg_leftShiftStage0Idx1_uid551_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_3_q;
                  WHEN "10" => leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q <= reg_leftShiftStage0Idx2_uid554_normalizationShifter_uid97_Acc_0_to_leftShiftStage0_uid557_normalizationShifter_uid97_Acc_4_q;
                  WHEN "11" => leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q <= rightShiftStage0Idx3Pad48_uid482_alignmentShifter_uid75_Acc_q;
                  WHEN OTHERS => leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc(BITSELECT,566)@76
    leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc_in <= r_uid546_zeroCounter_uid94_Acc_q(3 downto 0);
    leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc_b <= leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc_in(3 downto 2);

	--leftShiftStage1_uid568_normalizationShifter_uid97_Acc(MUX,567)@76
    leftShiftStage1_uid568_normalizationShifter_uid97_Acc_s <= leftShiftStageSel3Dto2_uid567_normalizationShifter_uid97_Acc_b;
    leftShiftStage1_uid568_normalizationShifter_uid97_Acc: PROCESS (leftShiftStage1_uid568_normalizationShifter_uid97_Acc_s, leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q, leftShiftStage1Idx1_uid560_normalizationShifter_uid97_Acc_q, leftShiftStage1Idx2_uid563_normalizationShifter_uid97_Acc_q, leftShiftStage1Idx3_uid566_normalizationShifter_uid97_Acc_q)
    BEGIN
            CASE leftShiftStage1_uid568_normalizationShifter_uid97_Acc_s IS
                  WHEN "00" => leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q <= leftShiftStage0_uid557_normalizationShifter_uid97_Acc_q;
                  WHEN "01" => leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q <= leftShiftStage1Idx1_uid560_normalizationShifter_uid97_Acc_q;
                  WHEN "10" => leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q <= leftShiftStage1Idx2_uid563_normalizationShifter_uid97_Acc_q;
                  WHEN "11" => leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q <= leftShiftStage1Idx3_uid566_normalizationShifter_uid97_Acc_q;
                  WHEN OTHERS => leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc(BITSELECT,577)@76
    leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc_in <= r_uid546_zeroCounter_uid94_Acc_q(1 downto 0);
    leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc_b <= leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc_in(1 downto 0);

	--leftShiftStage2_uid579_normalizationShifter_uid97_Acc(MUX,578)@76
    leftShiftStage2_uid579_normalizationShifter_uid97_Acc_s <= leftShiftStageSel1Dto0_uid578_normalizationShifter_uid97_Acc_b;
    leftShiftStage2_uid579_normalizationShifter_uid97_Acc: PROCESS (leftShiftStage2_uid579_normalizationShifter_uid97_Acc_s, leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q, leftShiftStage2Idx1_uid571_normalizationShifter_uid97_Acc_q, leftShiftStage2Idx2_uid574_normalizationShifter_uid97_Acc_q, leftShiftStage2Idx3_uid577_normalizationShifter_uid97_Acc_q)
    BEGIN
            CASE leftShiftStage2_uid579_normalizationShifter_uid97_Acc_s IS
                  WHEN "00" => leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q <= leftShiftStage1_uid568_normalizationShifter_uid97_Acc_q;
                  WHEN "01" => leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q <= leftShiftStage2Idx1_uid571_normalizationShifter_uid97_Acc_q;
                  WHEN "10" => leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q <= leftShiftStage2Idx2_uid574_normalizationShifter_uid97_Acc_q;
                  WHEN "11" => leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q <= leftShiftStage2Idx3_uid577_normalizationShifter_uid97_Acc_q;
                  WHEN OTHERS => leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--fracR_uid103_Acc(BITSELECT,102)@76
    fracR_uid103_Acc_in <= leftShiftStage2_uid579_normalizationShifter_uid97_Acc_q(44 downto 0);
    fracR_uid103_Acc_b <= fracR_uid103_Acc_in(44 downto 22);

	--R_uid104_Acc(BITJOIN,103)@76
    R_uid104_Acc_q <= ld_accumulatorSign_uid86_Acc_b_to_R_uid104_Acc_c_q & finalExpUpdated_uid102_Acc_q & fracR_uid103_Acc_b;

	--signX_uid362_Convert7(BITSELECT,361)@76
    signX_uid362_Convert7_in <= R_uid104_Acc_q;
    signX_uid362_Convert7_b <= signX_uid362_Convert7_in(31 downto 31);

	--reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2(REG,1157)@76
    reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2_q <= signX_uid362_Convert7_b;
        END IF;
    END PROCESS;


	--fracX_uid359_Convert7(BITSELECT,358)@76
    fracX_uid359_Convert7_in <= R_uid104_Acc_q(22 downto 0);
    fracX_uid359_Convert7_b <= fracX_uid359_Convert7_in(22 downto 0);

	--oFracX_uid360_uid360_Convert7(BITJOIN,359)@76
    oFracX_uid360_uid360_Convert7_q <= VCC_q & fracX_uid359_Convert7_b;

	--zOFracX_uid370_Convert7(BITJOIN,369)@76
    zOFracX_uid370_Convert7_q <= GND_q & oFracX_uid360_uid360_Convert7_q;

	--shifterIn_uid372_Convert7(BITJOIN,371)@76
    shifterIn_uid372_Convert7_q <= zOFracX_uid370_Convert7_q & zeroExponent_uid99_Acc_q;

	--msbx_uid972_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,971)@76
    msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_in <= shifterIn_uid372_Convert7_q;
    msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b <= msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 32);

	--rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,1007)@76
    rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_a <= rightShiftStage2Idx3Pad3_uid504_alignmentShifter_uid75_Acc_q;
    rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((2 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 3, depth => 1)
    PORT MAP (xout => rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,1008)@77
    RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7_in <= rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q;
    RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7_b <= RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 3);

	--rightShiftStage2Idx3_uid1010_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,1009)@77
    rightShiftStage2Idx3_uid1010_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage2Idx3Pad3_uid1008_rightShiferNoStickyOut_uid373_Convert7_q & RightShiftStage132dto3_uid1009_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,1003)@76
    rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_a <= rightShiftStage2Idx2Pad2_uid501_alignmentShifter_uid75_Acc_q;
    rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((1 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 2, depth => 1)
    PORT MAP (xout => rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,1004)@77
    RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7_in <= rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q;
    RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7_b <= RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 2);

	--rightShiftStage2Idx2_uid1006_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,1005)@77
    rightShiftStage2Idx2_uid1006_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage2Idx2Pad2_uid1004_rightShiferNoStickyOut_uid373_Convert7_q & RightShiftStage132dto2_uid1005_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,999)@76
    rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_a <= GND_q;
    rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_b <= msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 1, depth => 1)
    PORT MAP (xout => rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,1000)@77
    RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7_in <= rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q;
    RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7_b <= RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 1);

	--rightShiftStage2Idx1_uid1002_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,1001)@77
    rightShiftStage2Idx1_uid1002_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage2Idx1Pad1_uid1000_rightShiferNoStickyOut_uid373_Convert7_q & RightShiftStage132dto1_uid1001_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,993)@76
    rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_a <= rightShiftStage1Idx3Pad12_uid493_alignmentShifter_uid75_Acc_q;
    rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((11 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 12, depth => 1)
    PORT MAP (xout => rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,994)@77
    RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7_in <= rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q;
    RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7_b <= RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 12);

	--rightShiftStage1Idx3_uid996_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,995)@77
    rightShiftStage1Idx3_uid996_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1Idx3Pad12_uid994_rightShiferNoStickyOut_uid373_Convert7_q & RightShiftStage032dto12_uid995_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,989)@76
    rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_a <= zeroExponent_uid99_Acc_q;
    rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((7 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 8, depth => 1)
    PORT MAP (xout => rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,990)@77
    RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7_in <= rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q;
    RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7_b <= RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 8);

	--rightShiftStage1Idx2_uid992_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,991)@77
    rightShiftStage1Idx2_uid992_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1Idx2Pad8_uid990_rightShiferNoStickyOut_uid373_Convert7_q & RightShiftStage032dto8_uid991_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,985)@76
    rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_a <= rightShiftStage1Idx1Pad4_uid487_alignmentShifter_uid75_Acc_q;
    rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((3 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 4, depth => 1)
    PORT MAP (xout => rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,986)@77
    RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7_in <= rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q;
    RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7_b <= RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 4);

	--rightShiftStage1Idx1_uid988_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,987)@77
    rightShiftStage1Idx1_uid988_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1Idx1Pad4_uid986_rightShiferNoStickyOut_uid373_Convert7_q & RightShiftStage032dto4_uid987_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,981)@76
    rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_a <= rightShiftStage0Idx3_uid981_rightShiferNoStickyOut_uid373_Convert7_q;
    rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((32 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q_i <= rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_b;
    rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_delay : dspba_delay
    GENERIC MAP (width => 33, depth => 1)
    PORT MAP (xout => rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q, xin => rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q_i, clk => clk, aclr => areset);

	--rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,977)@76
    rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_a <= maxNegValueU_uid387_Convert7_q;
    rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((31 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_b;

	--rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,979)@76
    rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage0Idx2Pad32_uid978_rightShiferNoStickyOut_uid373_Convert7_q & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b;

	--reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4(REG,1154)@76
    reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4_q <= "000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4_q <= rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_q;
        END IF;
    END PROCESS;


	--rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7(LOGICAL,973)@76
    rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_a <= rightShiftStage0Idx1Pad16_uid476_alignmentShifter_uid75_Acc_q;
    rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_b <= STD_LOGIC_VECTOR((15 downto 1 => msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b(0)) & msbx_uid972_rightShiferNoStickyOut_uid373_Convert7_b);
    rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_a or rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_b;

	--X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,974)@76
    X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7_in <= shifterIn_uid372_Convert7_q;
    X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7_b <= X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7_in(32 downto 16);

	--rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7(BITJOIN,975)@76
    rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage0Idx1Pad16_uid974_rightShiferNoStickyOut_uid373_Convert7_q & X32dto16_uid975_rightShiferNoStickyOut_uid373_Convert7_b;

	--reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3(REG,1153)@76
    reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3_q <= "000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3_q <= rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_q;
        END IF;
    END PROCESS;


	--reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2(REG,1152)@76
    reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2_q <= "000000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2_q <= shifterIn_uid372_Convert7_q;
        END IF;
    END PROCESS;


	--expX_uid361_Convert7(BITSELECT,360)@76
    expX_uid361_Convert7_in <= R_uid104_Acc_q(30 downto 0);
    expX_uid361_Convert7_b <= expX_uid361_Convert7_in(30 downto 23);

	--shiftValE_uid368_Convert7(SUB,367)@76
    shiftValE_uid368_Convert7_a <= STD_LOGIC_VECTOR("0" & ovfExpVal_uid367_Convert7_q);
    shiftValE_uid368_Convert7_b <= STD_LOGIC_VECTOR("0" & expX_uid361_Convert7_b);
            shiftValE_uid368_Convert7_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftValE_uid368_Convert7_a) - UNSIGNED(shiftValE_uid368_Convert7_b));
    shiftValE_uid368_Convert7_q <= shiftValE_uid368_Convert7_o(8 downto 0);


	--shiftVal_uid369_Convert7(BITSELECT,368)@76
    shiftVal_uid369_Convert7_in <= shiftValE_uid368_Convert7_q(5 downto 0);
    shiftVal_uid369_Convert7_b <= shiftVal_uid369_Convert7_in(5 downto 0);

	--rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,982)@76
    rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_in <= shiftVal_uid369_Convert7_b;
    rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_b <= rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_in(5 downto 4);

	--reg_rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_1(REG,1151)@76
    reg_rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_1_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_1_q <= rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_b;
        END IF;
    END PROCESS;


	--rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7(MUX,983)@77
    rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_s <= reg_rightShiftStageSel5Dto4_uid983_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_1_q;
    rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7: PROCESS (rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_s, reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2_q, reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3_q, reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4_q, rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q)
    BEGIN
            CASE rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_s IS
                  WHEN "00" => rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q <= reg_shifterIn_uid372_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_2_q;
                  WHEN "01" => rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q <= reg_rightShiftStage0Idx1_uid976_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_3_q;
                  WHEN "10" => rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q <= reg_rightShiftStage0Idx2_uid980_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_4_q;
                  WHEN "11" => rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage0Idx3_uid982_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN OTHERS => rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,996)@76
    rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_in <= shiftVal_uid369_Convert7_b(3 downto 0);
    rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_b <= rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_in(3 downto 2);

	--reg_rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_1(REG,1155)@76
    reg_rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_1_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_1_q <= rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_b;
        END IF;
    END PROCESS;


	--rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7(MUX,997)@77
    rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_s <= reg_rightShiftStageSel3Dto2_uid997_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_1_q;
    rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7: PROCESS (rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_s, rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q, rightShiftStage1Idx1_uid988_rightShiferNoStickyOut_uid373_Convert7_q, rightShiftStage1Idx2_uid992_rightShiferNoStickyOut_uid373_Convert7_q, rightShiftStage1Idx3_uid996_rightShiferNoStickyOut_uid373_Convert7_q)
    BEGIN
            CASE rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_s IS
                  WHEN "00" => rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage0_uid984_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN "01" => rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1Idx1_uid988_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN "10" => rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1Idx2_uid992_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN "11" => rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1Idx3_uid996_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN OTHERS => rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q <= (others => '0');
            END CASE;
    END PROCESS;


	--rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7(BITSELECT,1010)@76
    rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_in <= shiftVal_uid369_Convert7_b(1 downto 0);
    rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_b <= rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_in(1 downto 0);

	--reg_rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_1(REG,1156)@76
    reg_rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_1_q <= "00";
        ELSIF rising_edge(clk) THEN
            reg_rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_1_q <= rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_b;
        END IF;
    END PROCESS;


	--rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7(MUX,1011)@77
    rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_s <= reg_rightShiftStageSel1Dto0_uid1011_rightShiferNoStickyOut_uid373_Convert7_0_to_rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_1_q;
    rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7: PROCESS (rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_s, rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q, rightShiftStage2Idx1_uid1002_rightShiferNoStickyOut_uid373_Convert7_q, rightShiftStage2Idx2_uid1006_rightShiferNoStickyOut_uid373_Convert7_q, rightShiftStage2Idx3_uid1010_rightShiferNoStickyOut_uid373_Convert7_q)
    BEGIN
            CASE rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_s IS
                  WHEN "00" => rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage1_uid998_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN "01" => rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage2Idx1_uid1002_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN "10" => rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage2Idx2_uid1006_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN "11" => rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q <= rightShiftStage2Idx3_uid1010_rightShiferNoStickyOut_uid373_Convert7_q;
                  WHEN OTHERS => rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q <= (others => '0');
            END CASE;
    END PROCESS;


	--zRightShiferNoStickyOut_uid374_Convert7(BITJOIN,373)@77
    zRightShiferNoStickyOut_uid374_Convert7_q <= GND_q & rightShiftStage2_uid1012_rightShiferNoStickyOut_uid373_Convert7_q;

	--xXorSign_uid375_Convert7(LOGICAL,374)@77
    xXorSign_uid375_Convert7_a <= zRightShiferNoStickyOut_uid374_Convert7_q;
    xXorSign_uid375_Convert7_b <= STD_LOGIC_VECTOR((33 downto 1 => reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2_q(0)) & reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2_q);
    xXorSign_uid375_Convert7_q <= xXorSign_uid375_Convert7_a xor xXorSign_uid375_Convert7_b;

	--sPostRndFull_uid377_Convert7(ADD,376)@77
    sPostRndFull_uid377_Convert7_a <= STD_LOGIC_VECTOR((34 downto 34 => xXorSign_uid375_Convert7_q(33)) & xXorSign_uid375_Convert7_q);
    sPostRndFull_uid377_Convert7_b <= STD_LOGIC_VECTOR((34 downto 3 => d0_uid376_Convert7_q(2)) & d0_uid376_Convert7_q);
            sPostRndFull_uid377_Convert7_o <= STD_LOGIC_VECTOR(SIGNED(sPostRndFull_uid377_Convert7_a) + SIGNED(sPostRndFull_uid377_Convert7_b));
    sPostRndFull_uid377_Convert7_q <= sPostRndFull_uid377_Convert7_o(34 downto 0);


	--sPostRnd_uid378_Convert7(BITSELECT,377)@77
    sPostRnd_uid378_Convert7_in <= sPostRndFull_uid377_Convert7_q(32 downto 0);
    sPostRnd_uid378_Convert7_b <= sPostRnd_uid378_Convert7_in(32 downto 1);

	--reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2(REG,1161)@77
    reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2_q <= "00000000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2_q <= sPostRnd_uid378_Convert7_b;
        END IF;
    END PROCESS;


	--ld_reg_signX_uid362_Convert7_0_to_muxSelConc_uid385_Convert7_2_q_to_muxSelConc_uid385_Convert7_c(DELAY,1529)@77
    ld_reg_signX_uid362_Convert7_0_to_muxSelConc_uid385_Convert7_2_q_to_muxSelConc_uid385_Convert7_c : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => reg_signX_uid362_Convert7_0_to_xXorSign_uid375_Convert7_2_q, xout => ld_reg_signX_uid362_Convert7_0_to_muxSelConc_uid385_Convert7_2_q_to_muxSelConc_uid385_Convert7_c_q, clk => clk, aclr => areset );

	--udf_uid366_Convert7(COMPARE,365)@76
    udf_uid366_Convert7_cin <= GND_q;
    udf_uid366_Convert7_a <= STD_LOGIC_VECTOR("00" & udfExpVal_uid365_Convert7_q) & '0';
    udf_uid366_Convert7_b <= STD_LOGIC_VECTOR("00" & expX_uid361_Convert7_b) & udf_uid366_Convert7_cin(0);
    udf_uid366_Convert7: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            udf_uid366_Convert7_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            udf_uid366_Convert7_o <= STD_LOGIC_VECTOR(UNSIGNED(udf_uid366_Convert7_a) - UNSIGNED(udf_uid366_Convert7_b));
        END IF;
    END PROCESS;
    udf_uid366_Convert7_n(0) <= not udf_uid366_Convert7_o(10);


	--ld_udf_uid366_Convert7_n_to_muxSelConc_uid385_Convert7_b(DELAY,1528)@77
    ld_udf_uid366_Convert7_n_to_muxSelConc_uid385_Convert7_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => udf_uid366_Convert7_n, xout => ld_udf_uid366_Convert7_n_to_muxSelConc_uid385_Convert7_b_q, clk => clk, aclr => areset );

	--sPostRndFullMSBU_uid379_Convert7(BITSELECT,378)@77
    sPostRndFullMSBU_uid379_Convert7_in <= sPostRndFull_uid377_Convert7_q(33 downto 0);
    sPostRndFullMSBU_uid379_Convert7_b <= sPostRndFullMSBU_uid379_Convert7_in(33 downto 33);

	--reg_sPostRndFullMSBU_uid379_Convert7_0_to_rndOvf_uid381_Convert7_2(REG,1159)@77
    reg_sPostRndFullMSBU_uid379_Convert7_0_to_rndOvf_uid381_Convert7_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_sPostRndFullMSBU_uid379_Convert7_0_to_rndOvf_uid381_Convert7_2_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_sPostRndFullMSBU_uid379_Convert7_0_to_rndOvf_uid381_Convert7_2_q <= sPostRndFullMSBU_uid379_Convert7_b;
        END IF;
    END PROCESS;


	--sPostRndFullMSBU_uid380_Convert7(BITSELECT,379)@77
    sPostRndFullMSBU_uid380_Convert7_in <= sPostRndFull_uid377_Convert7_q;
    sPostRndFullMSBU_uid380_Convert7_b <= sPostRndFullMSBU_uid380_Convert7_in(34 downto 34);

	--reg_sPostRndFullMSBU_uid380_Convert7_0_to_rndOvf_uid381_Convert7_1(REG,1158)@77
    reg_sPostRndFullMSBU_uid380_Convert7_0_to_rndOvf_uid381_Convert7_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_sPostRndFullMSBU_uid380_Convert7_0_to_rndOvf_uid381_Convert7_1_q <= "0";
        ELSIF rising_edge(clk) THEN
            reg_sPostRndFullMSBU_uid380_Convert7_0_to_rndOvf_uid381_Convert7_1_q <= sPostRndFullMSBU_uid380_Convert7_b;
        END IF;
    END PROCESS;


	--rndOvf_uid381_Convert7(LOGICAL,380)@78
    rndOvf_uid381_Convert7_a <= reg_sPostRndFullMSBU_uid380_Convert7_0_to_rndOvf_uid381_Convert7_1_q;
    rndOvf_uid381_Convert7_b <= reg_sPostRndFullMSBU_uid379_Convert7_0_to_rndOvf_uid381_Convert7_2_q;
    rndOvf_uid381_Convert7_q <= rndOvf_uid381_Convert7_a xor rndOvf_uid381_Convert7_b;

	--ovf_uid364_Convert7(COMPARE,363)@76
    ovf_uid364_Convert7_cin <= GND_q;
    ovf_uid364_Convert7_a <= STD_LOGIC_VECTOR("00" & expX_uid361_Convert7_b) & '0';
    ovf_uid364_Convert7_b <= STD_LOGIC_VECTOR("00" & msbIn_uid184_Convert_q) & ovf_uid364_Convert7_cin(0);
    ovf_uid364_Convert7: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ovf_uid364_Convert7_o <= (others => '0');
        ELSIF(clk'EVENT AND clk = '1') THEN
            ovf_uid364_Convert7_o <= STD_LOGIC_VECTOR(UNSIGNED(ovf_uid364_Convert7_a) - UNSIGNED(ovf_uid364_Convert7_b));
        END IF;
    END PROCESS;
    ovf_uid364_Convert7_n(0) <= not ovf_uid364_Convert7_o(10);


	--ld_ovf_uid364_Convert7_n_to_ovfPostRnd_uid384_Convert7_a(DELAY,1525)@77
    ld_ovf_uid364_Convert7_n_to_ovfPostRnd_uid384_Convert7_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => ovf_uid364_Convert7_n, xout => ld_ovf_uid364_Convert7_n_to_ovfPostRnd_uid384_Convert7_a_q, clk => clk, aclr => areset );

	--ovfPostRnd_uid384_Convert7(LOGICAL,383)@78
    ovfPostRnd_uid384_Convert7_a <= ld_ovf_uid364_Convert7_n_to_ovfPostRnd_uid384_Convert7_a_q;
    ovfPostRnd_uid384_Convert7_b <= rndOvf_uid381_Convert7_q;
    ovfPostRnd_uid384_Convert7_q <= ovfPostRnd_uid384_Convert7_a or ovfPostRnd_uid384_Convert7_b;

	--muxSelConc_uid385_Convert7(BITJOIN,384)@78
    muxSelConc_uid385_Convert7_q <= ld_reg_signX_uid362_Convert7_0_to_muxSelConc_uid385_Convert7_2_q_to_muxSelConc_uid385_Convert7_c_q & ld_udf_uid366_Convert7_n_to_muxSelConc_uid385_Convert7_b_q & ovfPostRnd_uid384_Convert7_q;

	--muxSel_uid386_Convert7(LOOKUP,385)@78
    muxSel_uid386_Convert7: PROCESS (muxSelConc_uid385_Convert7_q)
    BEGIN
        -- Begin reserved scope level
            CASE muxSelConc_uid385_Convert7_q IS
                WHEN "000" =>  muxSel_uid386_Convert7_q <= "00";
                WHEN "001" =>  muxSel_uid386_Convert7_q <= "01";
                WHEN "010" =>  muxSel_uid386_Convert7_q <= "11";
                WHEN "011" =>  muxSel_uid386_Convert7_q <= "00";
                WHEN "100" =>  muxSel_uid386_Convert7_q <= "00";
                WHEN "101" =>  muxSel_uid386_Convert7_q <= "10";
                WHEN "110" =>  muxSel_uid386_Convert7_q <= "11";
                WHEN "111" =>  muxSel_uid386_Convert7_q <= "00";
                WHEN OTHERS =>
                    muxSel_uid386_Convert7_q <= (others => '-');
            END CASE;
        -- End reserved scope level
    END PROCESS;


	--finalOut_uid388_Convert7(MUX,387)@78
    finalOut_uid388_Convert7_s <= muxSel_uid386_Convert7_q;
    finalOut_uid388_Convert7: PROCESS (finalOut_uid388_Convert7_s, reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2_q, maxPosValueS_uid382_Convert7_q, maxNegValueS_uid383_Convert7_q, maxNegValueU_uid387_Convert7_q)
    BEGIN
            CASE finalOut_uid388_Convert7_s IS
                  WHEN "00" => finalOut_uid388_Convert7_q <= reg_sPostRnd_uid378_Convert7_0_to_finalOut_uid388_Convert7_2_q;
                  WHEN "01" => finalOut_uid388_Convert7_q <= maxPosValueS_uid382_Convert7_q;
                  WHEN "10" => finalOut_uid388_Convert7_q <= maxNegValueS_uid383_Convert7_q;
                  WHEN "11" => finalOut_uid388_Convert7_q <= maxNegValueU_uid387_Convert7_q;
                  WHEN OTHERS => finalOut_uid388_Convert7_q <= (others => '0');
            END CASE;
    END PROCESS;


	--ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem(DUALMEM,2416)
    ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_ia <= channel;
    ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_aa <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg_q;
    ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_ab <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q;
    ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 6,
        numwords_a => 64,
        width_b => 8,
        widthad_b => 6,
        numwords_b => 64,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_iq,
        address_a => ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_aa,
        data_a => ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_ia
    );
        ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_q <= ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_iq(7 downto 0);

	--ld_ChannelIn_channel_to_ChannelOut_cout_replace_wrreg(REG,2345)
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_wrreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_channel_to_ChannelOut_cout_replace_wrreg_q <= "0000";
        ELSIF rising_edge(clk) THEN
            ld_ChannelIn_channel_to_ChannelOut_cout_replace_wrreg_q <= ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_q;
        END IF;
    END PROCESS;


	--ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt(COUNTER,2344)
    -- every=1, low=0, high=12, step=1, init=1
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i <= TO_UNSIGNED(1,4);
            ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
                IF ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i = 11 THEN
                  ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_eq <= '1';
                ELSE
                  ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_eq = '1') THEN
                    ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i <= ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i - 12;
                ELSE
                    ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i <= ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i + 1;
                END IF;
        END IF;
    END PROCESS;
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_i,4));


	--ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem(DUALMEM,2343)
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_ia <= ld_ChannelIn_channel_to_ChannelOut_cout_split_0_replace_mem_q;
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_aa <= ld_ChannelIn_channel_to_ChannelOut_cout_replace_wrreg_q;
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_ab <= ld_ChannelIn_channel_to_ChannelOut_cout_replace_rdcnt_q;
    ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 4,
        numwords_a => 13,
        width_b => 8,
        widthad_b => 4,
        numwords_b => 13,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_iq,
        address_a => ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_aa,
        data_a => ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_ia
    );
        ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_q <= ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_iq(7 downto 0);

	--ld_ChannelIn_channel_to_ChannelOut_cout_outputreg(DELAY,2341)
    ld_ChannelIn_channel_to_ChannelOut_cout_outputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1 )
    PORT MAP ( xin => ld_ChannelIn_channel_to_ChannelOut_cout_replace_mem_q, xout => ld_ChannelIn_channel_to_ChannelOut_cout_outputreg_q, clk => clk, aclr => areset );

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem(DUALMEM,2405)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_ia <= valid;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_aa <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_wrreg_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_ab <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_rdcnt_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 1,
        widthad_a => 6,
        numwords_a => 64,
        width_b => 1,
        widthad_b => 6,
        numwords_b => 64,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "UNREGISTERED",
        outdata_aclr_b => "NONE",
        clock_enable_output_b => "BYPASS",
        address_reg_b => "CLOCK0",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Stratix IV"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        wren_a => VCC_q(0),
        clock0 => clk,
        address_b => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_ab,
        -- data_b => (others => '0'),
        q_b => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_iq,
        address_a => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_aa,
        data_a => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_ia
    );
        ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_iq(0 downto 0);

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor(LOGICAL,2412)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_b <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_q <= not (ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_a or ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_b);

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena(REG,2413)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena_q <= "0";
        ELSIF rising_edge(clk) THEN
            IF (ld_ChannelIn_valid_to_ChannelOut_vout_split_0_nor_q = "1") THEN
                ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg_q;
            END IF;
        END IF;
    END PROCESS;


	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd(LOGICAL,2414)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_a <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_sticky_ena_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_b <= VCC_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_a and ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_b;

	--ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux(MUX,2415)
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_s <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaAnd_q;
    ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux: PROCESS (ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_s, GND_q, ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_q)
    BEGIN
            CASE ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_s IS
                  WHEN "0" => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_q <= GND_q;
                  WHEN "1" => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_replace_mem_q;
                  WHEN OTHERS => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_q <= (others => '0');
            END CASE;
    END PROCESS;


	--ld_ChannelIn_valid_to_ChannelOut_vout(DELAY,1186)@0
    ld_ChannelIn_valid_to_ChannelOut_vout : dspba_delay
    GENERIC MAP ( width => 1, depth => 13 )
    PORT MAP ( xin => ld_ChannelIn_valid_to_ChannelOut_vout_split_0_enaMux_q, xout => ld_ChannelIn_valid_to_ChannelOut_vout_q, clk => clk, aclr => areset );

	--ld_ChannelIn_valid_to_ChannelOut_vout_outputreg(DELAY,2339)
    ld_ChannelIn_valid_to_ChannelOut_vout_outputreg : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => ld_ChannelIn_valid_to_ChannelOut_vout_q, xout => ld_ChannelIn_valid_to_ChannelOut_vout_outputreg_q, clk => clk, aclr => areset );

	--ChannelOut(PORTOUT,6)@78
    vout <= ld_ChannelIn_valid_to_ChannelOut_vout_outputreg_q;
    cout <= ld_ChannelIn_channel_to_ChannelOut_cout_outputreg_q;
    result_x <= finalOut_uid388_Convert7_q;
    result_y <= finalOut_uid421_Convert8_q;


	--expLTLSBA_uid69_Acc(CONSTANT,68)
    expLTLSBA_uid69_Acc_q <= "01100101";

	--expGTMaxMSBX_uid71_Acc(CONSTANT,70)
    expGTMaxMSBX_uid71_Acc_q <= "10001011";

	--ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b(DELAY,1264)@0
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 6 )
    PORT MAP ( xin => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_q, xout => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_q, clk => clk, aclr => areset );

	--ld_muxXOverflowFeedbackSignal_uid108_Acc_q_to_oRXOverflowFlagFeedback_uid109_Acc_a(DELAY,1265)@71
    ld_muxXOverflowFeedbackSignal_uid108_Acc_q_to_oRXOverflowFlagFeedback_uid109_Acc_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => muxXOverflowFeedbackSignal_uid108_Acc_q, xout => ld_muxXOverflowFeedbackSignal_uid108_Acc_q_to_oRXOverflowFlagFeedback_uid109_Acc_a_q, clk => clk, aclr => areset );

	--ld_muxXUnderflowFeedbackSignal_uid112_Acc_q_to_oRXUnderflowFlagFeedback_uid113_Acc_a(DELAY,1268)@71
    ld_muxXUnderflowFeedbackSignal_uid112_Acc_q_to_oRXUnderflowFlagFeedback_uid113_Acc_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => muxXUnderflowFeedbackSignal_uid112_Acc_q, xout => ld_muxXUnderflowFeedbackSignal_uid112_Acc_q_to_oRXUnderflowFlagFeedback_uid113_Acc_a_q, clk => clk, aclr => areset );

	--ld_muxAccOverflowFeedbackSignal_uid116_Acc_q_to_oRAccOverflowFlagFeedback_uid117_Acc_a(DELAY,1271)@73
    ld_muxAccOverflowFeedbackSignal_uid116_Acc_q_to_oRAccOverflowFlagFeedback_uid117_Acc_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => muxAccOverflowFeedbackSignal_uid116_Acc_q, xout => ld_muxAccOverflowFeedbackSignal_uid116_Acc_q_to_oRAccOverflowFlagFeedback_uid117_Acc_a_q, clk => clk, aclr => areset );

	--ld_muxXOverflowFeedbackSignal_uid164_Acc1_q_to_oRXOverflowFlagFeedback_uid165_Acc1_a(DELAY,1312)@71
    ld_muxXOverflowFeedbackSignal_uid164_Acc1_q_to_oRXOverflowFlagFeedback_uid165_Acc1_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => muxXOverflowFeedbackSignal_uid164_Acc1_q, xout => ld_muxXOverflowFeedbackSignal_uid164_Acc1_q_to_oRXOverflowFlagFeedback_uid165_Acc1_a_q, clk => clk, aclr => areset );

	--ld_muxXUnderflowFeedbackSignal_uid168_Acc1_q_to_oRXUnderflowFlagFeedback_uid169_Acc1_a(DELAY,1315)@71
    ld_muxXUnderflowFeedbackSignal_uid168_Acc1_q_to_oRXUnderflowFlagFeedback_uid169_Acc1_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => muxXUnderflowFeedbackSignal_uid168_Acc1_q, xout => ld_muxXUnderflowFeedbackSignal_uid168_Acc1_q_to_oRXUnderflowFlagFeedback_uid169_Acc1_a_q, clk => clk, aclr => areset );

	--ld_muxAccOverflowFeedbackSignal_uid172_Acc1_q_to_oRAccOverflowFlagFeedback_uid173_Acc1_a(DELAY,1318)@73
    ld_muxAccOverflowFeedbackSignal_uid172_Acc1_q_to_oRAccOverflowFlagFeedback_uid173_Acc1_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => muxAccOverflowFeedbackSignal_uid172_Acc1_q, xout => ld_muxAccOverflowFeedbackSignal_uid172_Acc1_q_to_oRAccOverflowFlagFeedback_uid173_Acc1_a_q, clk => clk, aclr => areset );

	--ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg(DELAY,2384)
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_q, xout => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg_q, clk => clk, aclr => areset );

	--ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena(REG,2438)
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena_q <= "0";
        ELSIF rising_edge(clk) THEN
            IF (ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_q = "1") THEN
                ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena_q <= ld_ChannelIn_valid_to_ChannelOut_vout_split_0_cmpReg_q;
            END IF;
        END IF;
    END PROCESS;


	--ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd(LOGICAL,2439)
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_a <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena_q;
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_b <= VCC_q;
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_q <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_a and ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_b;

	--ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux(MUX,2440)
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_s <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaAnd_q;
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux: PROCESS (ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_s, GND_q, ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_q)
    BEGIN
            CASE ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_s IS
                  WHEN "0" => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_q <= GND_q;
                  WHEN "1" => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_q <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_split_0_replace_mem_q;
                  WHEN OTHERS => ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_enaMux_q <= (others => '0');
            END CASE;
    END PROCESS;


	--cmpLT_w8_uid70_Acc(COMPARE,69)@72
    cmpLT_w8_uid70_Acc_cin <= GND_q;
    cmpLT_w8_uid70_Acc_a <= STD_LOGIC_VECTOR("00" & expX_uid65_Acc_b) & '0';
    cmpLT_w8_uid70_Acc_b <= STD_LOGIC_VECTOR("00" & expLTLSBA_uid69_Acc_q) & cmpLT_w8_uid70_Acc_cin(0);
            cmpLT_w8_uid70_Acc_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpLT_w8_uid70_Acc_a) - UNSIGNED(cmpLT_w8_uid70_Acc_b));
    cmpLT_w8_uid70_Acc_c(0) <= cmpLT_w8_uid70_Acc_o(10);


	--cmpLT_w8_uid126_Acc1(COMPARE,125)@72
    cmpLT_w8_uid126_Acc1_cin <= GND_q;
    cmpLT_w8_uid126_Acc1_a <= STD_LOGIC_VECTOR("00" & expX_uid121_Acc1_b) & '0';
    cmpLT_w8_uid126_Acc1_b <= STD_LOGIC_VECTOR("00" & expLTLSBA_uid69_Acc_q) & cmpLT_w8_uid126_Acc1_cin(0);
            cmpLT_w8_uid126_Acc1_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpLT_w8_uid126_Acc1_a) - UNSIGNED(cmpLT_w8_uid126_Acc1_b));
    cmpLT_w8_uid126_Acc1_c(0) <= cmpLT_w8_uid126_Acc1_o(10);


	--cmpGT_w8_uid72_Acc(COMPARE,71)@72
    cmpGT_w8_uid72_Acc_cin <= GND_q;
    cmpGT_w8_uid72_Acc_a <= STD_LOGIC_VECTOR("00" & expGTMaxMSBX_uid71_Acc_q) & '0';
    cmpGT_w8_uid72_Acc_b <= STD_LOGIC_VECTOR("00" & expX_uid65_Acc_b) & cmpGT_w8_uid72_Acc_cin(0);
            cmpGT_w8_uid72_Acc_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpGT_w8_uid72_Acc_a) - UNSIGNED(cmpGT_w8_uid72_Acc_b));
    cmpGT_w8_uid72_Acc_c(0) <= cmpGT_w8_uid72_Acc_o(10);


	--cmpGT_w8_uid128_Acc1(COMPARE,127)@72
    cmpGT_w8_uid128_Acc1_cin <= GND_q;
    cmpGT_w8_uid128_Acc1_a <= STD_LOGIC_VECTOR("00" & expGTMaxMSBX_uid71_Acc_q) & '0';
    cmpGT_w8_uid128_Acc1_b <= STD_LOGIC_VECTOR("00" & expX_uid121_Acc1_b) & cmpGT_w8_uid128_Acc1_cin(0);
            cmpGT_w8_uid128_Acc1_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpGT_w8_uid128_Acc1_a) - UNSIGNED(cmpGT_w8_uid128_Acc1_b));
    cmpGT_w8_uid128_Acc1_c(0) <= cmpGT_w8_uid128_Acc1_o(10);


	--oRXOverflowFlagFeedback_uid109_Acc(LOGICAL,108)@72
    oRXOverflowFlagFeedback_uid109_Acc_a <= ld_muxXOverflowFeedbackSignal_uid108_Acc_q_to_oRXOverflowFlagFeedback_uid109_Acc_a_q;
    oRXOverflowFlagFeedback_uid109_Acc_b <= cmpGT_w8_uid72_Acc_c;
    oRXOverflowFlagFeedback_uid109_Acc_q <= oRXOverflowFlagFeedback_uid109_Acc_a or oRXOverflowFlagFeedback_uid109_Acc_b;

	--oRXUnderflowFlagFeedback_uid113_Acc(LOGICAL,112)@72
    oRXUnderflowFlagFeedback_uid113_Acc_a <= ld_muxXUnderflowFeedbackSignal_uid112_Acc_q_to_oRXUnderflowFlagFeedback_uid113_Acc_a_q;
    oRXUnderflowFlagFeedback_uid113_Acc_b <= cmpLT_w8_uid70_Acc_c;
    oRXUnderflowFlagFeedback_uid113_Acc_q <= oRXUnderflowFlagFeedback_uid113_Acc_a or oRXUnderflowFlagFeedback_uid113_Acc_b;

	--oRXOverflowFlagFeedback_uid165_Acc1(LOGICAL,164)@72
    oRXOverflowFlagFeedback_uid165_Acc1_a <= ld_muxXOverflowFeedbackSignal_uid164_Acc1_q_to_oRXOverflowFlagFeedback_uid165_Acc1_a_q;
    oRXOverflowFlagFeedback_uid165_Acc1_b <= cmpGT_w8_uid128_Acc1_c;
    oRXOverflowFlagFeedback_uid165_Acc1_q <= oRXOverflowFlagFeedback_uid165_Acc1_a or oRXOverflowFlagFeedback_uid165_Acc1_b;

	--oRXUnderflowFlagFeedback_uid169_Acc1(LOGICAL,168)@72
    oRXUnderflowFlagFeedback_uid169_Acc1_a <= ld_muxXUnderflowFeedbackSignal_uid168_Acc1_q_to_oRXUnderflowFlagFeedback_uid169_Acc1_a_q;
    oRXUnderflowFlagFeedback_uid169_Acc1_b <= cmpLT_w8_uid126_Acc1_c;
    oRXUnderflowFlagFeedback_uid169_Acc1_q <= oRXUnderflowFlagFeedback_uid169_Acc1_a or oRXUnderflowFlagFeedback_uid169_Acc1_b;

	--muxXOverflowFeedbackSignal_uid108_Acc(MUX,107)@71
    muxXOverflowFeedbackSignal_uid108_Acc_s <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg_q;
    muxXOverflowFeedbackSignal_uid108_Acc: PROCESS (muxXOverflowFeedbackSignal_uid108_Acc_s, oRXOverflowFlagFeedback_uid109_Acc_q, GND_q)
    BEGIN
            CASE muxXOverflowFeedbackSignal_uid108_Acc_s IS
                  WHEN "0" => muxXOverflowFeedbackSignal_uid108_Acc_q <= oRXOverflowFlagFeedback_uid109_Acc_q;
                  WHEN "1" => muxXOverflowFeedbackSignal_uid108_Acc_q <= GND_q;
                  WHEN OTHERS => muxXOverflowFeedbackSignal_uid108_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--muxXUnderflowFeedbackSignal_uid112_Acc(MUX,111)@71
    muxXUnderflowFeedbackSignal_uid112_Acc_s <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg_q;
    muxXUnderflowFeedbackSignal_uid112_Acc: PROCESS (muxXUnderflowFeedbackSignal_uid112_Acc_s, oRXUnderflowFlagFeedback_uid113_Acc_q, GND_q)
    BEGIN
            CASE muxXUnderflowFeedbackSignal_uid112_Acc_s IS
                  WHEN "0" => muxXUnderflowFeedbackSignal_uid112_Acc_q <= oRXUnderflowFlagFeedback_uid113_Acc_q;
                  WHEN "1" => muxXUnderflowFeedbackSignal_uid112_Acc_q <= GND_q;
                  WHEN OTHERS => muxXUnderflowFeedbackSignal_uid112_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--muxXOverflowFeedbackSignal_uid164_Acc1(MUX,163)@71
    muxXOverflowFeedbackSignal_uid164_Acc1_s <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg_q;
    muxXOverflowFeedbackSignal_uid164_Acc1: PROCESS (muxXOverflowFeedbackSignal_uid164_Acc1_s, oRXOverflowFlagFeedback_uid165_Acc1_q, GND_q)
    BEGIN
            CASE muxXOverflowFeedbackSignal_uid164_Acc1_s IS
                  WHEN "0" => muxXOverflowFeedbackSignal_uid164_Acc1_q <= oRXOverflowFlagFeedback_uid165_Acc1_q;
                  WHEN "1" => muxXOverflowFeedbackSignal_uid164_Acc1_q <= GND_q;
                  WHEN OTHERS => muxXOverflowFeedbackSignal_uid164_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--muxXUnderflowFeedbackSignal_uid168_Acc1(MUX,167)@71
    muxXUnderflowFeedbackSignal_uid168_Acc1_s <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_outputreg_q;
    muxXUnderflowFeedbackSignal_uid168_Acc1: PROCESS (muxXUnderflowFeedbackSignal_uid168_Acc1_s, oRXUnderflowFlagFeedback_uid169_Acc1_q, GND_q)
    BEGIN
            CASE muxXUnderflowFeedbackSignal_uid168_Acc1_s IS
                  WHEN "0" => muxXUnderflowFeedbackSignal_uid168_Acc1_q <= oRXUnderflowFlagFeedback_uid169_Acc1_q;
                  WHEN "1" => muxXUnderflowFeedbackSignal_uid168_Acc1_q <= GND_q;
                  WHEN OTHERS => muxXUnderflowFeedbackSignal_uid168_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


	--ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor(LOGICAL,2437)
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_a <= ld_Mult3_f_1_cast_q_to_Mult3_f_b_notEnable_q;
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_b <= ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_sticky_ena_q;
    ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_q <= not (ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_a or ld_ChannelIn_start_to_muxXOverflowFeedbackSignal_uid108_Acc_b_split_0_nor_b);

	--accOverflowBitMSB_uid87_Acc(BITSELECT,86)@74
    accOverflowBitMSB_uid87_Acc_in <= sum_uid84_Acc_b;
    accOverflowBitMSB_uid87_Acc_b <= accOverflowBitMSB_uid87_Acc_in(47 downto 47);

	--accOverflowBitMSB_uid143_Acc1(BITSELECT,142)@74
    accOverflowBitMSB_uid143_Acc1_in <= sum_uid140_Acc1_b;
    accOverflowBitMSB_uid143_Acc1_b <= accOverflowBitMSB_uid143_Acc1_in(47 downto 47);

	--accOverflow_uid89_Acc(LOGICAL,88)@74
    accOverflow_uid89_Acc_a <= accOverflowBitMSB_uid87_Acc_b;
    accOverflow_uid89_Acc_b <= accumulatorSign_uid86_Acc_b;
    accOverflow_uid89_Acc_q <= accOverflow_uid89_Acc_a xor accOverflow_uid89_Acc_b;

	--accOverflow_uid145_Acc1(LOGICAL,144)@74
    accOverflow_uid145_Acc1_a <= accOverflowBitMSB_uid143_Acc1_b;
    accOverflow_uid145_Acc1_b <= accumulatorSign_uid142_Acc1_b;
    accOverflow_uid145_Acc1_q <= accOverflow_uid145_Acc1_a xor accOverflow_uid145_Acc1_b;

	--oRAccOverflowFlagFeedback_uid117_Acc(LOGICAL,116)@74
    oRAccOverflowFlagFeedback_uid117_Acc_a <= ld_muxAccOverflowFeedbackSignal_uid116_Acc_q_to_oRAccOverflowFlagFeedback_uid117_Acc_a_q;
    oRAccOverflowFlagFeedback_uid117_Acc_b <= accOverflow_uid89_Acc_q;
    oRAccOverflowFlagFeedback_uid117_Acc_q <= oRAccOverflowFlagFeedback_uid117_Acc_a or oRAccOverflowFlagFeedback_uid117_Acc_b;

	--oRAccOverflowFlagFeedback_uid173_Acc1(LOGICAL,172)@74
    oRAccOverflowFlagFeedback_uid173_Acc1_a <= ld_muxAccOverflowFeedbackSignal_uid172_Acc1_q_to_oRAccOverflowFlagFeedback_uid173_Acc1_a_q;
    oRAccOverflowFlagFeedback_uid173_Acc1_b <= accOverflow_uid145_Acc1_q;
    oRAccOverflowFlagFeedback_uid173_Acc1_q <= oRAccOverflowFlagFeedback_uid173_Acc1_a or oRAccOverflowFlagFeedback_uid173_Acc1_b;

	--muxAccOverflowFeedbackSignal_uid116_Acc(MUX,115)@73
    muxAccOverflowFeedbackSignal_uid116_Acc_s <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg_q;
    muxAccOverflowFeedbackSignal_uid116_Acc: PROCESS (muxAccOverflowFeedbackSignal_uid116_Acc_s, oRAccOverflowFlagFeedback_uid117_Acc_q, GND_q)
    BEGIN
            CASE muxAccOverflowFeedbackSignal_uid116_Acc_s IS
                  WHEN "0" => muxAccOverflowFeedbackSignal_uid116_Acc_q <= oRAccOverflowFlagFeedback_uid117_Acc_q;
                  WHEN "1" => muxAccOverflowFeedbackSignal_uid116_Acc_q <= GND_q;
                  WHEN OTHERS => muxAccOverflowFeedbackSignal_uid116_Acc_q <= (others => '0');
            END CASE;
    END PROCESS;


	--muxAccOverflowFeedbackSignal_uid172_Acc1(MUX,171)@73
    muxAccOverflowFeedbackSignal_uid172_Acc1_s <= ld_ChannelIn_start_to_accumulator_uid82_Acc_l_outputreg_q;
    muxAccOverflowFeedbackSignal_uid172_Acc1: PROCESS (muxAccOverflowFeedbackSignal_uid172_Acc1_s, oRAccOverflowFlagFeedback_uid173_Acc1_q, GND_q)
    BEGIN
            CASE muxAccOverflowFeedbackSignal_uid172_Acc1_s IS
                  WHEN "0" => muxAccOverflowFeedbackSignal_uid172_Acc1_q <= oRAccOverflowFlagFeedback_uid173_Acc1_q;
                  WHEN "1" => muxAccOverflowFeedbackSignal_uid172_Acc1_q <= GND_q;
                  WHEN OTHERS => muxAccOverflowFeedbackSignal_uid172_Acc1_q <= (others => '0');
            END CASE;
    END PROCESS;


end normal;
