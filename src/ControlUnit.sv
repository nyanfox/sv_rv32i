module ControlUnit (i_instr, i_br_less, i_br_equal, o_pc_sel, o_rd_wren, o_br_un, o_opa_sel, o_opb_sel, 
                     o_alu_op, o_mem_wren, o_wb_sel, o_insn_vld, o_lsu_funct3);

 input [31:0] i_instr;
 input i_br_less, i_br_equal;
 output o_pc_sel, o_rd_wren, o_insn_vld, o_br_un, o_mem_wren;
 output o_opa_sel, o_opb_sel;
 output [2:0] o_lsu_funct3;
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
 
 localparam ADDI = 3'b000;
 localparam SLTI = 3'b010;
 localparam SLTIU = 3'b011;
 localparam XORI = 3'b100;
 localparam ORI = 3'b110;
 localparam ANDI = 3'b111;
 
 localparam SLLI = 3'b001;
 localparam SRLI_SRAI = 3'b101;
 
 localparam LB = 3'b000;
 localparam LH = 3'b001;
 localparam LW = 3'b010;
 localparam LBU= 3'b100;
 localparam LHU = 3'b101;
 
 localparam SB = 3'b000;
 localparam SH = 3'b001;
 localparam SW = 3'b010;
 
 localparam BEQ = 3'b000;
 localparam BNE = 3'b001;
 localparam BLT = 3'b100;
 localparam BGE = 3'b101;
 localparam BLTU = 3'b110;
 localparam BGEU = 3'b111;
 
 assign opcode = i_instr[6:0];
 assign funct3 = i_instr[14:12];
 assign funct7 = i_instr[31:25];

 always @(*) begin
  case(opcode)
   R_TYPE:begin
       o_opa_sel = 1'b0;
       o_opb_sel = 1'b1;
       o_wb_sel = 2'b01;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
       o_pc_sel = 1'b0;
       case (funct7)
        ADD_SUB: begin
         if(funct7[5]==1'b0) begin
             o_alu_op = 4'b0000;
         end
         else begin
             o_alu_op = 4'b0001;
         end
        end
        SLL: begin
            o_alu_op = 4'b0111;
        end
        SLT: begin
            o_alu_op = 4'b0110;
        end
        SLTU: begin
            o_alu_op = 4'b0011;
        end
        XOR: begin
            o_alu_op = 4'b0100;
        end
        SRL_SRA: begin
         if(funct7[5]==1'b0) begin
             o_alu_op = 4'b1000;
         end
         else begin
             o_alu_op = 4'b1001;
         end
        end
        OR: begin
            o_alu_op = 4'b0101;
        end
        AND: begin
            o_alu_op = 4'b0110;
        end
       endcase
      end
	
   I_TYPE_1:begin
       o_opa_sel = 1'b0;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b01;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
       o_pc_sel = 1'b0; 
	    case (funct3)
	     ADDI:begin
            o_alu_op = 4'b0000;
        end
        SLTI:begin
            o_alu_op = 4'b0110;
        end
        SLTIU:begin
            o_alu_op = 4'b0110;
        end
        XORI: begin
            o_alu_op = 4'b0100;
        end
        ORI: begin
            o_alu_op = 4'b0101;
        end
        ANDI: begin
            o_alu_op = 4'b0110;
        end
        SLLI: begin
            o_alu_op = 4'b0111;
        end
        SRLI_SRAI: begin
         if(funct7[5]==1'b0) begin
             o_alu_op = 4'b1000;
         end
         else begin
             o_alu_op = 4'b1001;
         end
        end
       endcase
      end
		
	I_TYPE_2: begin
       o_opa_sel = 1'b1;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b10;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
       o_pc_sel = 1'b1;
		 o_alu_op = 4'b0000;
   end	
		
   I_TYPE_3: begin
	    o_opa_sel = 1'b0;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b00;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
       o_pc_sel = 1'b0;
		 o_alu_op = 4'b0000;
		 o_lsu_funct3 = funct3;
		 
   end

   S_TYPE: begin
       o_opa_sel = 1'b0;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b00;
       o_rd_wren = 1'b0;
       o_mem_wren = 1'b1;
       o_pc_sel = 1'b0;
		 o_alu_op = 4'b0000;
		 o_lsu_funct3 = funct3;
   end

  B_TYPE: begin
       o_opa_sel = 1'b1;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b00;
       o_rd_wren = 1'b0;
       o_mem_wren = 1'b0;
		 o_alu_op = 4'b0000;
   case(funct3)
	 BEQ:begin
		 o_br_un = 1'b1;
		 if(i_br_equal==1'b1) begin
		     o_pc_sel=1'b1;
		 end
		 else begin
		     o_pc_sel=1'b0;
		 end
	 end
	 BNE:begin
	     o_br_un = 1'b1;
		 if(i_br_equal==1'b0) begin
		     o_pc_sel=1'b1;
		 end
		 else begin
		     o_pc_sel=1'b0;
		 end
	 end
	 BLT:begin
	     o_br_un = 1'b1;
		 if(i_br_less==1'b1) begin
		     o_pc_sel=1'b1;
		 end
		 else begin
		     o_pc_sel=1'b0;
		 end
	 end
	 BGE:begin
	     o_br_un = 1'b1;
		 if(i_br_less==1'b0) begin
		     o_pc_sel=1'b1;
		 end
		 else begin
		     o_pc_sel=1'b0;
		 end
	 end
	  BLTU:begin
	     o_br_un = 1'b0;
		 if(i_br_less==1'b1) begin
		     o_pc_sel=1'b1;
		 end
		 else begin
		     o_pc_sel=1'b0;
		 end
	 end
	  BGEU:begin
	     o_br_un = 1'b0;
		 if(i_br_less==1'b0) begin
		     o_pc_sel=1'b1;
		 end
		 else begin
		     o_pc_sel=1'b0;
		 end
	 end
	endcase
  end
 
  U_TYPE_1:begin
       o_opa_sel = 1'b1;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b11;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
		 o_alu_op = 4'b0000;
  end
  
  U_TYPE_2:begin
       o_opa_sel = 1'b1;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b01;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
		 o_alu_op = 4'b0000;
  end
  
  J_TYPE:begin
       o_opa_sel = 1'b1;
		 o_opb_sel = 1'b0;
       o_wb_sel = 2'b10;
       o_rd_wren = 1'b1;
       o_mem_wren = 1'b0;
		 o_alu_op = 4'b0000;
  end
  
  endcase
	 
 end
 
 endmodule