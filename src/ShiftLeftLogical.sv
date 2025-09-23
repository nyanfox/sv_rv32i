module ShiftLeftLogical (i_a, i_b, o_data);

 input [31:0] i_a;
 input [4:0] i_b;
 output [31:0] o_data;
 
 wire [31:0] stage0, stage1, stage2, stage3;
 
 assign stage0 = i_b[0] ? {i_a[30:0], 1'b0} : i_a;
 assign stage1 = i_b[1] ? {i_a[29:0], 2'b0} : stage0;
 assign stage2 = i_b[2] ? {i_a[27:0], 4'b0} : stage1;
 assign stage3 = i_b[3] ? {i_a[23:0], 8'b0} : stage2;
 assign o_data = i_b[4] ? {i_a[15:0], 16'b0} : stage3;


endmodule