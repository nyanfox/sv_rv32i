module  SUB32bit (i_a, i_b, i_cin, o_sum, o_cout);
 
 input i_cin;
 input [31:0] i_a, i_b;
 output [31:0] o_sum;
 output o_cout;
 
 wire [31:0] i_b_not;
 wire [31:0] ins_cla_1_o_sum;
 wire ins_cla_1_o_cout;
 
 assign i_b_not = ~i_b;
 
 CLA32bit ins_cla_1 (.i_a(i_b_not), .i_b(1), .i_cin(0), .o_sum(ins_cla_1_o_sum), .o_cout(ins_cla_1_o_cout));
 CLA32bit ins_cla_2 (.i_a(i_a), .i_b(ins_cla_1_o_sum), .i_cin(0), .o_sum(o_sum), .o_cout(o_cout));
 
endmodule