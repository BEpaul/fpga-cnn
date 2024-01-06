module systolic_two_by_two_module(
  input [7:0] input11, input12, input13, input14, input21, input22, input23,
  input24, input31, input32, input33, input34, input41, input42, input43, input44,
  input [7:0] filter11, filter12, filter13, filter21, filter22, filter23, filter31, filter32, filter33,
  input clk, rst, 
  output reg [7:0] result11, result12, result21, result22
  );
  
  parameter ZERO = 8'd0; // 8-bit zero
  parameter NEEDED_CYCLES = 4'd14; // 14 clock cycles needed for the 2 x 2 systolic array calculation

  wire [7:0] in1[0:13], in2[0:13], fil1[0:13], fil2[0:13]; // input values from inputs and filters
  reg [7:0] row_a, row_b, col_a, col_b; // register for entrance of inputs and filters
  wire [7:0] res_pe1, res_pe2, res_pe3, res_pe4; // a result through PE calculation
  wire [7:0] temp_row11, temp_row21, temp_col11, temp_col12; // temporary storage for a and b
  reg [4:0] cnt; // counter for timing prediction

  // Assigning values to inputs and filter in order to calculate the output
  assign in1[0] = input11; assign in1[1] = input12; assign in1[2] = input13; assign in1[3] = input14;
  assign in1[4] = input21; assign in1[5] = input22; assign in1[6] = input23; assign in1[7] = input24;
  assign in1[8] = input31; assign in1[9] = input32; assign in1[10] = input33; assign in1[11] = input34;
  assign in1[12] = ZERO; assign in1[13] = ZERO;

  assign in2[0] = ZERO; assign in2[1] = input21; assign in2[2] = input22; assign in2[3] = input23;
  assign in2[4] = input24; assign in2[5] = input31; assign in2[6] = input32; assign in2[7] = input33;
  assign in2[8] = input34; assign in2[9] = input41; assign in2[10] = input42; assign in2[11] = input43;
  assign in2[12] = input44; assign in2[13] = ZERO;

  assign fil1[0] = filter33; assign fil1[1] = filter32; assign fil1[2] = filter31; assign fil1[3] = ZERO;
  assign fil1[4] = filter23; assign fil1[5] = filter22; assign fil1[6] = filter21; assign fil1[7] = ZERO;
  assign fil1[8] = filter13; assign fil1[9] = filter12; assign fil1[10] = filter11;
  assign fil1[11] = ZERO; assign fil1[12] = ZERO; assign fil1[13] = ZERO;

  assign fil2[0] = ZERO; assign fil2[1] = ZERO; assign fil2[2] = filter33; assign fil2[3] = filter32;
  assign fil2[4] = filter31; assign fil2[5] = ZERO; assign fil2[6] = filter23; assign fil2[7] = filter22;
  assign fil2[8] = filter21; assign fil2[9] = ZERO; assign fil2[10] = filter13; assign fil2[11] = filter12;
  assign fil2[12] = filter11; assign fil2[13] = ZERO;

  // PE modules for processing
  pe_module PE1(.a(row_a), .b(col_a), .clk(clk), .rst(rst), .out(res_pe1), .out_a(temp_row11), .out_b(temp_col11));
  pe_module PE2(.a(temp_row11), .b(col_b), .clk(clk), .rst(rst), .out(res_pe2), .out_a(), .out_b(temp_col12));
  pe_module PE3(.a(row_b), .b(temp_col11), .clk(clk), .rst(rst), .out(res_pe3), .out_a(temp_row21), .out_b());
  pe_module PE4(.a(temp_row21), .b(temp_col12), .clk(clk), .rst(rst), .out(res_pe4), .out_a(), .out_b());

  // On each clock rise
  always @(posedge clk or posedge rst)
  begin
    if(rst)
      begin
        cnt <= ZERO;
        row_a <= ZERO;
        row_b <= ZERO;
        col_a <= ZERO;
        col_b <= ZERO;
      end
    else
    begin
      if (cnt <= NEEDED_CYCLES)
        begin
        cnt <= cnt + 1;
        row_a <= in1[cnt];
        row_b <= in2[cnt];
        col_a <= fil1[cnt];
        col_b <= fil2[cnt];
        end
      else
        begin
        row_a <= ZERO;
        row_b <= ZERO;
        col_a <= ZERO;
        col_b <= ZERO;
        end
    end
  end
  
  always @(rst or res_pe1 or res_pe2 or res_pe3 or res_pe4)
  begin
    if(rst)
      begin
        result11 <= ZERO;
        result12 <= ZERO;
        result21 <= ZERO;
        result22 <= ZERO;
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