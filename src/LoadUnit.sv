module LoadUnit (i_data1, i_data2, i_funct3, i_lsu_addr, o_data);
 
 input [31:0] i_data1, i_data2;
 input [2:0] i_funct3;
 input [1:0] i_lsu_addr;
 output [31:0] o_data;
 
 reg [31:0] o_data_r;
 
 localparam LB = 3'b000;
 localparam LH = 3'b001;
 localparam LW = 3'b010;
 localparam LBU = 3'b100;
 localparam LHU = 3'b101;
 
 
 assign o_data = o_data_r;
 
 always @(*) begin
   case (i_funct3)
    LB: begin
	  if(i_lsu_addr[1:0] == 2'b00) begin
	      o_data_r[7:0] = i_data1[7:0];
			o_data_r[31:8] = i_data1[7];
     end
	  else if(i_lsu_addr[1:0] == 2'b01) begin
	      o_data_r[7:0] = i_data1[15:8];  
		   o_data_r[31:8] = i_data1[15];	
     end	
	  else if(i_lsu_addr[1:0] == 2'b10) begin
	      o_data_r[7:0] = i_data1[23:16];
         o_data_r[31:8] = i_data1[23];			
     end	
	  else  begin
	      o_data_r[7:0] = i_data1[31:24];
			o_data_r[31:8] = i_data1[31];
	  end
	 end
	 
	 LH: begin
	  if(i_lsu_addr[1:0] == 2'b00) begin
	      o_data_r[15:0] = i_data1[15:0];
			o_data_r[31:16] = i_data1[15];
	  end
	  else if(i_lsu_addr[1:0] == 2'b01) begin
	      o_data_r[15:0] = i_data1[23:8];
			o_data_r[31:16] = i_data1[23];
	  end
	  else if(i_lsu_addr[1:0] == 2'b10) begin
	      o_data_r[15:0] = i_data1[31:15];
			o_data_r[31:16] = i_data1[31];
	  end
	  else begin
	      o_data_r[7:0] = i_data1[31:24];
			o_data_r[15:8] = i_data2[7:0];
			o_data_r[31:16] = i_data2[7];
	  end
	 end
	 
	 LW: begin
	  if(i_lsu_addr[1:0] == 2'b00) begin
	      o_data_r = i_data1;
	  end
	  else if(i_lsu_addr[1:0] == 2'b01) begin
	      o_data_r[23:0] = i_data1[31:8];
			o_data_r[31:24] = i_data2[7:0];
	  end
	  else if(i_lsu_addr[1:0] == 2'b10) begin
	      o_data_r[15:0] = i_data1[31:16];
			o_data_r[31:16] = i_data2[15:0];
	  end
	  else begin
	      o_data_r[7:0] = i_data1[31:24];
			o_data_r[31:8] = i_data2[23:0];
	  end
	 end
	 
	 LBU:begin
	  if(i_lsu_addr[1:0] == 2'b00) begin
	      o_data_r[7:0] = i_data1[7:0];
			o_data_r[31:8] = 0;
     end
	  else if(i_lsu_addr[1:0] == 2'b01) begin
	      o_data_r[7:0] = i_data1[15:8];  
		   o_data_r[31:8] = 0;	
     end	
	  else if(i_lsu_addr[1:0] == 2'b10) begin
	      o_data_r[7:0] = i_data1[23:16];
         o_data_r[31:8] = 0;			
     end	
	  else  begin
	      o_data_r[7:0] = i_data1[31:24];
			o_data_r[31:8] = 0;
	  end
	 end
	 
	 LHU: begin
	  if(i_lsu_addr[1:0] == 2'b00) begin
	      o_data_r[15:0] = i_data1[15:0];
			o_data_r[31:16] = 0;
	  end
	  else if(i_lsu_addr[1:0] == 2'b01) begin
	      o_data_r[15:0] = i_data1[23:8];
			o_data_r[31:16] = 0;
	  end
	  else if(i_lsu_addr[1:0] == 2'b10) begin
	      o_data_r[15:0] = i_data1[31:15];
			o_data_r[31:16] = 0;
	  end
	  else begin
	      o_data_r[7:0] = i_data1[31:24];
			o_data_r[15:8] = i_data2[7:0];
			o_data_r[31:16] = 0;
	  end
	 
	 end
	 
   default: begin
       o_data_r = 0;
   end
   endcase
 end

 

endmodule