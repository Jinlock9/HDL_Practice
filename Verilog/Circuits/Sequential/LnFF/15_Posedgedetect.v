module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    
    reg [7:0] in_old;
    
    always @(posedge clk) begin
        in_old <= in;
    	pedge <= in & ~in_old;
    end

endmodule
