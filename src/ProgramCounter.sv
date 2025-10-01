module ProgramCounter (i_clk, i_reset, i_wb, i_pc_sel, i_pc_4, o_next);

 input i_clk, i_reset, i_pc_sel;
 input [31:0] i_wb;
 input [31:0] i_pc_4;
 output reg [31:0] o_next;
 
 always @(posedge i_clk) begin
  if (i_reset) begin
      o_next <= 32'h0000_0000;
  end
  else begin
   if (i_pc_sel==1'b0) begin
	    o_next <= i_pc_4 + 1;
	end
	else begin
	    o_next <= i_wb;
	end
  end
 end


endmodule