module CLA4bit (i_a, i_b, i_cin, o_sum, o_cout);
 
 input i_cin;
 input [3:0] i_a, i_b;
 output o_cout;
 output [3:0] o_sum;
 
 wire [3:0] p, g;
 wire [3:1] c;

 assign p = i_a ^ i_b;
 assign g = i_a & i_b;
 
 assign c[1] = g[0] | (p[0] & i_cin);
 assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & i_cin);
 assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & i_cin);
 assign o_cout = g[3] | (p[3] & c[3]);
 
 assign o_sum = p ^ {c[3:1], i_cin};

endmodule