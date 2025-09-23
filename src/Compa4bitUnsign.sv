module Comapa4bitUnsign(i_a, i_b, i_gt, i_eq, i_lt, o_gt, o_eq, o_lt);

 input [3:0] i_a, i_b;
 input i_gt, i_eq, i_lt;
 output o_gt, o_eq, o_lt;
 
 wire gt0, gt1, gt2, gt3, gt4, gt5;
 wire lt0, lt1, lt2, lt3, lt4, lt5;
 wire bl0, bl1, bl2, bl3;
 wire not_i0, not_i1, not_i2, not_i3;
 
 
 assign not_i0 = ~(i_a[0] & i_b[0]);
 assign not_i1 = ~(i_a[1] & i_b[1]);
 assign not_i2 = ~(i_a[2] & i_b[2]);
 assign not_i3 = ~(i_a[3] & i_b[3]);
 
 assign bl0 = ~((not_i0 & i_a[0]) | (not_i0 & i_b[0]));
 assign bl1 = ~((not_i1 & i_a[1]) | (not_i1 & i_b[1]));
 assign bl2 = ~((not_i2 & i_a[2]) | (not_i2 & i_b[2]));
 assign bl3 = ~((not_i3 & i_a[3]) | (not_i3 & i_b[3]));
 
 assign gt0 = ~(i_b[3] & not_i3);
 assign gt1 = ~(i_b[2] & not_i2 & bl3);
 assign gt2 = ~(i_b[1] & not_i1 & bl3 & bl2);
 assign gt3 = ~(i_b[0] & not_i0 & bl3 & bl2 & bl1);
 assign gt4 = ~(bl3 & bl2 & bl1 & bl0 & i_lt); 
 assign gt5 = ~(bl3 & bl2 & bl1 & bl0 & i_eq);
 assign o_gt = (gt0 & gt1 & gt2 & gt3 & gt4 & gt5);
 
 assign o_eq = bl3 & bl2 & bl1 & bl0 & i_eq;

 assign lt0 = ~(i_eq & bl0 & bl1 & bl2 & bl3);
 assign lt1 = ~(i_gt & bl0 & bl2 & bl1 & bl3);
 assign lt2 = ~(bl1 & bl2 & bl3 & not_i0 & i_a[0]);
 assign lt3 = ~(bl2 & bl3 & not_i1 & i_a[1]);
 assign lt4 = ~(bl3 & not_i2 & i_a[2]);
 assign lt5 = ~(i_a[3] & not_i3);
 assign o_lt = lt0 & lt1 & lt2 & lt3 & lt4 & lt5;
 
endmodule