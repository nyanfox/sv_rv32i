module ShiftRightAnri (i_a, i_b, o_data);

 input [31:0] i_a;
 input [4:0] i_b;
 output [31:0] o_data;
 
 wire [31:0] stage0, stage1, stage2, stage3;
 wire sign = i_a[31]; 

 assign stage0 = i_b[0] ? {sign, i_a[31:1]} : i_a;
 assign stage1 = i_b[1] ? {{2{sign}}, stage0[31:2]} : stage0;
 assign stage2 = i_b[2] ? {{4{sign}}, stage1[31:4]} : stage1;
 assign stage3 = i_b[3] ? {{8{sign}}, stage2[31:8]} : stage2;
 assign o_data = i_b[4] ? {{16{sign}}, stage3[31:16]} : stage3;

endmodule