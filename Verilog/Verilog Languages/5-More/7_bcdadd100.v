module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum 
);

    wire [98:0] w;
    
    genvar i;
    generate
        bcd_fadd m0 (
            .a(a[3:0]), 
            .b(b[3:0]), 
            .cin(cin), 
            .cout(w[0]), 
            .sum(sum[3:0])
        );
        for (i = 1; i < 99; i = i + 1) begin : gen_bcd_fadd
            bcd_fadd m (
                .a(a[4*i +: 4]), 
                .b(b[4*i +: 4]), 
                .cin(w[i-1]), 
                .cout(w[i]), 
                .sum(sum[4*i +: 4])
            );
        end
        bcd_fadd m1 (
            .a(a[396 +: 4]), 
            .b(b[396 +: 4]), 
            .cin(w[98]), 
            .cout(cout), 
            .sum(sum[396 +: 4])
        );
    endgenerate

endmodule
