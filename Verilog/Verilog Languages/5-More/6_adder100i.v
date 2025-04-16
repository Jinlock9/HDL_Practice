module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum 
);
    
    genvar i;
    generate
        full_adder fadd0 (a[0], b[0], cin, cout[0], sum[0]);
        for (i = 1; i < 100; ++i) begin : gen_fadd
            full_adder fadd (a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate

endmodule

module full_adder(
    input a, b,
    input cin,
    output cout,
    output sum
);
    
    assign cout = (a & b) | (cin & (a ^ b));
    assign sum = a ^ b ^ cin;
    
endmodule
