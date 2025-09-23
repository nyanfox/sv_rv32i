module Compa32bitSign (i_a,i_b, o_lt);

 input [31:0] i_a, i_b;
 output o_lt;
 
 wire ins_compa1_gt, ins_compa1_eq, ins_compa1_lt;
 
 
 assign o_lt = (i_a[31] & ~i_b[31]) | (i_a[31] & i_b[31] & ins_compa1_lt) | (~i_a[31] & ~i_b[31] & ins_compa1_lt);
 
 Compa32bitUnsign ins_compa1 (.i_a(i_a), .i_b(i_b), .o_gt(ins_compa1_gt), .o_eq(ins_compa1_eq), .o_lt(ins_compa1_lt));


endmodule