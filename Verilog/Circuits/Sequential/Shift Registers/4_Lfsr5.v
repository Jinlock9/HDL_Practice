module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output reg [4:0] q
); 
    
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1;
        else
            q <= {0 ^ q[0], q[4], q[3] ^ q[0], q[2], q[1]};
    end

endmodule

module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] q_next;		

	always @(*) begin
		q_next = q[4:1];	// Shift all the bits. This is incorrect for q_next[4] and q_next[2]
		q_next[4] = q[0];	// Give q_next[4] and q_next[2] their correct assignments
		q_next[2] = q[3] ^ q[0];
	end
	
	
	always @(posedge clk) begin
		if (reset)
			q <= 5'h1;
		else
			q <= q_next;
	end
	
endmodule
