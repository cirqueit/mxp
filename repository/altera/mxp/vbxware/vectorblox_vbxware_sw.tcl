###########################################################################
#
# Copyright (C) 2012-2015 VectorBlox Computing, Inc.
#
###########################################################################

create_sw_package vectorblox_vbxware_package

set_sw_property version 1.0

set_sw_property bsp_subdirectory vbxware

add_sw_property supported_bsp_type HAL

add_sw_property c_source src/vbw_mtx_median_argb32.c
add_sw_property c_source src/vbw_mtx_motest.c
add_sw_property c_source src/vbw_sobel_argb32_3x3.c
add_sw_property c_source src/vbw_bifilt_argb32.c
add_sw_property c_source src/vbw_fix16.c
add_sw_property c_source src/vbw_rgb2luma16.c
add_sw_property c_source src/vbw_sobel_luma16_3x3.c
add_sw_property c_source src/vbw_rgb2luma8.c
add_sw_property c_source src/vbw_sobel_luma8_3x3.c
add_sw_property cpp_source src/vbw_vec_div.cpp
add_sw_property cpp_source src/vbw_vec_add.cpp
add_sw_property cpp_source src/vbw_mtx_xp.cpp
add_sw_property cpp_source src/vbw_vec_fir.cpp
add_sw_property cpp_source src/vbw_mtx_mm.cpp
add_sw_property cpp_source src/vbw_vec_copy.cpp
add_sw_property cpp_source src/vbw_vec_rev.cpp
add_sw_property cpp_source src/vbw_vec_power.cpp
add_sw_property cpp_source src/vbw_mtx_fir.cpp
add_sw_property cpp_source src/vbw_mtx_median.cpp
add_sw_property include_source inc/vbw_vec_fir.h
add_sw_property include_source inc/vbw_buffer.h
add_sw_property include_source inc/vbw_mtx_median.h
add_sw_property include_source inc/vbw_exit_codes.h
add_sw_property include_source inc/vbw_ware.h
add_sw_property include_source inc/vbw_mtx_xp.h
add_sw_property include_source inc/vbw_template_t.h
add_sw_property include_source inc/vbw_vec_power.h
add_sw_property include_source inc/vbw_vec_add.h
add_sw_property include_source inc/vbw_mtx_fir.h
add_sw_property include_source inc/vbw_fix16.h
add_sw_property include_source inc/vbw_mtx_sobel.h
add_sw_property include_source inc/vbw_vec_rev.h
add_sw_property include_source inc/vbw_mtx_median_argb32.h
add_sw_property include_source inc/vbw_mtx_motest.h
add_sw_property include_source inc/vbw_mtx_mm.h
add_sw_property include_source inc/vbw_vec_div.h
add_sw_property include_source inc/vbw_vec_copy.h
add_sw_property include_source inc/vbw_template.hpp
add_sw_property include_source inc/vbw_mtx_xp_template.hpp
add_sw_property include_source inc/vbw_mtx_mm.hpp
add_sw_property include_source inc/vbw_vec_fir_template.hpp

# Adds <bsp_subdirectory>/inc to ALT_INCLUDE_DIRS in public.mk
add_sw_property include_directory inc

###########################################################################
