module Compa32bitUnsign(i_a, i_b, o_gt, o_eq, o_lt);

 input [31:0] i_a, i_b;
 output o_lt, o_eq, o_gt;
 
 wire lt0, lt1, lt2, lt3, lt4, lt5, lt6;
 wire gt0, gt1, gt2, gt3, gt4, gt5, gt6;
 wire eq0, eq1, eq2, eq3, eq4, eq5, eq6;
 
 Comapa4bitUnsign ins_compa_0 (.i_a(i_a[3:0]), .i_b(i_b[3:0]), .i_gt(0), .i_eq(1), .i_lt(0), .o_gt(gt0), .o_eq(eq0), .o_lt(lt0));
 Comapa4bitUnsign ins_compa_1 (.i_a(i_a[7:4]), .i_b(i_b[7:4]), .i_gt(gt0), .i_eq(eq0), .i_lt(lt0), .o_gt(gt1), .o_eq(eq1), .o_lt(lt1));
 Comapa4bitUnsign ins_compa_2 (.i_a(i_a[11:8]), .i_b(i_b[11:8]), .i_gt(gt1), .i_eq(eq1), .i_lt(lt1), .o_gt(gt2), .o_eq(eq2), .o_lt(lt2));
 Comapa4bitUnsign ins_compa_3 (.i_a(i_a[15:12]), .i_b(i_b[15:12]), .i_gt(gt2), .i_eq(eq2), .i_lt(lt2), .o_gt(gt3), .o_eq(eq3), .o_lt(lt3));
 Comapa4bitUnsign ins_compa_4 (.i_a(i_a[19:16]), .i_b(i_b[19:16]), .i_gt(gt3), .i_eq(eq3), .i_lt(lt3), .o_gt(gt4), .o_eq(eq4), .o_lt(lt4));
 Comapa4bitUnsign ins_compa_5 (.i_a(i_a[23:20]), .i_b(i_b[23:20]), .i_gt(gt4), .i_eq(eq4), .i_lt(lt4), .o_gt(gt5), .o_eq(eq5), .o_lt(lt5));
 Comapa4bitUnsign ins_compa_6 (.i_a(i_a[27:24]), .i_b(i_b[27:24]), .i_gt(gt5), .i_eq(eq5), .i_lt(lt5), .o_gt(gt6), .o_eq(eq6), .o_lt(lt6));
 Comapa4bitUnsign ins_compa_7 (.i_a(i_a[31:28]), .i_b(i_b[31:28]), .i_gt(gt6), .i_eq(eq6), .i_lt(lt6), .o_gt(o_gt), .o_eq(o_eq), .o_lt(o_lt));


endmodule