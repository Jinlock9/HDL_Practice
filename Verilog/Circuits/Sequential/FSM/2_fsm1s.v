module top_module(clk, reset, in, out);
    input clk;
    input reset;
    input in;
    output out;
    reg out;

    reg present_state, next_state;
    
    // State transition logic
    always @(*) begin
        case (present_state)
            1'b0: next_state = in ? 1'b0 : 1'b1;
            1'b1: next_state = in ? 1'b1 : 1'b0;
        endcase
    end

    // Sequential state update with synchronous reset
    always @(posedge clk) begin
        if (reset)
            present_state <= 1'b1; // Reset to B
        else
            present_state <= next_state;
    end
    
    assign out = present_state;
endmodule
