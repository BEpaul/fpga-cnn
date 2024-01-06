module systolic_three_by_three_module(
  input [7:0] input11, input12, input13, input14, input21, input22, input23,
  input24, input31, input32, input33, input34, input41, input42, input43, input44,
  input [7:0] filter11, filter12, filter13, filter21, filter22, filter23, filter31, filter32, filter33,
  input clk, rst, 
  output reg [7:0] result11, result12, result21, result22
  );

  parameter ZERO = 8'd0; // 8-bit zero
  parameter NEEDED_CYCLES = 4'd11; // 11 clock cycles needed for the 2 x 2 systolic array

  wire [7:0] in1[0:10], in2[0:10], in3[0:10], fil1[0:10], fil2[0:10], fil3[0:10]; // input values from inputs and filters
  reg [7:0] row_a, row_b, row_c, col_a, col_b, col_c; // register for entrance of inputs and filters
  wire [7:0] res_pe1, res_pe2, res_pe3, res_pe4; // a result through PE calculation
  wire [7:0] temp_row11, temp_row12, temp_row21, temp_row22, temp_row31, temp_row32, temp_col11, temp_col12, temp_col13, temp_col21, temp_col22, temp_col23; // temporary storage for a and b
  reg [4:0] cnt; // counter for timing prediction

  // Assigning values to inputs and filter in order to calculate the output
  assign in1[0] = input11; assign in1[1] = input12; assign in1[2] = input13; assign in1[3] = input21;
  assign in1[4] = input22; assign in1[5] = input23; assign in1[6] = input31; assign in1[7] = input32;
  assign in1[8] = input33; assign in1[9] = ZERO; assign in1[10] = ZERO;

  assign in2[0] = ZERO; assign in2[1] = input12; assign in2[2] = input13; assign in2[3] = input14;
  assign in2[4] = input22; assign in2[5] = input23; assign in2[6] = input24; assign in2[7] = input32;
  assign in2[8] = input33; assign in2[9] = input34; assign in2[10] = ZERO;

  assign in3[0] = ZERO; assign in3[1] = filter33; assign in3[2] = filter32; assign in3[3] = filter31;
  assign in3[4] = filter23; assign in3[5] = filter22; assign in3[6] = filter21; assign in3[7] = filter13;
  assign in3[8] = filter12; assign in3[9] = filter11; assign in3[10] = ZERO;

  assign fil1[0] = filter33; assign fil1[1] = filter32; assign fil1[2] = filter31; assign fil1[3] = filter23;
  assign fil1[4] = filter22; assign fil1[5] = filter21; assign fil1[6] = filter13; assign fil1[7] = filter12;
  assign fil1[8] = filter11; assign fil1[9] = ZERO; assign fil1[10] = ZERO;

  assign fil2[0] = input21; assign fil2[1] = input22; assign fil2[2] = input23; assign fil2[3] = input31;
  assign fil2[4] = input32; assign fil2[5] = input33; assign fil2[6] = input41; assign fil2[7] = input42;
  assign fil2[8] = input43; assign fil2[9] = ZERO; assign fil2[10] = ZERO;

  assign fil3[0] = ZERO; assign fil3[1] = input22; assign fil3[2] = input23; assign fil3[3] = input24;
  assign fil3[4] = input32; assign fil3[5] = input33; assign fil3[6] = input34; assign fil3[7] = input42;
  assign fil3[8] = input43; assign fil3[9] = input44; assign fil3[10] = ZERO;

  // PE modules for processing
  pe_module PE1(.a(row_a), .b(col_a), .clk(clk), .rst(rst), .out(res_pe1), .out_a(temp_row11), .out_b(temp_col11));
  pe_module PE2(.a(temp_row11), .b(col_b), .clk(clk), .rst(rst), .out(), .out_a(temp_row12), .out_b(temp_col12));
  pe_module PE3(.a(temp_row12), .b(col_c), .clk(clk), .rst(rst), .out(), .out_a(), .out_b(temp_col13));
  pe_module PE4(.a(row_b), .b(temp_col11), .clk(clk), .rst(rst), .out(res_pe2), .out_a(temp_row21), .out_b(temp_col21));
  pe_module PE5(.a(temp_row21), .b(temp_col12), .clk(clk), .rst(rst), .out(), .out_a(temp_row22), .out_b(temp_col22));
  pe_module PE6(.a(temp_row22), .b(temp_col13), .clk(clk), .rst(rst), .out(), .out_a(), .out_b(temp_col23));
  pe_module PE7(.a(row_c), .b(temp_col21), .clk(clk), .rst(rst), .out(), .out_a(temp_row31), .out_b());
  pe_module PE8(.a(temp_row31), .b(temp_col22), .clk(clk), .rst(rst), .out(res_pe3), .out_a(temp_row32), .out_b());
  pe_module PE9(.a(temp_row32), .b(temp_col23), .clk(clk), .rst(rst), .out(res_pe4), .out_a(), .out_b());
  
  // On each clock rise
  always @(posedge clk or posedge rst)
  begin
    if(rst)
      begin
        cnt <= ZERO;
        row_a <= ZERO;
        row_b <= ZERO;
        row_c <= ZERO;
        col_a <= ZERO;
        col_b <= ZERO;
        col_c <= ZERO;
      end
    else
    begin
      if (cnt <= NEEDED_CYCLES)
        begin
        cnt <= cnt + 1;
        row_a <= in1[cnt];
        row_b <= in2[cnt];
        row_c <= in3[cnt]; 
        col_a <= fil1[cnt];
        col_b <= fil2[cnt];
        col_c <= fil3[cnt];
        end
      else
        begin
        row_a <= ZERO;
        row_b <= ZERO;
        row_c <= ZERO;
        col_a <= ZERO;
        col_b <= ZERO;
        col_c <= ZERO;
        end
     end
  end

  always @(rst or res_pe1 or res_pe2 or res_pe3 or res_pe4)
  begin
    if(rst)
      begin
        result11 <= ZERO;
        result12 <= ZERO;
        result21<= ZERO;
        result22<= ZERO;
      end
    else
      begin
        result11 <= res_pe1;
        result12 <= res_pe2;
        result21 <= res_pe3;
        result22 <= res_pe4;
      end
  end
  
  
endmodule