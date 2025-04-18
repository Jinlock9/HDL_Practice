module top_module (
    input clk,
    input x,
    output z
); 
    
    reg q0, q1, q2;
    reg nq0, nq1, nq2;
    wire d0, d1, d2;
    
    assign d0 = x ^ q0;
    assign d1 = x & nq1;
    assign d2 = x | nq2;
    
    m_dff dff0 (clk, d0, q0, nq0);
    m_dff dff1 (clk, d1, q1, nq1);
    m_dff dff2 (clk, d2, q2, nq2);
    
    assign z = ~ (q0 | q1 | q2);

endmodule

module m_dff (
    input clk,
    input d,
    output reg q, 
    output nq
);
    
    always @(posedge clk) begin
        q <= d;
    end
    
    assign nq = ~q;
    
endmodule
