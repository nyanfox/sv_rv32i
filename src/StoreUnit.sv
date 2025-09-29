module StoreUnit (i_clk, i_funct3, i_lsu_addr, i_data, o_data_1, o_data_2, o_mask_1, o_mask_2);
 input i_clk;
 input [2:0] i_funct3;
 input [1:0] i_lsu_addr;
 input [31:0] i_data;
 output [31:0] o_data_1, o_data_2, o_mask_1, o_mask_2;
 
 reg [31:0] o_data_1_r, o_data_2_r, o_mask_1_r, o_mask_2_r;
 
 localparam SB = 3'b000;
 localparam SH = 3'b001;
 localparam SW = 3'b010;
 
 assign o_data_1 = o_data_1_r;
 assign o_data_2 = o_data_2_r;
 assign o_mask_1 = o_mask_1_r;
 assign o_mask_2 = o_mask_2_r;

 
 always @(posedge i_clk) begin
  case (i_funct3)
   SB: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_mask_1_r <= 32'hFFFF_FF00;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {24'b0, i_data[7:0]};
		  o_data_2_r <= 0;
		  
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_mask_1_r <= 32'hFFFF_00FF;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {16'b0, i_data[7:0], 8'b0};
		  o_data_2_r <= 0;
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_mask_1_r <= 32'hFF00_FFFF;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {8'b0, i_data[7:0], 16'b0};
		  o_data_2_r <= 0;
	 end
	 else begin
	     o_mask_1_r <= 32'h00FF_FFFF;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {i_data[7:0], 24'b0};
		  o_data_2_r <= 0; 
	 end
	end
	
	SH: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_mask_1_r <= 32'hFFFF_0000;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {16'b0, i_data[15:0]};
		  o_data_2_r <= 0; 
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_mask_1_r <= 32'hFF00_00FF;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {8'b0, i_data[15:0], 8'b0};
		  o_data_2_r <= 0; 
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_mask_1_r <= 32'h0000_FFFF;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= {i_data[15:0], 16'b0};
		  o_data_2_r <= 0;
	 end
	 else begin
	     o_mask_1_r <= 32'h00FF_FFFF;
		  o_mask_2_r <= 32'hFFFF_FF00;
		  o_data_1_r <= {i_data[7:0], 24'b0};
		  o_data_2_r <= {24'b0, i_data[15:8]};
	 
	 end
	end
	
	SW: begin
	 if(i_lsu_addr == 2'b00) begin
	     o_mask_1_r <= 32'h0000_0000;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= i_data;
		  o_data_2_r <= 0; 
	 end
	 else if(i_lsu_addr == 2'b01) begin
	     o_mask_1_r <= 32'h0000_00FF;
		  o_mask_2_r <= 32'hFFFF_FF00;
		  o_data_1_r <= {i_data[23:0], 8'b0};
		  o_data_2_r <= {24'b0, i_data[31:24]};
		  
	 end
	 else if(i_lsu_addr == 2'b10) begin
	     o_mask_1_r <= 32'h0000_FFFF;
		  o_mask_2_r <= 32'hFFFF_0000;
		  o_data_1_r <= {i_data[15:0], 8'b0};
		  o_data_2_r <= {16'b0, i_data[31:16]};
	 end
	 else begin
	     o_mask_1_r <= 32'h00FF_FFFF;
		  o_mask_2_r <= 32'hFF00_0000;
		  o_data_1_r <= {i_data[7:0], 24'b0};
		  o_data_2_r <= {8'b0, i_data[31:8]};
		  
	 end
	end
	default:begin
	    o_mask_1_r <= 32'hFFFF_FFFF;
		  o_mask_2_r <= 32'hFFFF_FFFF;
		  o_data_1_r <= 0;
		  o_data_2_r <= 0;
	end
  endcase
 end
 
 
endmodule