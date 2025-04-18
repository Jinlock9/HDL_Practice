module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

    wire D;

    assign D = (j & ~Q) | (~k & Q);  // JK behavior mapped into D input

    always @(posedge clk)
        Q <= D;

endmodule
