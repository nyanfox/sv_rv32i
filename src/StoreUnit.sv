module StoreUnit (i_clk, i_funct3, i_lsu_addr, i_data, o_data_1, o_mask_1, o_trap);
 input i_clk;
 input [2:0] i_funct3;
 input [1:0] i_lsu_addr;
 input [31:0] i_data;
 output [31:0] o_data_1;
 output [3:0] o_mask_1;
 output reg o_trap;
 
 reg [31:0] o_data_1_r;
 reg [3:0] o_mask_1_r;
 localparam SB = 3'b000;
 localparam SH = 3'b001;
 localparam SW = 3'b010;
 
 assign o_data_1 = o_data_1_r;
 assign o_mask_1 = o_mask_1_r;
 
 always @(posedge i_clk) begin
  case (i_funct3)
   SB: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_mask_1_r <= 4'b1110;
		  o_data_1_r <= {24'b0, i_data[7:0]};	  
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_mask_1_r <= 4'b1101;
		  o_data_1_r <= {16'b0, i_data[7:0], 8'b0};
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_mask_1_r <= 4'b1011;
		  o_data_1_r <= {8'b0, i_data[7:0], 16'b0};
	 end
	 else begin
	     o_mask_1_r <= 4'b0111;
		  o_data_1_r <= {i_data[7:0], 24'b0};
	 end
	end
	
	SH: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_mask_1_r <= 4'b1100;
		  o_data_1_r <= {16'b0, i_data[15:0]};
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_mask_1_r <= 4'b0011;
		  o_data_1_r <= {i_data[15:0], 16'b0};
	 end
	 else begin
	   o_trap <= 1;
	 
	 end
	end
	
	SW: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_mask_1_r <= 4'b0000;
		  o_data_1_r <= i_data;
	 end
	 else begin
	    o_trap = 1;
		  
	 end
	end
	default:begin
	    o_mask_1_r <= 4'b0000;
		 o_data_1_r <= 0;
	end
  endcase
 end
 
 
endmodule