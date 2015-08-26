/* VECTORBLOX MXP SOFTWARE DEVELOPMENT KIT
 *
 * Copyright (C) 2012-2015 VectorBlox Computing Inc., Vancouver, British Columbia, Canada.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 *     * Neither the name of VectorBlox Computing Inc. nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * This agreement shall be governed in all respects by the laws of the Province
 * of British Columbia and by the laws of Canada.
 *
 * This file is part of the VectorBlox MXP Software Development Kit.
 *
 */


#if __MICROBLAZE__ || __ARM_ARCH_7A__

#include "vbx_copyright.h"
VBXCOPYRIGHT( vectorblox_mxp_xil )

#include "xparameters.h"
#include "vbx.h"
#include "vectorblox_mxp.h"

extern VectorBlox_MXP_Config VectorBlox_MXP_ConfigTable[];

//Initialize VCUSTOMx_LANES based on VCI info
void VectorBlox_MXP_VCUSTOM_init(vbx_mxp_t *mxp, u16 lanes, u8 opcode_start, u8 functions) {
	int func;
	for(func = 0; func < functions; func++){
		switch(opcode_start+func){
		case 0:	
			mxp->vcustom0_lanes = (short) lanes;
			break;
		case 1:	
			mxp->vcustom1_lanes = (short) lanes;
			break;
		case 2:	
			mxp->vcustom2_lanes = (short) lanes;
			break;
		case 3:	
			mxp->vcustom3_lanes = (short) lanes;
			break;
		case 4:	
			mxp->vcustom4_lanes = (short) lanes;
			break;
		case 5:	
			mxp->vcustom5_lanes = (short) lanes;
			break;
		case 6:	
			mxp->vcustom6_lanes = (short) lanes;
			break;
		case 7:	
			mxp->vcustom7_lanes = (short) lanes;
			break;
		case 8:	
			mxp->vcustom8_lanes = (short) lanes;
			break;
		case 9:	
			mxp->vcustom9_lanes = (short) lanes;
			break;
		case 10:	
			mxp->vcustom10_lanes = (short) lanes;
			break;
		case 11:	
			mxp->vcustom11_lanes = (short) lanes;
			break;
		case 12:	
			mxp->vcustom12_lanes = (short) lanes;
			break;
		case 13:	
			mxp->vcustom13_lanes = (short) lanes;
			break;
		case 14:	
			mxp->vcustom14_lanes = (short) lanes;
			break;
		case 15:	
			mxp->vcustom15_lanes = (short) lanes;
			break;
		default:
			break;
		}
	}
}

/*****************************************************************************
* Initialize fields of vbx_mxp_t structure and call _vbx_init.
*
* @param	mxp is a pointer to a vbx_mxp_t instance.
* @param	device_id is the unique id of the vbx_mxp peripheral.
*
* @return
*		- XST_SUCCESS if initialization was successful
*		- XST_DEVICE_NOT_FOUND if the device doesn't exist
*
* @note		None.
*
******************************************************************************/

int VectorBlox_MXP_Initialize(vbx_mxp_t* mxp, u16 device_id) {

	VectorBlox_MXP_Config *cfg;

	Xil_AssertNonvoid(mxp != NULL);

	cfg = VectorBlox_MXP_LookupConfig(device_id);

	if (!cfg) {
		return XST_DEVICE_NOT_FOUND;
	}

	mxp->scratchpad_addr = (vbx_void_t *) (cfg->baseaddr);
	// this is cfg->highaddr + 1
	mxp->scratchpad_end  = \
		(vbx_void_t *) (cfg->baseaddr + (cfg->scratchpad_kb * 1024));
	mxp->scratchpad_size = (int) (cfg->scratchpad_kb * 1024);
	mxp->dma_alignment_bytes = (short) (cfg->memory_width_bits / 8);
	mxp->scratchpad_alignment_bytes = (short) (cfg->vector_lanes * 4);
	mxp->vector_lanes = (short) (cfg->vector_lanes);

	mxp->vector_custom_instructions = (char) (cfg->vector_custom_instructions);
	mxp->vcustom0_lanes  = (short) 0;
	mxp->vcustom1_lanes  = (short) 0;
	mxp->vcustom2_lanes  = (short) 0;
	mxp->vcustom3_lanes  = (short) 0;
	mxp->vcustom4_lanes  = (short) 0;
	mxp->vcustom5_lanes  = (short) 0;
	mxp->vcustom6_lanes  = (short) 0;
	mxp->vcustom7_lanes  = (short) 0;
	mxp->vcustom8_lanes  = (short) 0;
	mxp->vcustom9_lanes  = (short) 0;
	mxp->vcustom10_lanes = (short) 0;
	mxp->vcustom11_lanes = (short) 0;
	mxp->vcustom12_lanes = (short) 0;
	mxp->vcustom13_lanes = (short) 0;
	mxp->vcustom14_lanes = (short) 0;
	mxp->vcustom15_lanes = (short) 0;
	if(cfg->vector_custom_instructions > 0){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_0_lanes, cfg->vci_0_opcode_start, cfg->vci_0_functions);
	}
	if(cfg->vector_custom_instructions > 1){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_1_lanes, cfg->vci_1_opcode_start, cfg->vci_1_functions);
	}
	if(cfg->vector_custom_instructions > 2){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_2_lanes, cfg->vci_2_opcode_start, cfg->vci_2_functions);
	}
	if(cfg->vector_custom_instructions > 3){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_3_lanes, cfg->vci_3_opcode_start, cfg->vci_3_functions);
	}
	if(cfg->vector_custom_instructions > 4){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_4_lanes, cfg->vci_4_opcode_start, cfg->vci_4_functions);
	}
	if(cfg->vector_custom_instructions > 5){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_5_lanes, cfg->vci_5_opcode_start, cfg->vci_5_functions);
	}
	if(cfg->vector_custom_instructions > 6){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_6_lanes, cfg->vci_6_opcode_start, cfg->vci_6_functions);
	}
	if(cfg->vector_custom_instructions > 7){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_7_lanes, cfg->vci_7_opcode_start, cfg->vci_7_functions);
	}
	if(cfg->vector_custom_instructions > 8){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_8_lanes, cfg->vci_8_opcode_start, cfg->vci_8_functions);
	}
	if(cfg->vector_custom_instructions > 9){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_9_lanes, cfg->vci_9_opcode_start, cfg->vci_9_functions);
	}
	if(cfg->vector_custom_instructions > 10){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_10_lanes, cfg->vci_10_opcode_start, cfg->vci_10_functions);
	}
	if(cfg->vector_custom_instructions > 11){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_11_lanes, cfg->vci_11_opcode_start, cfg->vci_11_functions);
	}
	if(cfg->vector_custom_instructions > 12){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_12_lanes, cfg->vci_12_opcode_start, cfg->vci_12_functions);
	}
	if(cfg->vector_custom_instructions > 13){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_13_lanes, cfg->vci_13_opcode_start, cfg->vci_13_functions);
	}
	if(cfg->vector_custom_instructions > 14){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_14_lanes, cfg->vci_14_opcode_start, cfg->vci_14_functions);
	}
	if(cfg->vector_custom_instructions > 15){
		VectorBlox_MXP_VCUSTOM_init(mxp, cfg->vci_15_lanes, cfg->vci_15_opcode_start, cfg->vci_15_functions);
	}

	mxp->mask_partitions = (short) (cfg->mask_partitions);
	mxp->max_masked_vector_length = (int) (cfg->max_masked_waves * cfg->vector_lanes * 4);
	mxp->fxp_word_frac_bits = (char) (cfg->fxp_word_frac_bits);
	mxp->fxp_half_frac_bits = (char) (cfg->fxp_half_frac_bits);
	mxp->fxp_byte_frac_bits = (char) (cfg->fxp_byte_frac_bits);
	mxp->core_freq = (int) (cfg->core_freq);
	mxp->instr_port_addr = (vbx_void_t *) (cfg->instr_port_addr);

	mxp->init = (char) 0;
	// Assuming scratchpad is in a non-cacheable region of the MicroBlaze's
	// address space.
	mxp->sp = (vbx_void_t *) (cfg->baseaddr);
	mxp->spstack = (vbx_void_t **) NULL;
	mxp->spstack_top = (int) 0;
	mxp->spstack_max = (int) 0;

	_vbx_init(mxp);

	return XST_SUCCESS;
}

/*****************************************************************************
*
* Looks up the device configuration based on the unique device ID. The table
* VectorBlox_MXP_ConfigTable contains the configuration info for each device
* in the system.
*
* @param	device_id is the unique device ID to search for in the config
*		table.
*
* @return	A pointer to the configuration that matches the given device ID,
* 		or NULL if no match is found.
*
* @note		None.
*
******************************************************************************/
VectorBlox_MXP_Config *VectorBlox_MXP_LookupConfig(u16 device_id) {

	VectorBlox_MXP_Config *cfg = NULL;
	int i;
	int num_instances;

	num_instances = XPAR_VECTORBLOX_MXP_NUM_INSTANCES;
	for (i = 0; i < num_instances; i++) {
		if (VectorBlox_MXP_ConfigTable[i].device_id == device_id) {
			cfg = &VectorBlox_MXP_ConfigTable[i];
			break;
		}
	}

	return cfg;

}

__attribute__((constructor)) void auto_initialize_function(void)
{
#if !defined(XPAR_VECTORBLOX_MXP_0_DEVICE_ID)
#warning  XPAR_VECTORBLOX_MXP_0_DEVICE_ID not defined so auto initialization failed.\
	must manually call VectorBlox_MXP_Initialize()
#else
	static vbx_mxp_t vbx_mxp_inst;
	VectorBlox_MXP_Initialize(&vbx_mxp_inst, XPAR_VECTORBLOX_MXP_0_DEVICE_ID);
#endif
}


#endif // __MICROBLAZE__ || __ARM_ARCH_7A__
