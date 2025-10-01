module ImmGen(i_instr, o_number);
 input [31:0] i_instr;
 output reg [31:0] o_number;
 
 wire [6:0] opcode;
 
 assign opcode = i_instr[6:0];
 
 localparam I_TYPE_1 = 7'b0000011;
 localparam I_TYPE_2 = 7'b0010011;
 localparam S_TYPE = 7'b0100011;
 localparam B_TYPE = 7'b1100011;
 localparam U_TYPE_1 = 7'b0110111;
 localparam U_TYPE_2 = 7'b0010111;
 localparam J_TYPE = 7'b1101111;
 
 always @(*) begin
  case (opcode) 
   I_TYPE_1, I_TYPE_2:begin
       o_number = {{20{i_instr[31]}}, i_instr[31:20]};   
	end
	S_TYPE:begin
	    o_number = {{19{i_instr[31]}}, i_instr[31], i_instr[7],i_instr[30:25], i_instr[11:8], 1'b0};
	end
	U_TYPE_1, U_TYPE_2:begin
	    o_number = {i_instr[31:12], 12'b0};
	end
	J_TYPE: begin
	    o_number = {{11{i_instr[31]}}, i_instr[31], i_instr[19:12],i_instr[20], i_instr[30:21], 1'b0};
	end
	default:begin
	    o_number = 32'b0;
	end
  endcase
 end
endmodule