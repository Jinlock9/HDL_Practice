module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min
);

    wire [7:0] w0, w1;
	
    assign w0 = (a < b) ? a : b;
    assign w1 = (c < d) ? c : d;
    assign min = (w0 < w1) ? w0 : w1;
    
endmodule
