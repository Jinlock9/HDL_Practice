module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    // KEY[0] = clk
    // KEY[1] = E (enable)
    // KEY[2] = L (load)
    // KEY[3] = R (async load value for DFF 3)

    MUXDFF dff3 (KEY[0], KEY[1], KEY[2], SW[3], KEY[3], LEDR[3]);
    MUXDFF dff2 (KEY[0], KEY[1], KEY[2], SW[2], LEDR[3], LEDR[2]);
    MUXDFF dff1 (KEY[0], KEY[1], KEY[2], SW[1], LEDR[2], LEDR[1]);
    MUXDFF dff0 (KEY[0], KEY[1], KEY[2], SW[0], LEDR[1], LEDR[0]);
endmodule


module MUXDFF (
    input clk,
    input E, L,
    input R,
    input in,
    output reg Q
);

    always @(posedge clk) begin
        if (L)
            Q <= R;
        else if (E)
            Q <= in;
        // else: Q holds its value (no change)
    end

endmodule
