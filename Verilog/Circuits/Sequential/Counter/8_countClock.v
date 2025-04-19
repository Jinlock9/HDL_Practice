/*
Create a set of counters suitable for use as a 12-hour clock (with am/pm indicator). Your counters are clocked by a fast-running clk, with a pulse on ena whenever your clock should increment (i.e., once per second).
reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM. hh, mm, and ss are two BCD (Binary-Coded Decimal) digits each for hours (01-12), minutes (00-59), and seconds (00-59). Reset has higher priority than enable, and can occur even when not enabled.
*/

module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

    wire ena_m = (ss == 8'h59);
    wire ena_h = (mm == 8'h59 && ss == 8'h59);

    // PM toggles on 11:59:59
    wire toggle_pm = (hh == 8'h11 && mm == 8'h59 && ss == 8'h59);

    // Synchronous PM logic
    always @(posedge clk) begin
        if (reset)
            pm <= 1'b0;
        else if (toggle_pm)
            pm <= ~pm;
    end

    counter60 count_s (clk, reset, ena, ss);
    counter60 count_m (clk, reset, ena_m, mm);
    counter12 count_h (clk, reset, ena_h, hh);

endmodule

// 00 to 59 BCD Counter
module counter60 (
    input clk,
    input reset,
    input ena,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 8'h00;
        else if (ena) begin
            if (q[3:0] == 4'h9) begin
                if (q[7:4] == 4'h5)
                    q <= 8'h00;
                else
                    q <= {q[7:4] + 4'h1, 4'h0};
            end else begin
                q <= q + 8'h01;
            end
        end
    end
endmodule

// 01 to 12 BCD Counter
module counter12 (
    input clk,
    input reset,
    input ena,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 8'h12; // 12:00:00 on reset
        else if (ena) begin
            if (q == 8'h12)
                q <= 8'h01;        // 12 → 01
            else if (q[3:0] == 4'h9)
                q <= {q[7:4] + 4'h1, 4'h0};
            else
                q <= q + 8'h01;
        end
    end
endmodule
