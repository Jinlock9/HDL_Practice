module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire sel;
    wire [15:0] sum0, sum1;
    
    add16 add16_lo ( a[15:0], b[15:0], 1'b0, sum[15:0], sel );
    add16 add16_hi_0 ( a[31:16], b[31:16], 1'b0, sum0 );
    add16 add16_hi_1 ( a[31:16], b[31:16], 1'b1, sum1 );
    
    assign sum[31:16] = sel ? sum1 : sum0;

endmodule