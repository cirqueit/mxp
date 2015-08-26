//Frame Writer
//Aaron Severance

`define FIFO_DEPTH      64
`define FIFO_DEPTH_BITS 6
`define BURST_DEPTH     32

module frame_writer
   (
    //----------------//
    // Global Signals //
    //----------------//
    input 	                      clk,
    input 		              reset,

    //--------//
    // Inputs //
    //--------//
    input                             din_valid,
    input                             din_startofpacket,
    input                             din_endofpacket,
    input [23:0]                      din_data,

    input                             slave_read,
    input  	                      slave_write,
    input [1:0]                       slave_address,
    input [31:0] 	              slave_writedata,

    input                             master_waitrequest,
 
    //---------//
    // Outputs //
    //---------//
    output                            din_ready,

    output reg                        interrupt,
    output                            slave_waitrequest,
    output reg [31:0] 	              slave_readdata,

    output reg                        master_write,
    output reg [`FIFO_DEPTH_BITS-1:0] master_burstcount,
    output reg [31:0]                 master_address,
    output [31:0]                     master_writedata
    );

   //------------//
   //REGISTER MAP//
   //------------//
`define CONTROL_REG       0
   //0 - Control.       Read/Write: Bit 0 = Interrupt enable.  
   //                   Read only:  Bit 31 Receiving data, writing frame.  
   //                               Bit 30 Finished recieving data, writing FIFO to memory.
   //                               Bit 29 Ready to recieve data
   //                               Bits 21:16 FIFO entries currently waiting to be written.
`define LAST_FRAME_REG    1
   //1 - Last Frame.    Last vaild written frame, 0 if no frame.  Reading resets it 0.
`define CURRENT_FRAME_REG 2
   //2 - Current Frame. Currently transferring to this address.
`define NEXT_FRAME_REG    3
   //3 - Next Frame.    Write this to set next frame address.  Reset to 0 when starting transfer.  
   //                   If 0 when a new frame comes in, frame will be dropped.


   //-------------------//
   //Wires and Registers//
   //-------------------//
   reg 				      address_control;
   reg 				      address_last_frame;
   reg 				      address_next_frame;
   
   wire 			      control_write;
   wire 			      next_frame_write;
   wire 			      frame_end;
   wire 			      frame_start;
   wire 			      last_frame_read;

   reg 				      interrupt_enable;
   reg [31:0] 			      last_frame;
   reg [31:0] 			      current_frame;
   reg [31:0] 			      next_frame;

   wire 			      pfifo_read;
   wire 			      pfifo_write;
   wire [23:0] 			      pfifo_d;
   wire [23:0] 			      pfifo_q;
   wire 			      pfifo_empty;
   wire 			      pfifo_full;
   reg 				      pfifo_almost_full;
   wire [`FIFO_DEPTH_BITS-1:0] 	      pfifo_usedw;

   reg 				      flushing_fifo;
   reg 				      within_frame;
   reg 				      din_ready_d1;
   reg [`FIFO_DEPTH_BITS-1:0] 	      internal_burstcount;
   
   //-----//
   //Logic//
   //-----//
   assign slave_waitrequest = 1'b0;
   always @(*) begin
      address_control       = 1'b0;
      address_last_frame    = 1'b0;
      address_next_frame    = 1'b0;
      slave_readdata        = 0;
      
      case(slave_address)
	`CONTROL_REG: begin
	   address_control                        = 1'b1;
	   slave_readdata[31]                     = within_frame;
	   slave_readdata[30]                     = flushing_fifo;
	   slave_readdata[29]                     = din_ready_d1;
	   slave_readdata[15+`FIFO_DEPTH_BITS:16] = pfifo_usedw;
	   slave_readdata[0]                      = interrupt_enable;
	end
	`LAST_FRAME_REG: begin
	   slave_readdata     = last_frame;
	   address_last_frame = 1'b1;
	end
	`CURRENT_FRAME_REG: begin
	   slave_readdata        = current_frame;
	end
	`NEXT_FRAME_REG: begin
	   slave_readdata     = next_frame;
	   address_next_frame = 1'b1;
	end
      endcase
   end
   assign control_write    = slave_write & address_control;
   assign next_frame_write = slave_write & address_next_frame;
   assign last_frame_read  = slave_read  & address_last_frame;
   
   always @(posedge clk) begin
      if(reset) begin
	 interrupt        <= 1'b0;
	 interrupt_enable <= 1'b0;
	 last_frame       <= 0;
	 current_frame    <= 0;
	 next_frame       <= 0;
      end
      else begin
	 if(frame_end | (current_frame == 0)) begin
	    current_frame <= next_frame;
	    next_frame    <= 0;
	 end
	 if(next_frame_write) begin
	    next_frame <= slave_writedata;
	 end
	 
	 if(frame_end) begin
	    last_frame <= current_frame;
	    interrupt  <= interrupt_enable;
	 end
	 else if(last_frame_read) begin
	    last_frame <= 0;
	    interrupt  <= 1'b0;
	 end
	 

	 if(control_write) begin
	    interrupt_enable <= slave_writedata[0];
	    if(~slave_writedata[0]) begin
	       interrupt <= 1'b0;
	    end
	 end
      end
   end

   always @(posedge clk) begin
      pfifo_almost_full <= 1'b0;
      if((pfifo_usedw >= (`FIFO_DEPTH-4)) | pfifo_full) begin
	pfifo_almost_full <= 1'b1;
      end
   end
   
   //Because we need to set ready low 1 cycle in advance, keep at least 1 extra spot open in FIFO
   //Also, set ready low when we're flushing the FIFO at the end of a packet.
   assign din_ready = ~pfifo_almost_full & ~flushing_fifo & ~(din_valid & din_endofpacket);
   always @(posedge clk) begin
      din_ready_d1 <= din_ready;
   end
   
   assign pfifo_d     = din_data;
   assign pfifo_write = din_valid & within_frame;
   assign pfifo_read  = master_write & ~master_waitrequest;

   assign master_writedata = pfifo_q;

   assign frame_start = ~within_frame & ~flushing_fifo & din_valid & din_startofpacket & (current_frame != 0) & (din_data[3:0] == 4'b0000);
   assign frame_end   = flushing_fifo & pfifo_empty;
			
   always @(posedge clk) begin
      if(reset) begin
	 master_write        <= 1'b0;
	 master_address      <= 0;
	 master_burstcount   <= 0;
	 internal_burstcount <= 0;
	 within_frame        <= 1'b0;
	 flushing_fifo       <= 1'b0;
      end
      else begin
	 if(master_write) begin
	    if(~master_waitrequest) begin
	       internal_burstcount <= internal_burstcount - 1;
	       if(internal_burstcount == 1) begin
		  master_write   <= 1'b0;
		  master_address <= master_address + (4 * `BURST_DEPTH);
	       end
	    end
	 end
	 else if(pfifo_usedw >= `BURST_DEPTH) begin
	    internal_burstcount <= `BURST_DEPTH;
	    master_burstcount   <= `BURST_DEPTH;
	    master_write        <= 1'b1;
	 end
	 else if(flushing_fifo & ~pfifo_empty) begin
	    internal_burstcount <= pfifo_usedw;
	    master_burstcount   <= pfifo_usedw;
	    master_write        <= 1'b1;
	 end
	 
	 if(frame_start) begin
	    within_frame   <= 1'b1;
	    flushing_fifo  <= 1'b0;
	    master_address <= current_frame;
	 end
	 else if(within_frame & din_valid & din_endofpacket) begin
	    within_frame  <= 1'b0;
	    flushing_fifo <= 1'b1;
	 end
	 else if(frame_end) begin
	    flushing_fifo <= 1'b0;
	 end
      end
   end
   
   //PIXEL FIFO
   scfifo
     #(
       .lpm_numwords       (`FIFO_DEPTH),
       .lpm_showahead      ("ON"),
       .lpm_type           ("scfifo"),
       .lpm_width          (24),
       .lpm_widthu         (`FIFO_DEPTH_BITS),
       .overflow_checking  ("OFF"),
       .underflow_checking ("OFF"),
       .use_eab            ("ON")
       )
   pfifo 
     (
      .clock (clk),
      .aclr  (1'b0),
      .sclr  (reset),
      .rdreq (pfifo_read),
      .wrreq (pfifo_write),
      .data  (pfifo_d),
      .q     (pfifo_q),
      .empty (pfifo_empty),
      .full  (pfifo_full),
      .usedw (pfifo_usedw)
      );
   
   
endmodule