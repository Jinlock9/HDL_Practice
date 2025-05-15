module top_module(
    input clk,
    input in,
    input reset,
    output out
); 

    parameter A=0, B=1, C=2, D=3;
    reg [3:0] state, state_next;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: state_next = in ? B : A;
            B: state_next = in ? B : C;
            C: state_next = in ? D : A;
            D: state_next = in ? B : C;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= state_next;
    end
    
    // Output logic
    assign out = state == D;

endmodule
