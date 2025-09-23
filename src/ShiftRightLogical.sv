module ShiftRightLogical (i_a, i_b, o_data);

 input [31:0] i_a;
 input [4:0] i_b;
 output [31:0] o_data;
 
 wire [31:0] stage0, stage1, stage2, stage3;

 assign stage0 = i_b[0] ? ({1'b0, i_a[31:1]}) : i_a;
 assign stage1 = i_b[1] ? ({2'b00, stage0[31:2]}) : stage0;
 assign stage2 = i_b[2] ? ({4'b0000, stage1[31:4]}) : stage1;
 assign stage3 = i_b[3] ? ({8'b0, stage2[31:8]}) : stage2;
 assign o_data = i_b[4] ? ({16'b0, stage3[31:16]}) : stage3;

endmodule