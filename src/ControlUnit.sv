module ControlUnit (i_instr, i_br_less, i_br_equal, o_pc_sel, o_rd_wren, o_br_un, o_opa_sel, o_opb_sel, 
                     o_alu_op, o_mem_wren, o_wb_sel, o_insn_vld);

 input [31:0] i_instr;
 input i_br_less, i_br_equal;

 output o_pc_sel, o_rd_wren, o_insn_vld, o_br_un, o_mem_wren;
 output o_opa_sel, o_opb_sel;
 output [3:0] o_alu_op;
 output [1:0] o_wb_sel;
 
 
    // Giải mã i_instruction
 wire [6:0] opcode;
 wire [2:0] funct3;
 wire [6:0] funct7;
 
 localparam R_TYPE = 7'b011_0011;
 localparam I_TYPE_1 = 7'b001_0011;
 localparam I_TYPE_2 = 7'b110_0111;
 localparam I_TYPE_3 = 7'b000_0011;
 localparam S_TYPE = 7'b010_0011;
 localparam B_TYPE = 7'b110_0011;
 localparam U_TYPE_1 = 7'b011_0111;
 localparam U_TYPE_2 = 7'b001_0111;
 localparam J_TYPE = 7'b110_1111;
 
 localparam ADD_SUB = 3'b000;
 localparam SLL = 3'b001;
 localparam SLT = 3'b010;
 localparam SLTU = 3'b011;
 localparam XOR = 3'b100;
 localparam SRL_SRA = 3'b101;
 localparam OR = 3'b110;
 localparam AND = 3'b111;
 
 
 assign opcode = i_instr[6:0];
 assign funct3 = i_instr[14:12];
 assign funct7 = i_instr[31:25];

 always @(*) begin
  case(opcode)
   R_TYPE:begin
	 case (funct7)
	  ADD_SUB: begin
	   if(funct7[5]==1'b0) begin
		    o_pc_sel = 4'b0000;
			 o_opa_sel = 1'b0;
			 o_opb_sel = 1'b0;
			 o_wb_sel = 2'b01;
			 o_rd_wren = 1'b0;
			 o_mem_wren = 1'b0;
			 o_pc_sel = 1'b0;
		end
	   else begin
	       o_pc_sel = 4'b0001;
			 o_opa_sel = 1'b0;
			 o_opb_sel = 1'b0;
			 o_wb_sel = 2'b01;
			 o_rd_wren = 1'b0;
			 o_mem_wren = 1'b0;
			 o_pc_sel = 1'b0;
	   end
	  end
	  
	  SLL: begin
	      o_pc_sel = 4'b0111;
			o_opa_sel = 1'b0;
			o_opb_sel = 1'b0;
			o_wb_sel = 2'b01;
			o_rd_wren = 1'b0;
			o_mem_wren = 1'b0;
			o_pc_sel = 1'b0;
	  end
	  
	  SLT: begin
	      o_pc_sel = 4'b0110;
			o_opa_sel = 1'b0;
			o_opb_sel = 1'b0;
			o_wb_sel = 2'b01;
			o_rd_wren = 1'b0;
			o_mem_wren = 1'b0;
			o_pc_sel = 1'b0;
	  end
	  
	  SLTU: begin
	      o_pc_sel = 4'b0011;
			o_opa_sel = 1'b0;
			o_opb_sel = 1'b0;
			o_wb_sel = 2'b01;
			o_rd_wren = 1'b0;
			o_mem_wren = 1'b0;
			o_pc_sel = 1'b0;
	  end
	  
	  XOR: begin
	      o_pc_sel = 4'b0100;
			o_opa_sel = 1'b0;
			o_opb_sel = 1'b0;
			o_wb_sel = 2'b01;
			o_rd_wren = 1'b0;
			o_mem_wren = 1'b0;
			o_pc_sel = 1'b0;
	  end
	  
	  SRL_SRA: begin
	   if(funct7[5]==1'b0) begin
		    o_pc_sel = 4'b1000;
			 o_opa_sel = 1'b0;
			 o_opb_sel = 1'b0;
			 o_wb_sel = 2'b01;
			 o_rd_wren = 1'b0;
			 o_mem_wren = 1'b0;
			 o_pc_sel = 1'b0;
		end
	   else begin
	       o_pc_sel = 4'b1001;
			 o_opa_sel = 1'b0;
			 o_opb_sel = 1'b0;
			 o_wb_sel = 2'b01;
			 o_rd_wren = 1'b0;
			 o_mem_wren = 1'b0;
			 o_pc_sel = 1'b0;
	   end
	  end
	  
	  OR: begin
	      o_pc_sel = 4'b0101;
			o_opa_sel = 1'b0;
			o_opb_sel = 1'b0;
			o_wb_sel = 2'b01;
			o_rd_wren = 1'b0;
			o_mem_wren = 1'b0;
			o_pc_sel = 1'b0;
	  end
	  
	  AND: begin
	      o_pc_sel = 4'b0110;
			o_opa_sel = 1'b0;
			o_opb_sel = 1'b0;
			o_wb_sel = 2'b01;
			o_rd_wren = 1'b0;
			o_mem_wren = 1'b0;
			o_pc_sel = 1'b0;
	  end
	  
	 
	 endcase
	
	end
  
  endcase
 
 end
 
 endmodule