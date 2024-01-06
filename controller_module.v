/*
-------------------------------------------------------------------------
Module Name: controller_module

Module Explanation:
- Uses moore machine for control flow 
- Initializes the memory module, computation module, and display module.
- Controls all the modules above by output.

Module Input
- clk: system clock
- rst: global reset given from the top module

Module Output
- enable_memory: decides the operation of memory module.
  if 1, reset stored data in memory.
  if 0, save input data in memory.
- enable_compute: decides the operation of computation module
  if 1, reset all calculation outputs to 0.
  if 0, send calculation result to output.
- enable_display: decides the operation of display module
  if 1, reset values needed for display to 0.
  if 0, activate values needed for display.

Last Update: 2024/01/02
- changed time interval to 40, 50, 200
-------------------------------------------------------------------------
*/

module controller_module(input clk, input rst, 
output reg enable_memory, output reg enable_compute, 
output reg enable_display);

  reg [1:0] state;
  reg [1:0] next_state;
  reg [9:0] cnt;
  
  // Declaring state parameters for the Moore Machine
  // RESET_STATE: Initial RESET STATE
  // S0: Memory State
  // S1: Computation State
  // S2: Display State 
  parameter RESET_STATE = 0, S0 = 1, S1 = 2, S2 = 3;
  
  // Determining transition from current state to next_state
  always @ (clk or rst)
  begin
    //(changed) time interval to 40, 50, 200
    case(state)
      RESET_STATE:
      begin
        next_state <= (cnt == 10'd40) ? S0 : RESET_STATE;        
      end
      S0: // Memory State
      begin
        next_state <= (cnt == 10'd50) ? S1 : S0;
      end
      S1: // Computation State
      begin
        next_state <= (cnt == 10'd200) ? S2 : S1;
      end
      S2: // Display State
      begin
        next_state <= S2;
      end
      default: // default state in case of unexpected input
      begin
        next_state <= RESET_STATE;
      end
    endcase
  end
    
  // Updating current state to next_state
  always @ (posedge rst or posedge clk)
  begin
    if(rst) // rst==1, reset on
    begin
        state <= RESET_STATE;
        cnt <= 10'd0;
    end
    else // rst==0, reset off, transition to next state
    begin
      state <= next_state;
      cnt <= cnt + 10'd10;
    end   
  end

  // Determining output based on current state
  always @(state)
  begin
    case (state)
      RESET_STATE: // initial reset state
      begin
       enable_memory = 1;
       enable_compute = 1;
       enable_display = 1;
      end
      S0: // enable memory
      begin 
       enable_memory = 0;
       enable_compute = 1;
       enable_display = 1;
      end
      S1: // enable computation
      begin
       enable_memory = 0;
       enable_compute = 0;
       enable_display = 1;
      end
      S2: // enable display
      begin
       enable_memory = 0;
       enable_compute = 0;
       enable_display = 0;
      end
    endcase
  end

endmodule
  