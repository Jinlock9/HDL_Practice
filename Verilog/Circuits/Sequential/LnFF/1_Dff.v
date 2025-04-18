module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q 
);
 
    always @(posedge clk) begin
        q <= d; // Use non-blocking assignment for edge-triggered always blocks
    end 

endmodule
