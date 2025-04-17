module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);
    
    // assign sum = x + y; <- ANSWER
    
    wire [2:0] w;
    
    fadd m0 (x[0], y[0], 1'b0, w[0], sum[0]);
    fadd m1 (x[1], y[1], w[0], w[1], sum[1]);
    fadd m2 (x[2], y[2], w[1], w[2], sum[2]);
    fadd m3 (x[3], y[3], w[2], sum[4], sum[3]);

endmodule

module fadd (
    input a, b,
    input cin,
    output cout,
    output sum
);
    
    assign cout = (a & b) | (cin & (a ^ b));
    assign sum = a ^ b ^ cin;
    
endmodule
