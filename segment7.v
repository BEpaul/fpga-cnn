module segment7 (
    clk, rst, in, digit, out
);

    input clk, rst;                    // Clock and Reset inputs
    input [7:0] in;                    // Input data for the seven-segment display
    output [7:0] out, digit;            // Output for the seven-segment display and digit indicator

    reg [3:0] segmentNumber;            // Selected digit for the seven-segment display
    reg [7:0] inputNumber;              // Input data for processing
    reg [20:0] count;                   // Counter for sequencing operations
    reg [7:0] digit;
    reg [7:0] out;
    wire [1:0] flag;                    // Flag to determine the operation phase

    // Clock edge detection
    always @(posedge clk) begin
        inputNumber = in;               // Capture the input data at each clock edge
        if (rst == 1'b1) begin
            count <= 0;                  // Reset the counter if the reset signal is active
        end else begin
            count <= count + 1;          // Increment the counter during normal operation
        end
    end

    // Generate flag based on counter value
    assign flag = count[19:18];

    // Seven-segment digit assignment
    always @ (*) begin
        if (flag == 2'b00) begin
            digit = 8'b00000000;  // Set digit indicator for the default case
        end else if (flag == 2'b01) begin
            digit = 8'b00000100;         // Set digit indicator for the first phase
            segmentNumber = inputNumber / 100;  // Extract hundreds digit
        end else if (flag == 2'b10) begin
            digit = 8'b00000010;         // Set digit indicator for the second phase
            segmentNumber = (inputNumber % 100) / 10;  // Extract tens digit
        end else if (flag == 2'b11) begin
            digit = 8'b00000001;         // Set digit indicator for the third phase
            segmentNumber = (inputNumber % 100) % 10;  // Extract units digit
        end

    end

    // Seven-segment display logic
    always @ (*) begin
        case(segmentNumber)
            4'b0000: out = 8'b00111111;  // Display 0
            4'b0001: out = 8'b00000110;  // Display 1
            4'b0010: out = 8'b01011011;  // Display 2
            4'b0011: out = 8'b01001111;  // Display 3
            4'b0100: out = 8'b01100110;  // Display 4
            4'b0101: out = 8'b01101101;  // Display 5
            4'b0110: out = 8'b01111101;  // Display 6
            4'b0111: out = 8'b00100111;  // Display 7
            4'b1000: out = 8'b01111111;  // Display 8
            4'b1001: out = 8'b01101111;  // Display 9
            default: out = 8'b00000000;  // Handle default case

        endcase
    end

endmodule
