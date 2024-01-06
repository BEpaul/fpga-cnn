`timescale 1ns/1ns

module tb_three_by_three;
  reg clk;
  reg rst; 
  reg[7:0] input11, input12, input13, input14, input21, input22, input23, input24, 
  input31, input32, input33, input34, input41, input42, input43, input44,
  filter11, filter12, filter13, filter21, filter22, filter23, filter31, filter32, filter33;
  
  wire [7:0] result11, result12, result21, result22;
  


  systolic_three_by_three_module sys_three_by_three(
    .input11(input11), .input12(input12), .input13(input13), .input14(input14),
    .input21(input21), .input22(input22), .input23(input23), .input24(input24),
    .input31(input31), .input32(input32), .input33(input33), .input34(input34),
    .input41(input41), .input42(input42), .input43(input43), .input44(input44),
    .filter11(filter11), .filter12(filter12), .filter13(filter13),
    .filter21(filter21), .filter22(filter22), .filter23(filter23),
    .filter31(filter31), .filter32(filter32), .filter33(filter33),
    .clk(clk), .rst(rst),
    .result11(result11), .result12(result12), .result21(result21), .result22(result22)
    );
  
  initial
  begin
      input11 = 8'd10; input12 = 8'd5; input13 = 8'd1; input14 = 8'd4;
      input21 = 8'd6; input22 = 8'd0; input23 = 8'd12; input24 = 8'd15;
      input31 = 8'd3; input32 = 8'd8; input33 = 8'd0; input34 = 8'd9;
      input41 = 8'd11; input42 = 8'd16; input43 = 8'd25; input44 = 8'd7;

      filter11 = 8'd1; filter12 = 8'd5; filter13 = 8'd3;
      filter21 = 8'd4; filter22 = 8'd0; filter23 = 8'd10;
      filter31 = 8'd0; filter32 = 8'd7; filter33 = 8'd15;
      
      rst = 1'b1; clk = 1'b0;
  end
  
  initial
  begin
        forever
        begin
          #10 clk = !clk;
        end
  end

  initial
  begin
        #50 rst = 1'b0;
        #480 rst = 1'b1;

        #20 rst = 1'b0;
        #400 rst = 1'b1;
  end

endmodule