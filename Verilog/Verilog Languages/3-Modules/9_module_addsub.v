module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    
    wire cout;
    wire [15:0] b0, b1;
    
    assign b0 = {16{sub}} ^ b[15:0];
    assign b1 = {16{sub}} ^ b[31:16];
    
    add16 add16_0 ( a[15:0], b0, sub, sum[15:0], cout );
    add16 add16_1 ( a[31:16], b1, cout, sum[31:16] );

endmodule
