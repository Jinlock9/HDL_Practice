module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
    
    wire d0, d1;
    
    assign d0 = E ? w : Q;
    assign d1 = L ? R : d0;
    
    always @(posedge clk) 
        Q <= d1;

endmodule
