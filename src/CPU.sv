module CPU(i_clk, i_reset, o_pc_debug, o_insn_vld, o_io_ledr, o_io_ledg, 
            o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7,
				o_io_lcd, i_io_sw);
				
 input i_clk, i_reset;
 input [31:0] i_io_sw;
 output o_insn_vld;
 output [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7;
 output [31:0] o_pc_debug, o_io_ledr, o_io_ledg, o_io_lcd;  

endmodule