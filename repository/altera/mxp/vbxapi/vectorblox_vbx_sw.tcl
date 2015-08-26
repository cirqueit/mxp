###########################################################################
#
# Copyright (C) 2012-2015 VectorBlox Computing, Inc.
#
###########################################################################

create_driver vectorblox_vbx_driver
set_sw_property hw_class_name vectorblox_mxp

# Tells alt_sys_init() to call *_INIT initialization macro:
set_sw_property auto_initialize true

set_sw_property version 1.0

set_sw_property min_compatible_hw_version 1.0

set_sw_property bsp_subdirectory vbxapi

add_sw_property supported_bsp_type HAL

add_sw_property c_source src/vbx_api.c
add_sw_property c_source src/vectorblox_mxp_nios.c
add_sw_property cpp_source src/Vector.cpp
add_sw_property include_source inc/vbx_all.h
add_sw_property include_source inc/vbx_common.h
add_sw_property include_source inc/vbx_lib.h
add_sw_property include_source inc/vbx_asm_enc32.h
add_sw_property include_source inc/vbx_lib_common.h
add_sw_property include_source inc/vbx_port.h
add_sw_property include_source inc/vbx_asm_or_sim.h
add_sw_property include_source inc/vbx_counters.h
add_sw_property include_source inc/vbx_macros.h
add_sw_property include_source inc/vbx_types.h
add_sw_property include_source inc/vectorblox_mxp_nios.h
add_sw_property include_source inc/vbx_cproto.h
add_sw_property include_source inc/vbx_api.h
add_sw_property include_source inc/vbx_lib_asm.h
add_sw_property include_source inc/vectorblox_mxp_lin.h
add_sw_property include_source inc/vbx.h
add_sw_property include_source inc/vbx_lib_sim.h
add_sw_property include_source inc/vectorblox_mxp.h
add_sw_property include_source inc/vbx_asm_nios.h
add_sw_property include_source inc/vbx_extern.h
add_sw_property include_source inc/vbxsim_port.h
add_sw_property include_source inc/vbx_copyright.h
add_sw_property include_source inc/prefetch.hpp
add_sw_property include_source inc/vector_mask_obj.hpp
add_sw_property include_source inc/vbx_or_mask.hpp
add_sw_property include_source inc/vbxx.hpp
add_sw_property include_source inc/masked_vector.hpp
add_sw_property include_source inc/Vector.hpp
add_sw_property include_source inc/expression_width.hpp
add_sw_property include_source inc/vbx_func.hpp
add_sw_property include_source inc/range.hpp
add_sw_property include_source inc/convert_vinstr.hpp
add_sw_property include_source inc/fwd_declaration.hpp
add_sw_property include_source inc/assign.hpp
add_sw_property include_source inc/type_manipulation.hpp
add_sw_property include_source inc/Logical_op.hpp
add_sw_property include_source inc/vinstr.hpp
add_sw_property include_source inc/operators.hpp
add_sw_property include_source inc/resolve.hpp

# Adds <bsp_subdirectory>/inc to ALT_INCLUDE_DIRS in public.mk
add_sw_property include_directory inc

###########################################################################
