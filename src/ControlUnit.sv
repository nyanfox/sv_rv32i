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
 
 assign opcode = i_instr[6:0];
 assign funct3 = i_instr[14:12];
 assign funct7 = i_instr[31:25];

 
 
 endmodule