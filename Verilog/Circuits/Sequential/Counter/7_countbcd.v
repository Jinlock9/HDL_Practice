module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);
    
    assign ena[1] = (q[3:0] == 4'h9);
    assign ena[2] = (q[3:0] == 4'h9 & q[7:4] == 4'h9);
    assign ena[3] = (q[3:0] == 4'h9 & q[7:4] == 4'h9 & q[11:8] == 4'h9);
    
    counter10 digit0 (clk, reset, 1'b1, q[3:0]);
    counter10 digit1 (clk, reset, ena[1], q[7:4]);
    counter10 digit2 (clk, reset, ena[2], q[11:8]);
    counter10 digit3 (clk, reset, ena[3], q[15:12]);

endmodule

module counter10 (
    input clk,
    input reset,
    input enable,
    output reg [3:0] q
);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'h0;
        end else if (enable) begin
            if (q == 4'h9)
                q <= 4'h0;
            else 
                q <= q + 4'h1;
        end
    end
    
endmodule 
