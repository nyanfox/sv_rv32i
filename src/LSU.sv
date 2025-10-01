module LSU (i_clk, i_reset, i_funct3, i_lsu_addr, i_st_data, i_lsu_wren, o_ld_data, o_io_ledr, o_io_ledg, 
				o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7,
				o_io_lcd, i_io_sw);
				
 input i_clk, i_reset, i_lsu_wren;
 input [2:0] i_funct3;
 input [31:0] i_lsu_addr;
 input [31:0] i_st_data;
 input [31:0] i_io_sw;
 output reg [31:0] o_ld_data;
 output reg [31:0] o_io_ledr, o_io_ledg, o_io_lcd;
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
 
 wire [31:0] ins_storeunit_o_data_1;
 wire [3:0] ins_storeunit_o_mask_1;
 wire [31:0] ins_cla_sum;
 wire ins_cla_cout;
 wire [31:0] ins_loadunit_o_data;
 wire ins_storeunit_trap;
 reg [31:0] data1_r, data2_r;
 
 (* ramstyle = "M20K" *) reg [31:0] mem [0:MEM_SIZE-1];
 
 CLA32bit ins_cla (.i_a(i_lsu_addr), .i_b(1), .i_cin(0), .o_sum(ins_cla_sum), .o_cout(ins_cla_cout));
 LoadUnit ins_loadunit (.i_data1(data1_r), .i_data2(data2_r), .i_funct3(i_funct3), .i_lsu_addr(i_lsu_addr[1:0]), .o_data(ins_loadunit_o_data));
 StoreUnit ins_storeunit (.i_clk(i_clk), .i_funct3(i_funct3), .i_lsu_addr(i_lsu_addr[1:0]), .i_data(i_st_data), .o_data_1(ins_storeunit_o_data_1), .o_mask_1(ins_storeunit_o_mask_1), .o_trap(ins_storeunit_trap));
 
 
 always @(*) begin
     data1_r = mem[i_lsu_addr[11:0]];
     data2_r = mem[ins_cla_sum[11:0]];
 end
 
 always @(*) begin
  if(i_lsu_addr[31:16]==16'h0000) begin
      o_ld_data = ins_loadunit_o_data;
  end
  else if(i_lsu_addr[31:16]==16'h1001) begin
      o_ld_data = i_io_sw;
  end
  else begin
      o_ld_data = 32'h0000_0000;    
  end
 end
 
always @(posedge i_clk) begin
 if(i_lsu_wren == 1 && i_lsu_addr[31:16==16'b0]) begin
     //mem[i_lsu_addr[8:0]] <= (mem[i_lsu_addr[8:0]] & ins_storeunit_o_mask_1) | ins_storeunit_o_data_1;
	  if(ins_storeunit_o_mask_1[0]==0) begin
	      mem[i_lsu_addr[8:0]][7:0] <= ins_storeunit_o_data_1[7:0];  
	  end
	  if(ins_storeunit_o_mask_1[1]==0) begin
	      mem[i_lsu_addr[8:0]][15:8] <= ins_storeunit_o_data_1[15:8];  
	  end
	  if(ins_storeunit_o_mask_1[2]==0) begin
	      mem[i_lsu_addr[8:0]][23:16] <= ins_storeunit_o_data_1[23:16];  
	  end
	  if(ins_storeunit_o_mask_1[3]==0) begin
	      mem[i_lsu_addr[8:0]][31:24] <= ins_storeunit_o_data_1[31:24];  
	  end
 end
 else if (i_lsu_wren==1 && i_lsu_addr[31:16]==16'h1000) begin
  if(i_lsu_addr[15:12]==4'h0) begin
      o_io_ledr <= ins_storeunit_o_data_1;
  end
  else if(i_lsu_addr[15:12]==4'h1) begin
      o_io_ledg <= ins_storeunit_o_data_1;
  end
  else if(i_lsu_addr[15:12]==4'h4) begin
      o_io_lcd <= ins_storeunit_o_data_1;
  end
  else if(i_lsu_addr[15:12]==4'h1) begin
   if(ins_storeunit_o_mask_1[0]==0) begin
	    o_io_hex0 <= ins_storeunit_o_data_1[6:0];
	end
	if(ins_storeunit_o_mask_1[1]==0) begin
	    o_io_hex1 <= ins_storeunit_o_data_1[14:8];
	end
	if(ins_storeunit_o_mask_1[2]==0) begin
	    o_io_hex2 <= ins_storeunit_o_data_1[22:16];
	end
	if(ins_storeunit_o_mask_1[3]==0) begin
	    o_io_hex3 <= ins_storeunit_o_data_1[30:24];
	end
  end
  else if(i_lsu_addr[15:12]==4'h5) begin
   if(ins_storeunit_o_mask_1[0]==0) begin
	    o_io_hex4 <= ins_storeunit_o_data_1[6:0];
	end
	if(ins_storeunit_o_mask_1[1]==0) begin
	    o_io_hex5 <= ins_storeunit_o_data_1[14:8];
	end
	if(ins_storeunit_o_mask_1[2]==0) begin
	    o_io_hex6 <= ins_storeunit_o_data_1[22:16];
	end
	if(ins_storeunit_o_mask_1[3]==0) begin
	    o_io_hex7 <= ins_storeunit_o_data_1[30:24];
	end
  end
 end
end
endmodule