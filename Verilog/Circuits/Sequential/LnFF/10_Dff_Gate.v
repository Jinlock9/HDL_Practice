module top_module (
    input clk,
    input in, 
    output reg out
);
    
    wire w;
    
    assign w = in ^ out;
    
    always @(posedge clk)
        out <= w;

endmodule
