module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z 
); 
    wire [7:0] Q;
    wire [2:0] Index;
    assign Index = {A, B, C};  // Fixed: Use concatenation, not addition
    assign Z = Q[Index];
    
    dflipflop dff0 (clk, enable, S,    Q[0]);
    dflipflop dff1 (clk, enable, Q[0], Q[1]);
    dflipflop dff2 (clk, enable, Q[1], Q[2]);
    dflipflop dff3 (clk, enable, Q[2], Q[3]);
    dflipflop dff4 (clk, enable, Q[3], Q[4]);
    dflipflop dff5 (clk, enable, Q[4], Q[5]);
    dflipflop dff6 (clk, enable, Q[5], Q[6]);
    dflipflop dff7 (clk, enable, Q[6], Q[7]);

endmodule


module dflipflop (
    input clk,
    input enable,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        if (enable)
            Q <= D;
    end
endmodule

module top_module (
	input clk,
	input enable,
	input S,
	
	input A, B, C,
	output reg Z
);

	reg [7:0] q;
	
	// The final circuit is a shift register attached to a 8-to-1 mux.
	


	// Create a 8-to-1 mux that chooses one of the bits of q based on the three-bit number {A,B,C}:
	// There are many other ways you could write a 8-to-1 mux
	// (e.g., combinational always block -> case statement with 8 cases).
	assign Z = q[ {A, B, C} ];



	// Edge-triggered always block: This is a standard shift register (named q) with enable.
	// When enabled, shift to the left by 1 (discarding q[7] and and shifting in S).
	always @(posedge clk) begin
		if (enable)
			q <= {q[6:0], S};	
	end
	
	
	
endmodule
