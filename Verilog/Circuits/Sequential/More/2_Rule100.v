module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 
    integer i;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[511] <= q[511] | q[510];
            for (i = 510; i >= 1; i = i - 1) begin
                q[i] <= q[i + 1] ? (q[i] ^ q[i - 1]) : (q[i] | q[i - 1]);
            end
            // q[0] remains unchanged
        end
    end
endmodule
