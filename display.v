module display_module(
    clk, rst, cell_3x3_11, cell_3x3_12, cell_3x3_21, cell_3x3_22, cell_2x2_11, cell_2x2_12, cell_2x2_21, cell_2x2_22, digit, out
);

    input clk, rst;                         // Clock and Reset inputs
    input [7:0] cell_3x3_11, cell_3x3_12,   // 3x3 Cell inputs
               cell_3x3_21, cell_3x3_22,
               cell_2x2_11, cell_2x2_12,   // 2x2 Cell inputs
               cell_2x2_21, cell_2x2_22;
    
    output [7:0] digit, out;                  // Output for digit and segment display

    reg [29:0] count;                        // Counter for sequencing cells
    reg [3:0] cellNum;                       // Selected cell number
    wire [7:0] cellWire [0:7];               // Array to hold cell values

    // Cell connection
    assign cellWire[0] = cell_3x3_11;
    assign cellWire[1] = cell_3x3_12;
    assign cellWire[2] = cell_3x3_21;
    assign cellWire[3] = cell_3x3_22;
    assign cellWire[4] = cell_2x2_11;
    assign cellWire[5] = cell_2x2_12;
    assign cellWire[6] = cell_2x2_21;
    assign cellWire[7] = cell_2x2_22;

    // Counter logic
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            count <= 30'b0;
            cellNum <= 4'd0;
        end else begin
            if (count == 29'b11111111111111111111111111111) begin
                count <= count;  // Maintain the counter value at its maximum
                cellNum <= 4'd7; // Fix cellNum to 4'd7 when count reaches the maximum
            end else begin
                count <= count + 1;  // Increment the counter
                cellNum <= count[28:26];
            end
        end
    end

    // Instantiate the segment7 module
    segment7 segment7(
        .clk(clk),
        .rst(rst),
        .in(cellWire[cellNum]),
        .digit(digit),
        .out(out)
    );

endmodule
