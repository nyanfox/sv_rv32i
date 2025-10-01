module brc (i_rs1_data, i_rs2_data, i_br_un, o_br_less, o_br_equal);

 input [31:0] i_rs1_data, i_rs2_data;
 input i_br_un;
 output o_br_less, o_br_equal;

 wire compa_sign_lt, compa_sign_eq;
 wire compa_unsign_gt, compa_unsign_eq, compa_unsign_lt;
 
 reg o_br_less_r, o_br_equal_r; 
 
 assign o_br_less = o_br_less_r;
 assign o_br_equal = o_br_equal_r;
 
 Compa32bitSign ins_compa_sign (.i_a(i_rs1_data), .i_b(i_rs2_data), .o_lt(compa_sign_lt), .o_eq(compa_sign_eq));
 Compa32bitUnsign ins_compa_unsign (.i_a(i_rs1_data), .i_b(i_rs2_data), .o_gt(compa_unsign_gt), .o_eq(compa_unsign_eq), .o_lt(compa_unsign_lt));
 
 always @(*) begin
  if(i_br_un == 1) begin
      o_br_less_r <= compa_sign_lt;
		o_br_equal_r <= compa_sign_eq;
  end
  if(i_br_un == 0) begin
      o_br_less_r <= compa_unsign_lt;
		o_br_equal_r <= compa_unsign_eq; 
  end
 
 end
 
endmodule