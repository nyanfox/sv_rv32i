module RegFile (i_clk, i_reset, i_rs1_addr, i_rs2_addr, o_rs1_data, o_rs2_data, i_rd_addr, i_rd_data, i_rd_wren);

 input i_clk, i_reset;
 input [4:0] i_rs1_addr, i_rs2_addr, i_rd_addr;
 input i_rd_wren;
 input [31:0] i_rd_data;
 output [31:0] o_rs1_data, o_rs2_data;
 
 integer i;
 
 reg [31:0] regs [31:0];
 
 assign o_rs1_data = (i_rs1_addr==0) ? 32'b0 : regs[i_rs1_addr];
 assign o_rs2_data = (i_rs2_addr==0) ? 32'b0 : regs[i_rs2_addr];
 
 always @(posedge i_clk) begin
  if(i_reset == 1) begin
	for(i=1; i<32; i=i+1) begin
	    regs[i] = 0;
	end
  end
  else begin 
   if(i_rd_wren == 1 && i_rd_addr != 0) begin
	    regs[i_rd_addr] <= i_rd_data;
	end
  end
     
 end
 
endmodule