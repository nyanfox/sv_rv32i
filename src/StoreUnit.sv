module StoreUnit (i_funct3, i_lsu_addr, i_mem1, i_mem2, i_data, o_data_1, o_data_2);

 input [2:0] i_funct3;
 input [1:0] i_lsu_addr;
 input [31:0] i_mem1, i_mem2, i_data;
 output [31:0] o_data_1, o_data_2;
 
 reg [31:0] o_data_1_r, o_data_2_r;
 
 localparam SB = 3'b000;
 localparam SH = 3'b001;
 localparam SW = 3'b010;
 
 assign o_data_1 = o_data_1_r;
 assign o_data_2 = o_data_2_r;
 
 always @(*) begin
  case (i_funct3)
   SB: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_data_1_r[31:8] = i_mem1[31:8];
		  o_data_1_r[7:0] = i_data[7:0]; 
		  o_data_2_r = i_mem2;
		  
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_data_1_r[31:16] = i_mem1[31:16];
		  o_data_1_r[15:8] = i_data[7:0]; 
		  o_data_1_r[7:0] = i_mem1[7:0];
		  o_data_2_r = i_mem2;
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_data_1_r[31:24] = i_mem1[31:24];
		  o_data_1_r[23:16] = i_data[7:0]; 
		  o_data_1_r[15:0] = i_mem1[15:0];
		  o_data_2_r = i_mem2;
	 end
	 else begin
	     o_data_1_r[23:0] = i_mem1[23:0];
		  o_data_1_r[31:24] = i_data[7:0];
		  o_data_2_r = i_mem2; 
	 end
	end
	
	SH: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_data_1_r[31:16] = i_mem1[31:16];
		  o_data_1_r[15:0] = i_data[15:0]; 
		  o_data_2_r = i_mem2;
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_data_1_r[31:24] = i_mem1[31:24];
		  o_data_1_r[23:8] = i_data[15:0];
		  o_data_1_r[7:0] = i_data[7:0]; 
		  o_data_2_r = i_mem2;
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_data_1_r[15:0] = i_mem1[15:0];
		  o_data_1_r[31:16] = i_data[15:0];
		  o_data_2_r = i_mem2;
	 end
	 else begin
	     o_data_1_r[23:0] = i_mem1[23:0];
		  o_data_1_r[31:24] = i_data[7:0];
		  o_data_2_r[7:0] = i_data[15:8];
		  o_data_2_r[31:8] = i_mem2[31:8];
	 
	 end
	end
	
	SW: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_data_1_r = i_data;
		  o_data_2_r = i_mem2;
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_data_1_r[7:0] = i_mem1[7:0];
		  o_data_1_r[31:8] = i_data[23:0];
		  o_data_2_r[7:0] = i_data[31:24];
		  o_data_2_r[31:8] = i_mem2[31:8];
		  
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_data_1_r[15:0] = i_mem1[15:0];
		  o_data_1_r[31:16] = i_data[15:0];
		  o_data_2_r[15:0] = i_data[31:16];
		  o_data_2_r[31:16] = i_mem2[31:16];
	 end
	 else begin
	     o_data_1_r[23:0] = i_mem1[23:0];
		  o_data_1_r[31:24] = i_data[7:0];
		  o_data_2_r[23:0] = i_data[31:8];
		  o_data_2_r[31:24] = i_mem2[31:24];
		  
	 end
	end
	default:begin
	    o_data_1_r = i_mem1;
		 o_data_2_r = i_mem2;
	end
  endcase
 end
 
 
endmodule