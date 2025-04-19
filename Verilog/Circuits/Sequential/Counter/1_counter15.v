module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        if (reset)
            q <= 4'h0;
        else begin
            if (q == 4'hf)
                q <= 4'h0;
            else 
                q <= q + 4'h1;
        end
    end
endmodule

module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	always @(posedge clk)
		if (reset)
			q <= 0;
		else
			q <= q+1;		// Because q is 4 bits, it rolls over from 15 -> 0.
		// If you want a counter that counts a range different from 0 to (2^n)-1, 
		// then you need to add another rule to reset q to 0 when roll-over should occur.
	
endmodule
