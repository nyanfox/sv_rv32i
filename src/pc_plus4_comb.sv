module pc_plus4_comb (
    input  wire [31:0] pc_in,   // PC hiện tại
    output wire [31:0] pc_out   // PC + 4
);
    assign pc_out = pc_in + 32'd4;
endmodule
