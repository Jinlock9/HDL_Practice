module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
    output [2:0] LEDR    // Q
);  

    wire d0, d1, d2;
    assign d0 = KEY[1] ? SW[0] : LEDR[2];
    assign d1 = KEY[1] ? SW[1] : LEDR[0];
    assign d2 = KEY[1] ? SW[2] : LEDR[1] ^ LEDR[2];
    
    dflipflop dff0 (KEY[0], d0, LEDR[0]);
    dflipflop dff1 (KEY[0], d1, LEDR[1]);
    dflipflop dff2 (KEY[0], d2, LEDR[2]);

endmodule

module dflipflop (
    input clk,
    input D,
    output Q
);
    
    always @(posedge clk)
        Q <= D;
    
endmodule
