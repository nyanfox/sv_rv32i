module Dmem (i_addr, i_data, i_funct3, i_write_en, i_clk, o_data);

 input [10:0] i_addr;
 input i_clk;
 input [31:0] i_data;
 input [2:0] i_funct3;
 input i_write_en;
 output reg [31:0] o_data;
 
 reg [7:0] mem [0:2047];
 
 localparam LB = 3'b000;
 localparam LH = 3'b001;
 localparam LW = 3'b010;
 localparam LBU = 3'b011;
 localparam LHU = 3'b100;
 
 localparam SB = 3'b000;
 localparam SH = 3'b001;
 localparam SW = 3'b010;

 always @(posedge i_clk) begin
  if (i_write_en) begin
   case (i_funct3)
    SB: begin
	     mem[i_addr] <= i_data[7:0];
	 end
	 SH: begin
	     mem[i_addr] <= i_data[7:0];
		  mem[i_addr+1] <= i_data[15:8];
	 end
	 SW: begin
	     mem[i_addr] <= i_data[7:0];
		  mem[i_addr+1] <= i_data[15:8];
		  mem[i_addr+2] <= i_data[23:16];
		  mem[i_addr+3] <= i_data[31:24];
	 end
	endcase
  end
 end
 
 always @(*) begin
  case (i_funct3)
   LBU:begin
	    o_data <= {24'b0,mem[i_addr]};
	end
	LHU: begin
	    o_data <= {16'b0,mem[i_addr+1],mem[i_addr]};
	end
	LW: begin
	    o_data <= {mem[i_addr+3], mem[i_addr+2], mem[i_addr+1], mem[i_addr]};
	end
	LB:begin
	    o_data <= {{24{mem[i_addr][7]}},mem[i_addr]};
	end
	LH: begin
	    o_data <= {{16{mem[i_addr+1][7]}},mem[i_addr+1],mem[i_addr]};
	end
	default: begin
	   o_data <= 0;
	end
  endcase  
 end

endmodule