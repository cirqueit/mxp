-- safe_path for Galaxy_dut given rtl dir is ./rtl (modelsim)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE Galaxy_dut_safe_path is
	FUNCTION safe_path( path: string ) RETURN string;
END Galaxy_dut_safe_path;

PACKAGE body Galaxy_dut_safe_path IS
	FUNCTION safe_path( path: string )
		RETURN string IS
	BEGIN
		RETURN path;
	END FUNCTION safe_path;
END Galaxy_dut_safe_path;
