
import definitions::*;
module tb_part1_2();

	logic clock, reset;
	opcode opcode_ep;
	logic ls_wr_en_op_in;
	logic [0:6] I7_ep;
	logic [0:9] I10_ep;
	logic [0:15]I16_ep;
	logic [0:17]I18_ep;
	logic wr_en_rt_ep;
	opcode opcode_op;
	logic [0:6] I7_op;
	logic [0:9] I10_op;
	logic [0:15]I16_op;
	logic [0:17]I18_op;
	logic wr_en_rt_op;
	logic [0:31] pc_in;
	logic [0:6] ra_addr_ep;
	logic [0:6] rb_addr_ep;
	logic [0:6] rc_addr_ep;
	logic [0:6] rt_addr_ep;
	logic [0:6] ra_addr_op;
	logic [0:6] rb_addr_op,rc_addr_op;
	logic [0:6] rt_addr_op;
	logic [0:31] pc_out;
	logic [0:91] instr[304];
	logic [0:31] pc_i;
	logic ep_op_1, br_1, ep_op_2, br_2;
	logic [0:31] temp_32;
	logic flush;
	logic clear;
	
	//Debug
	logic [0:127]reg_file_mem [128];
	logic [0:7] ls_mem [LS_SIZE];
	logic [0:127] out_ep_rt_data,out_op_rt_data; //DRO
	logic [0:127] ls_data_rd_in,ls_data_out; // DRO
	logic [0:14]  ls_addr_rd_out; //DRO
	logic [0:6] out_ep_rt_addr,out_op_rt_addr; // DRO
	logic [0:31] rep_left_Bit_32_I10;
	logic [0:127] ra_rf_data_ep, rb_rf_data_ep, rc_rf_data_ep, ra_rf_data_op, rb_rf_data_op,rc_rf_data_op;
	logic [0:127] ra_fw_data_ep, rb_fw_data_ep, rc_fw_data_ep, ra_fw_data_op, rb_fw_data_op,rc_fw_data_op; //DRO
	logic [0:3] fw_uid_op_02, fw_uid_op_03, fw_uid_op_04, fw_uid_op_05, fw_uid_op_06, fw_uid_op_07; //DRO
	logic [0:3] fw_uid_ep_02, fw_uid_ep_03, fw_uid_ep_04, fw_uid_ep_05, fw_uid_ep_06, fw_uid_ep_07; //DRO
	logic [0:127] fw_ep_02_data, fw_ep_03_data, fw_ep_04_data, fw_ep_05_data, fw_ep_06_data, fw_ep_07_data; //DRO
	logic [0:6] fw_ep_02_addr, fw_ep_03_addr, fw_ep_04_addr, fw_ep_05_addr, fw_ep_06_addr, fw_ep_07_addr; //DRO
	logic [0:127] fw_op_02_data, fw_op_03_data, fw_op_04_data, fw_op_05_data, fw_op_06_data, fw_op_07_data; //DRO
	logic [0:6] fw_op_02_addr, fw_op_03_addr, fw_op_04_addr, fw_op_05_addr, fw_op_06_addr, fw_op_07_addr; //DRO
	logic out_ep_wr_en_rt, out_op_wr_en_rt; //DRO
	

   topmodule_part1 dut(.clock(clock),
					   .reset(reset),
					   .opcode_ep(opcode_ep),
					   .I7_ep(I7_ep),
					   .I10_ep(I10_ep),
					   .I16_ep(I16_ep),
					   .I18_ep(I18_ep),
					   .wr_en_rt_ep(wr_en_rt_ep),
					   .opcode_op(opcode_op),
					   .I7_op(I7_op),
					   .I10_op(I10_op),
					   .I16_op(I16_op),
					   .I18_op(I18_op),
					   .wr_en_rt_op(wr_en_rt_op),
					   .pc_in(pc_in),
					   .pc_out(pc_out),
					   .ra_addr_ep(ra_addr_ep),
					   .rb_addr_ep(rb_addr_ep),
					   .rc_addr_ep(rc_addr_ep),
					   .rt_addr_ep(rt_addr_ep),
					   .ra_addr_op(ra_addr_op),
					   .rb_addr_op(rb_addr_op),
					   .rc_addr_op(rc_addr_op),
					   .rt_addr_op(rt_addr_op),
					   .ls_wr_en_op_in(ls_wr_en_op_in),
					   .reg_file_mem(reg_file_mem),
					   .flush(flush),
					   .clear(clear),
					   
					   
					   //Debug
					   .ls_mem(ls_mem),
					   .out_ep_rt_data(out_ep_rt_data),
					   .out_op_rt_data(out_op_rt_data),
					   .ls_data_rd_in(ls_data_rd_in),
					   .ls_data_out(ls_data_out),
					   .ls_addr_rd_out(ls_addr_rd_out),
					   .out_ep_rt_addr(out_ep_rt_addr),
					   .out_op_rt_addr(out_op_rt_addr),
					   .rep_left_Bit_32_I10(rep_left_Bit_32_I10),
					   .ra_rf_data_ep(ra_rf_data_ep), 
					   .rb_rf_data_ep(rb_rf_data_ep), 
					   .rc_rf_data_ep(rc_rf_data_ep), 
					   .ra_rf_data_op(ra_rf_data_op), 
					   .rb_rf_data_op(rb_rf_data_op),
					   .rc_rf_data_op(rc_rf_data_op),
					   .ra_fw_data_ep(ra_fw_data_ep), 
					   .rb_fw_data_ep(rb_fw_data_ep), 
					   .rc_fw_data_ep(rc_fw_data_ep), 
					   .ra_fw_data_op(ra_fw_data_op), 
					   .rb_fw_data_op(rb_fw_data_op),
					   .rc_fw_data_op(rc_fw_data_op),
					   .fw_uid_op_02(fw_uid_op_02),
					   .fw_uid_op_03(fw_uid_op_03),
					   .fw_uid_op_04(fw_uid_op_04),
					   .fw_uid_op_05(fw_uid_op_05), 
					   .fw_uid_op_06(fw_uid_op_06), 
					   .fw_uid_op_07(fw_uid_op_07),
					   .fw_uid_ep_02(fw_uid_ep_02), 
					   .fw_uid_ep_03(fw_uid_ep_03), 
					   .fw_uid_ep_04(fw_uid_ep_04), 
					   .fw_uid_ep_05(fw_uid_ep_05), 
					   .fw_uid_ep_06(fw_uid_ep_06), 
					   .fw_uid_ep_07(fw_uid_ep_07),
					   .fw_ep_02_data(fw_ep_02_data), 
					   .fw_ep_03_data(fw_ep_03_data), 
					   .fw_ep_04_data(fw_ep_04_data), 
					   .fw_ep_05_data(fw_ep_05_data), 
					   .fw_ep_06_data(fw_ep_06_data), 
					   .fw_ep_07_data(fw_ep_07_data),
					   .fw_ep_02_addr(fw_ep_02_addr), 
					   .fw_ep_03_addr(fw_ep_03_addr), 
					   .fw_ep_04_addr(fw_ep_04_addr), 
					   .fw_ep_05_addr(fw_ep_05_addr), 
					   .fw_ep_06_addr(fw_ep_06_addr), 
					   .fw_ep_07_addr(fw_ep_07_addr),
					   .fw_op_02_data(fw_op_02_data), 
					   .fw_op_03_data(fw_op_03_data), 
					   .fw_op_04_data(fw_op_04_data), 
					   .fw_op_05_data(fw_op_05_data), 
					   .fw_op_06_data(fw_op_06_data), 
					   .fw_op_07_data(fw_op_07_data),
					   .fw_op_02_addr(fw_op_02_addr), 
					   .fw_op_03_addr(fw_op_03_addr), 
					   .fw_op_04_addr(fw_op_04_addr), 
					   .fw_op_05_addr(fw_op_05_addr), 
					   .fw_op_06_addr(fw_op_06_addr), 
					   .fw_op_07_addr(fw_op_07_addr),
					   .out_ep_wr_en_rt(out_ep_wr_en_rt), 
					   .out_op_wr_en_rt(out_op_wr_en_rt));
   

   initial clock = 0;
   always #5 clock = ~clock;


	initial begin
		
		// Before first clock edge, initialize
		reset = 1;
		@(posedge clock);
		reset = 0;
		@(posedge clock);
		//Load RA (addr1 of reg file)
		opcode_op = LOAD_QUADWORD_DFORM;
		I10_op = 10'd7;
		wr_en_rt_op = 1;
		pc_in = 0;
		ra_addr_op = 7'd0;
		rt_addr_op = 7'd1;
		
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
			
		
		
		@(posedge clock);
		//Load RB (addr2 of reg file)
		opcode_op = LOAD_QUADWORD_DFORM;
		I10_op = 10'd8;
		wr_en_rt_op = 1;
		pc_in = 0;
		ra_addr_op = 7'd0;
		rt_addr_op = 7'd2;
		
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		
		@(posedge clock);//give 9 cycles for the data to be loaded into reg file and then use those values in instructions if needed
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
	
		@(posedge clock);	
		
		
		
		
		//tb cases by lahari
		
		//Prereq:
			//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//SHIFT_LEFT_HALFWORD(EVEN)
			opcode_ep = SHIFT_LEFT_HALFWORD;
			ra_addr_ep = 7'd1;
			rb_addr_ep = 7'd2;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd3; //store data to address 3 of RF
				
			//2nd instruction: needs ra,rb,rt addr as inputs and wr_en_rt_op is 1
			//SHIFT_LEFT_QUADWORD_BY_BITS(ODD)
			opcode_op = SHIFT_LEFT_QUADWORD_BY_BITS;
			ra_addr_op = 7'd1;
			rb_addr_op = 7'd2;
			wr_en_rt_op = 1;
			rt_addr_op = 7'd4; //store data to address 4 of RF
			//wait for RF to get updated
			@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
	
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);	
	
			//1st instruction: needs ra,I7,rt addr as inputs and wr_en_rt_ep is 1
			//SHIFT_LEFT_HALFWORD_IMMEDIATE(EVEN)
			opcode_ep = SHIFT_LEFT_HALFWORD_IMMEDIATE;
			ra_addr_ep = 7'd3;
			I7_ep = 7'd4;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd5; //store data to address 5 of RF
				
			//2nd instruction: needs ra,I7,rt addr as inputs and wr_en_rt_op is 1
			//SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE(ODD)
			opcode_op = SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE;
			ra_addr_op = 7'd4;
			I7_op = 7'd4;
			wr_en_rt_op = 1;
			rt_addr_op = 7'd6; //store data to address 6 of RF
			//wait for RF to get updated
			@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		
		@(posedge clock);	

		//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//SHIFT_LEFT_WORD(EVEN)
			opcode_ep = SHIFT_LEFT_WORD;
			ra_addr_ep = 7'd5;
			rb_addr_ep = 7'd6;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd7; //store data to address 7 of RF
				
			//2nd instruction: needs ra,rb,rt addr as inputs and wr_en_rt_op is 1
			//SHIFT_LEFT_QUADWORD_BY_BYTES(ODD)
			opcode_op = SHIFT_LEFT_QUADWORD_BY_BYTES;
			ra_addr_op = 7'd4;
			rb_addr_op = 7'd5;
			wr_en_rt_op = 1;
			rt_addr_op = 7'd8; //store data to address 8 of RF
			
		@(posedge clock);
		
		//1st instruction: needs ra,I7,rt addr as inputs and wr_en_rt_ep is 1
			//SHIFT_LEFT_WORD_IMMEDIATE(EVEN)
			opcode_ep = SHIFT_LEFT_WORD_IMMEDIATE;
			ra_addr_ep = 7'd5;
			I7_ep  = 7'd9;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd9; //store data to address 9 of RF
				
			//2nd instruction: needs ra,I7,rt addr as inputs and wr_en_rt_op is 1
			//SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE(ODD)
			opcode_op = SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE;
			ra_addr_op = 7'd4;
			I7_op  = 7'd6;
			wr_en_rt_op = 1;
			rt_addr_op = 7'd10; //store data to address 10 of RF
			
			@(posedge clock);
		
		//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//ROTATE_HALFWORD(EVEN)
			opcode_ep = ROTATE_HALFWORD;
			ra_addr_ep = 7'd6;
			rb_addr_ep = 7'd6;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd11; //store data to address 11 of RF
				
			//2nd instruction: needs ra,rb,rt addr as inputs and wr_en_rt_op is 1
			//ROTATE_QUADWORD_BY_BYTES(ODD)
			opcode_op = ROTATE_QUADWORD_BY_BYTES;
			ra_addr_op = 7'd5;
			rb_addr_op = 7'd2;
			wr_en_rt_op = 1;
			rt_addr_op = 7'd12; //store data to address 12 of RF
			
			@(posedge clock);
			
		//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//ROTATE_HALFWORD_IMMEDIATE(EVEN)
			opcode_ep = ROTATE_HALFWORD_IMMEDIATE;
			ra_addr_ep = 7'd1;
			I7_ep = 7'd6;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd13; //store data to address 13 of RF
				
			//2nd instruction: needs ra,rb,rt addr as inputs and wr_en_rt_op is 1
			//ROTATE_QUADWORD_BY_BYTES_IMMEDIATE(ODD)
			opcode_op = ROTATE_QUADWORD_BY_BYTES_IMMEDIATE;
			ra_addr_op = 7'd3;
			I7_ep = 7'd7;
			wr_en_rt_op = 1;
			rt_addr_op = 7'd14; //store data to address 14 of RF
			
			
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		
		//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//ROTATE_WORD(EVEN)
			opcode_ep = ROTATE_WORD;
			ra_addr_ep = 7'd7;
			rb_addr_op = 7'd8;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd15; //store data to address 15 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//ROTATE_WORD_IMMEDIATE(EVEN)
			opcode_ep = ROTATE_WORD_IMMEDIATE;
			ra_addr_ep = 7'd7;
			I7_ep = 7'd5;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd16; //store data to address 16 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction: needs ra,rb,rt addr as inputs and wr_en_rt_ep is 1
			//ROTATE_AND_MASK_HALFWORD(EVEN)
			opcode_ep = ROTATE_AND_MASK_HALFWORD;
			ra_addr_ep = 7'd9;
			rb_addr_op = 7'd10;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd17; //store data to address 17 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction: needs ra,I7,rt addr as inputs and wr_en_rt_ep is 1
			//ROTATE_AND_MASK_HALFWORD_IMMEDIATE(EVEN)
			opcode_ep = ROTATE_AND_MASK_HALFWORD_IMMEDIATE;
			ra_addr_ep = 7'd9;
			I7_ep = 7'd23;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd18; //store data to address 18 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction:  needs ra, rt addr as inputs and wr_en_rt_ep is 1
			//COUNT_ONES_IN_BYTES(EVEN)
			opcode_ep = COUNT_ONES_IN_BYTES;
			ra_addr_ep = 7'd9;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd19; //store data to address 19 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//AVERAGE_BYTES(EVEN)
			opcode_ep = AVERAGE_BYTES;
			ra_addr_ep = 7'd5;
			rb_addr_ep = 7'd6;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd20; //store data to address 20 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//ABSOLUTE_DIFFERENCE_OF_BYTES(EVEN)
			opcode_ep = ABSOLUTE_DIFFERENCE_OF_BYTES;
			ra_addr_ep = 7'd5;
			rb_addr_ep = 7'd8;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd21; //store data to address 21 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//SUM_BYTES_INTO_HALFWORDS(EVEN)
			opcode_ep = SUM_BYTES_INTO_HALFWORDS;
			ra_addr_ep = 7'd5;
			rb_addr_ep = 7'd8;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd22; //store data to address 22 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//COMPARE_EQUAL_HALFWORD(EVEN)
			opcode_ep = COMPARE_EQUAL_HALFWORD;
			ra_addr_ep = 7'd5;
			rb_addr_ep = 7'd8;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd23; //store data to address 23 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra, rt addr & I10 as inputs and wr_en_rt_ep is 1
			//COMPARE_EQUAL_HALFWORD_IMMEDIATE(EVEN)
			opcode_ep = COMPARE_EQUAL_HALFWORD_IMMEDIATE;
			ra_addr_ep = 7'd2;
			I10_ep = 10'd4;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd24; //store data to address 24 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
		
		@(posedge clock);
		
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//COMPARE_EQUAL_WORD(EVEN)
			opcode_ep = COMPARE_EQUAL_WORD;
			ra_addr_ep = 7'd4;
			rb_addr_ep = 7'd5;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd25; //store data to address 25 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra, rt addr & I10 as inputs and wr_en_rt_ep is 1
			//COMPARE_EQUAL_WORD_IMMEDIATE(EVEN)
			opcode_ep = COMPARE_EQUAL_WORD_IMMEDIATE;
			ra_addr_ep = 7'd10;
			I10_ep = 10'd0;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd26; //store data to address 26 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
		
		@(posedge clock);
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//COMPARE_GREATER_THAN_HALFWORD(EVEN)
			opcode_ep = COMPARE_GREATER_THAN_HALFWORD;
			ra_addr_ep = 7'd11;
			rb_addr_ep = 7'd15;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd27; //store data to address 27 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra, rt addr & I10 as inputs and wr_en_rt_ep is 1
			//COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE(EVEN)
			opcode_ep = COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE;
			ra_addr_ep = 7'd5;
			I10_ep = 10'd500;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd28; //store data to address 28 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
		
		@(posedge clock);
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//COMPARE_GREATER_THAN_WORD(EVEN)
			opcode_ep = COMPARE_GREATER_THAN_WORD;
			ra_addr_ep = 7'd11;
			rb_addr_ep = 7'd16;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd29; //store data to address 29 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
		
		@(posedge clock);
		//1st instruction:  needs ra, rt addr & I10 as inputs and wr_en_rt_ep is 1
			//COMPARE_GREATER_THAN_WORD_IMMEDIATE(EVEN)
			opcode_ep = COMPARE_GREATER_THAN_WORD_IMMEDIATE;
			ra_addr_ep = 7'd18;
			I10_ep = 10'd400;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd30; //store data to address 30 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
		
			
		@(posedge clock);
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//COMPARE_LOGICAL_GREATER_THAN_WORD(EVEN)
			opcode_ep = COMPARE_LOGICAL_GREATER_THAN_WORD;
			ra_addr_ep = 7'd8;
			rb_addr_ep = 7'd9;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd31; //store data to address 31 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
		
		@(posedge clock);
		//1st instruction:  needs ra, rt addr & I10 as inputs and wr_en_rt_ep is 1
			//COMPARE_LOGICAL_GREATER_THAN_WORD_IMMEDIATE(EVEN)
			opcode_ep = COMPARE_LOGICAL_GREATER_THAN_WORD_IMMEDIATE;
			ra_addr_ep = 7'd18;
			I10_ep = 10'd400;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd32; //store data to address 32 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//COMPARE_LOGICAL_GREATER_THAN_HALFWORD(EVEN)
			opcode_ep = COMPARE_LOGICAL_GREATER_THAN_HALFWORD;
			ra_addr_ep = 7'd19;
			rb_addr_ep = 7'd18;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd33; //store data to address 33 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra, rt addr & I10 as inputs and wr_en_rt_ep is 1
			//COMPARE_LOGICAL_GREATER_THAN_HALFWORD_IMMEDIATE(EVEN)
			opcode_ep = COMPARE_LOGICAL_GREATER_THAN_HALFWORD_IMMEDIATE;
			ra_addr_ep = 7'd19;
			I10_ep = 10'd40;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd34; //store data to address 34 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//CARRY_GENERATE(EVEN)
			opcode_ep = CARRY_GENERATE;
			ra_addr_ep = 7'd12;
			rb_addr_ep = 7'd21;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd35; //store data to address 35 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra,rb,rc, rt addr as inputs and wr_en_rt_ep is 1
			//ADD_EXTENDED(EVEN)
			opcode_ep = ADD_EXTENDED;
			ra_addr_ep = 7'd22;
			rb_addr_ep = 7'd21;
			rc_addr_ep = 7'd20;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd36; //store data to address 36 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		@(posedge clock);
		//1st instruction:  needs ra,rb rt addr as inputs and wr_en_rt_ep is 1
			//BORROW_GENERATE(EVEN)
			opcode_ep = BORROW_GENERATE;
			ra_addr_ep = 7'd24;
			rb_addr_ep = 7'd23;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd37; //store data to address 37 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		
		
		@(posedge clock);
		//1st instruction:  needs ra,rb,rc, rt addr as inputs and wr_en_rt_ep is 1
			//SUBTRACT_FROM_EXTENDED(EVEN)
			opcode_ep = SUBTRACT_FROM_EXTENDED;
			ra_addr_ep = 7'd7;
			rb_addr_ep = 7'd8;
			rc_addr_ep = 7'd25;
			wr_en_rt_ep = 1;
			rt_addr_ep = 7'd38; //store data to address 38 of RF
		//2nd instr is NOP for odd
			opcode_op = NOP_EXEC;
			rt_addr_op = 7'd0;
			wr_en_rt_op = 0;
			
		
			
		
			
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		
		@(posedge clock);
		opcode_op = NOP_EXEC;
		rt_addr_op = 7'd0;
		wr_en_rt_op = 0;
		opcode_ep = NOP_EXEC;
		rt_addr_ep = 7'd0;
		wr_en_rt_ep = 0;
		

		$readmemb("instructions", instr);
		pc_in = 32'd0;
		pc_i = 32'd0;
		
		
		while(pc_in < 32'd301) begin
				pc_in 		= pc_i;
				pc_i 		= pc_in + 32'd8;
				ep_op_1	   = instr[pc_in][90];
				br_1         = instr[pc_in][91];
				ep_op_2	   = instr[4+pc_in][90];
				br_2         = instr[4+pc_in][91];
				
				$display($time,"pc_in is %d", pc_in);
				if(ep_op_1 == 1 && ep_op_2 == 0) begin  //if instr1 is odd and instr2 is even 
					@(posedge clock);
						if(br_1 == 1) clear = 1;
						else clear = 0;
						ra_addr_op = instr[pc_in][0:6];
						rb_addr_op = instr[pc_in][7:13];
						rc_addr_op = instr[pc_in][14:20];
						rt_addr_op = instr[pc_in][21:27];
						I7_op     = instr[pc_in][28:34];
						I10_op     = instr[pc_in][35:44];
						I16_op     = instr[pc_in][44:60];
						I18_op     = instr[pc_in][61:78];
						opcode_op  = opcode'(instr[pc_in][79:89]);
						if(opcode_op == NOP_EXEC || opcode_op == STORE_QUADWORD_DFORM || opcode_op == STORE_QUADWORD_AFORM ) wr_en_rt_op = 0;
						else wr_en_rt_op = 1;
						
						ra_addr_ep = instr[4+pc_in][0:6];
						rb_addr_ep = instr[4+pc_in][7:13];
						rc_addr_ep = instr[4+pc_in][14:20];
						rt_addr_ep = instr[4+pc_in][21:27];
						I7_ep     = instr[4+pc_in][28:34];
						I10_ep     = instr[4+pc_in][35:44];
						I16_ep     = instr[4+pc_in][44:60];
						I18_ep     = instr[4+pc_in][61:78];
						opcode_ep  = opcode'(instr[4+pc_in][79:89]);
						if(opcode_op == NOP_EXEC) wr_en_rt_ep = 0;
						else wr_en_rt_ep = 1;
						
						//pc_i = pc_in + 32'd8;
						temp_32 = pc_out;
						if(temp_32 > 0) begin
							pc_i = temp_32;
						end
						
				end	
				else if(ep_op_1 == 0 && ep_op_2 == 1) begin  //if instr1 is even and instr2 is odd 
					@(posedge clock);
						if(br_1 == 1) clear = 1;
						else clear = 0;
						ra_addr_ep = instr[pc_in][0:6];
						rb_addr_ep = instr[pc_in][7:13];
						rc_addr_ep = instr[pc_in][14:20];
						rt_addr_ep = instr[pc_in][21:27];
						I7_ep     = instr[pc_in][28:34];
						I10_ep     = instr[pc_in][35:44];
						I16_ep     = instr[pc_in][44:60];
						I18_ep     = instr[pc_in][61:78];
						opcode_ep  = opcode'(instr[pc_in][79:89]);
						if(opcode_op == NOP_EXEC) wr_en_rt_ep = 0;
						else wr_en_rt_ep = 1;
						
						
						ra_addr_op = instr[4+pc_in][0:6];
						rb_addr_op = instr[4+pc_in][7:13];
						rc_addr_op = instr[4+pc_in][14:20];
						rt_addr_op = instr[4+pc_in][21:27];
						I7_op     = instr[4+pc_in][28:34];
						I10_op     = instr[4+pc_in][35:44];
						I16_op     = instr[4+pc_in][44:60];
						I18_op     = instr[4+pc_in][61:78];
						opcode_op  = opcode'(instr[4+pc_in][79:89]);
						if(opcode_op == NOP_EXEC || opcode_op == STORE_QUADWORD_DFORM || opcode_op == STORE_QUADWORD_AFORM ) wr_en_rt_op = 0;
						else wr_en_rt_op = 1;
						
						//pc_i = pc_in + 32'd8;
						temp_32 = pc_out;
						if(temp_32 > 0) begin
							pc_i = temp_32;
						end
				end		
				else if(ep_op_1 == 1 && ep_op_2 == 1) begin  //if instr1 is odd and instr2 is odd 
					@(posedge clock);
						if(br_1 == 1) clear = 1;
						else clear = 0;
						ra_addr_op = instr[pc_in][0:6];
						rb_addr_op = instr[pc_in][7:13];
						rc_addr_op = instr[pc_in][14:20];
						rt_addr_op = instr[pc_in][21:27];
						I7_op     = instr[pc_in][28:34];
						I10_op     = instr[pc_in][35:44];
						I16_op     = instr[pc_in][44:60];
						I18_op     = instr[pc_in][61:78];
						opcode_op  = opcode'(instr[pc_in][79:89]);
						if(opcode_op == NOP_EXEC || opcode_op == STORE_QUADWORD_DFORM || opcode_op == STORE_QUADWORD_AFORM ) wr_en_rt_op = 0;
						else wr_en_rt_op = 1;
						
						opcode_ep = NOP_EXEC;
						rt_addr_ep = 7'd0;
						wr_en_rt_ep = 0;
						
						temp_32 = pc_out;
						if(temp_32 > 0) begin
							pc_i = temp_32;
						end
					@(posedge clock);
						if(br_1 == 1) clear = 1;
						else clear = 0;
						ra_addr_op = instr[4+pc_in][0:6];
						rb_addr_op = instr[4+pc_in][7:13];
						rc_addr_op = instr[4+pc_in][14:20];
						rt_addr_op = instr[4+pc_in][21:27];
						I7_op     = instr[4+pc_in][28:34];
						I10_op     = instr[4+pc_in][35:44];
						I16_op     = instr[4+pc_in][44:60];
						I18_op     = instr[4+pc_in][61:78];
						opcode_op  = opcode'(instr[4+pc_in][79:89]);
						if(opcode_op == NOP_EXEC || opcode_op == STORE_QUADWORD_DFORM || opcode_op == STORE_QUADWORD_AFORM ) wr_en_rt_op = 0;
						else wr_en_rt_op = 1;
						
						opcode_ep = NOP_EXEC;
						rt_addr_ep = 7'd0;
						wr_en_rt_ep = 0;
						
						//pc_i = pc_in + 32'd8;
						temp_32 = pc_out;
						if(temp_32 > 0) begin
							pc_i = temp_32;
						end
				end		
				else begin  //if instr1 is even and instr2 is even 
					@(posedge clock);
						if(br_1 == 1) clear = 1;
						else clear = 0;
						ra_addr_ep = instr[pc_in][0:6];
						rb_addr_ep = instr[pc_in][7:13];
						rc_addr_ep = instr[pc_in][14:20];
						rt_addr_ep = instr[pc_in][21:27];
						I7_ep     = instr[pc_in][28:34];
						I10_ep     = instr[pc_in][35:44];
						I16_ep     = instr[pc_in][44:60];
						I18_ep     = instr[pc_in][61:78];
						opcode_ep  = opcode'(instr[pc_in][79:89]);
						if(opcode_op == NOP_EXEC) wr_en_rt_ep = 0;
						else wr_en_rt_ep = 1;
						
						opcode_op = NOP_EXEC;
						rt_addr_op = 7'd0;
						wr_en_rt_op = 0;
						
						temp_32 = pc_out;
						if(temp_32 > 0) begin
							pc_i = temp_32;
						end
					@(posedge clock);
						if(br_1 == 1) clear = 1;
						else clear = 0;
						ra_addr_ep = instr[4+pc_in][0:6];
						rb_addr_ep = instr[4+pc_in][7:13];
						rc_addr_ep = instr[4+pc_in][14:20];
						rt_addr_ep = instr[4+pc_in][21:27];
						I7_ep     = instr[4+pc_in][28:34];
						I10_ep     = instr[4+pc_in][35:44];
						I16_ep     = instr[4+pc_in][44:60];
						I18_ep     = instr[4+pc_in][61:78];
						opcode_ep  = opcode'(instr[4+pc_in][79:89]);
						if(opcode_op == NOP_EXEC) wr_en_rt_ep = 0;
						else wr_en_rt_ep = 1;
						
						opcode_op = NOP_EXEC;
						rt_addr_op = 7'd0;
						wr_en_rt_op = 0;
						
						//pc_i = pc_in + 32'd8;
						temp_32 = pc_out;
						if(temp_32 > 0) begin
							pc_i = temp_32;
						end
				end		
		end
      #20;
      $finish;
   end 
endmodule 