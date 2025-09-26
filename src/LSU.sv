module LSU (i_clk, i_reset, i_funct3, i_lsu_addr, i_st_data, i_lsu_wren, o_ld_data, o_io_ledr, o_io_ledg, 
				o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7,
				o_io_lcd, i_io_sw);
				
 input i_clk, i_reset, i_lsu_wren;
 input [2:0] i_funct3;
 input [31:0] i_lsu_addr;
 input [31:0] i_st_data;
 input [31:0] i_io_sw;
 output [31:0] o_ld_data;
 output [31:0] o_io_ledr, o_io_ledg, o_io_lcd;
 output [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7;
 
 localparam MEM_SIZE = 512;
 
 localparam LB = 3'b000;
 localparam LH = 3'b001;
 localparam LW = 3'b010;
 localparam LBU = 3'b100;
 localparam LHU = 3'b101;
 
 localparam SB = 3'b000;
 localparam SH = 3'b001;
 localparam SW = 3'b010;
 
 wire [31:0] ins_storeunit_o_data_1, ins_storeunit_o_data_2;
 wire [31:0] ins_cla_sum;
 wire ins_cla_cout;
 reg [31:0] data1_r, data2_r;
 reg [31:0] mem [0:MEM_SIZE];
 
 CLA32bit ins_cla (.i_a(i_lsu_addr), .i_b(1), .i_cin(0), .o_sum(ins_cla_sum), .o_cout(ins_cla_cout));
 LoadUnit ins_loadunit (.i_data1(data1_r), .i_data2(data2_r), .i_funct3(i_funct3), .i_lsu_addr(i_lsu_addr[1:0]), .o_data(o_ld_data));
 StoreUnit ins_storeunit (.i_funct3(i_funct3), .i_lsu_addr(i_lsu_addr[1:0]), .i_mem1(data1_r), .i_mem2(data2_r), .i_data(i_st_data), .o_data_1(ins_storeunit_o_data_1), .o_data_2(ins_storeunit_o_data_2));
 
 always @(*) begin
     data1_r = mem[i_lsu_addr[11:0]];
     data2_r = mem[ins_cla_sum[11:0]];
 end
 
always @(posedge i_clk) begin
 if(i_lsu_wren == 1) begin
     mem[i_lsu_addr[11:0]] <= ins_storeunit_o_data_1;
     mem[ins_cla_sum[11:0]] <= ins_storeunit_o_data_2;
 end
end


endmodule