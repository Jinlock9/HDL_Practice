module top_module(
    input clk,
    input load,
    input  [255:0] data,
    output reg [255:0] q
);

    reg [15:0][15:0] grid;       // Current state
    reg [15:0][15:0] next_grid;  // Next state

    integer i, j, di, dj;

    // Count alive neighbors with toroidal wraparound
    function automatic [3:0] count_neighbors(input [15:0][15:0] g, input int x, input int y);
        integer nx, ny;
        count_neighbors = 0;
        for (di = -1; di <= 1; di++) begin
            for (dj = -1; dj <= 1; dj++) begin
                if (di == 0 && dj == 0) continue; // Skip self
                nx = (x + di + 16) % 16;
                ny = (y + dj + 16) % 16;
                count_neighbors += g[nx][ny];
            end
        end
    endfunction

    // Flatten and unflatten between q and grid
    task automatic from_q_to_grid(input [255:0] flat, output [15:0][15:0] mat);
        for (i = 0; i < 16; i++)
            for (j = 0; j < 16; j++)
                mat[i][j] = flat[i*16 + j];
    endtask

    task automatic from_grid_to_q(input [15:0][15:0] mat, output [255:0] flat);
        for (i = 0; i < 16; i++)
            for (j = 0; j < 16; j++)
                flat[i*16 + j] = mat[i][j];
    endtask

    always @(posedge clk) begin
        if (load) begin
            from_q_to_grid(data, grid);
            q <= data;
        end else begin
            for (i = 0; i < 16; i++) begin
                for (j = 0; j < 16; j++) begin
                    case (count_neighbors(grid, i, j))
                        2: next_grid[i][j] = grid[i][j]; // Stays the same
                        3: next_grid[i][j] = 1;          // Comes to life
                        default: next_grid[i][j] = 0;    // Dies
                    endcase
                end
            end
            grid = next_grid;
            from_grid_to_q(grid, q);
        end
    end

endmodule
