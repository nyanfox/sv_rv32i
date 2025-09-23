module CLA32bit (i_a, i_b, i_cin, o_sum, o_cout);

 input i_cin;
 input [31:0] i_a, i_b;
 output [31:0] o_sum;
 output o_cout;
 
 wire ins_cla0_O_cout, ins_cla1_O_cout, ins_cla2_O_cout, ins_cla3_O_cout;
 wire ins_cla4_O_cout, ins_cla5_O_cout, ins_cla6_O_cout;
 
 CLA4bit ins_cla0 (.i_a(i_a[3:0]), .i_b(i_b[3:0]), .i_cin(i_cin), .o_sum(o_sum[3:0]), .o_cout(ins_cla0_O_cout));
 CLA4bit ins_cla1 (.i_a(i_a[7:4]), .i_b(i_b[7:4]), .i_cin(ins_cla0_O_cout), .o_sum(o_sum[7:4]), .o_cout(ins_cla1_O_cout));
 CLA4bit ins_cla2 (.i_a(i_a[11:8]), .i_b(i_b[11:8]), .i_cin(ins_cla1_O_cout), .o_sum(o_sum[11:8]), .o_cout(ins_cla2_O_cout));
 CLA4bit ins_cla3 (.i_a(i_a[15:12]), .i_b(i_b[15:12]), .i_cin(ins_cla2_O_cout), .o_sum(o_sum[15:12]), .o_cout(ins_cla3_O_cout));
 CLA4bit ins_cla4 (.i_a(i_a[19:16]), .i_b(i_b[19:16]), .i_cin(ins_cla3_O_cout), .o_sum(o_sum[19:16]), .o_cout(ins_cla4_O_cout));
 CLA4bit ins_cla5 (.i_a(i_a[23:20]), .i_b(i_b[23:20]), .i_cin(ins_cla4_O_cout), .o_sum(o_sum[23:20]), .o_cout(ins_cla5_O_cout));
 CLA4bit ins_cla6 (.i_a(i_a[27:24]), .i_b(i_b[27:24]), .i_cin(ins_cla5_O_cout), .o_sum(o_sum[27:24]), .o_cout(ins_cla6_O_cout));
 CLA4bit ins_cla7 (.i_a(i_a[31:27]), .i_b(i_b[31:27]), .i_cin(ins_cla6_O_cout), .o_sum(o_sum[31:27]), .o_cout(o_cout));

endmodule