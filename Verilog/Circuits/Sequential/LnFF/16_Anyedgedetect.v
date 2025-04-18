module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    
    reg [7:0] old;
    
    always @(posedge clk) begin
        old <= in;
        anyedge <= in ^ old;
    end

endmodule
