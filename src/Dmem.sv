module Dmem (i_addr, i_data, i_funct3, i_read_en, i_clk, o_data);

 input [10:0] i_addr;
 input i_clk;
 input [7:0] i_data;
 input [2:0] i_funct3;
 input 
 output [7:0] o_data;
 
 reg [7:0] mem [2:2047];

 always @(posedge i_clk) begin

     

 end 



endmodule