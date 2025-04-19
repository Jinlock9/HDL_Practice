module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);
    
    always @(posedge clk) begin
        if (reset)
            q <= 4'h0;
        else begin
            if (slowena) begin
                if (q == 4'h9)
                    q <= 4'h0;
                else 
                    q <= q + 4'h1;
            end
        end
    end

endmodule
