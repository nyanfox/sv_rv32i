module ALU (i_op_a, i_op_b, i_alu_op, o_alu_data);

 input [31:0] i_op_a, i_op_b;
 input [3:0] i_alu_op;
 output [31:0] o_alu_data;
 
 reg [31:0] o_alu_data_r;
 
 localparam ADD = 4'b0000;
 localparam SUB = 4'b0001;
 localparam SLT = 4'b0010;
 localparam SLTU = 4'b0011;
 localparam XOR = 4'b0100;
 localparam OR = 4'b0101;
 localparam AND = 4'b0110;
 localparam SLL = 4'b0111;
 localparam SRL = 4'b1000;
 localparam SRA = 4'b1001;
 
 wire ins_cla_o_cout;
 wire [31:0] ins_cla_o_sum;
 
 assign o_alu_data = o_alu_data_r;
 
 CLA32bit ins_cla (.i_a(i_op_a), .i_b(i_op_b), .i_cin(0), .o_sum(ins_cla_o_sum), .o_cout(ins_cla_o_cout));
 
 always @(*) begin
  case (i_alu_op)
   ADD: begin
	    o_alu_data_r <= ins_cla_o_sum;
	end
  
   AND: begin
	    o_alu_data_r <= i_op_a & i_op_b;
	end
 
 
  endcase
 end

endmodule