module ProgramCounter (i_clk, i_reset, i_pc_next, o_next);

 input i_clk, i_reset;
 input [31:0] i_pc_next;
 output reg [31:0] o_next;
 
 always @(posedge i_clk) begin
  if(i_reset==1) begin
   o_next <= 31'h0000_0000;
  end
  else begin
      o_next <= i_pc_next;
  end
 
 end

endmodule