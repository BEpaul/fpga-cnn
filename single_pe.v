
module single_pe(input11, input12, input13, input14, 
  input21, input22, input23, input24, 
  input31, input32, input33, input34, 
  input41, input42, input43, input44,
  filter11, filter12, filter13, 
  filter21, filter22, filter23, 
  filter31, filter32, filter33, clk, rst,
  result11, result12, result21, result22);


 input[7:0] input11, input12, input13, input14, 
  input21, input22, input23, input24, 
  input31, input32, input33, input34, 
  input41, input42, input43, input44,
  filter11, filter12, filter13, 
  filter21, filter22, filter23, 
  filter31, filter32, filter33;

  input clk, rst;
  output reg [7:0] result11, result12, result21, result22;
  
  reg rst_pe;
  reg [1:0] buff;
  
  wire [7:0] f[2:0][2:0];
  wire [7:0] in[0:3][0:3];
  reg [7:0] a_pe, b_pe;
  wire [7:0] out;

  assign {in[0][0], in[0][1], in[0][2], in[0][3]} = {input11, input12, input13, input14};
  assign {in[1][0], in[1][1], in[1][2], in[1][3]} = {input21, input22, input23, input24};
  assign {in[2][0], in[2][1], in[2][2], in[2][3]} = {input31, input32, input33, input34};
  assign {in[3][0], in[3][1], in[3][2], in[3][3]} = {input41, input42, input43, input44};

  assign {f[2][2], f[2][1], f[2][0]} = {filter11, filter12, filter13};
  assign {f[1][2], f[1][1], f[1][0]} = {filter21, filter22, filter23};
  assign {f[0][2], f[0][1], f[0][0]} = {filter31, filter32, filter33};
  
  
  integer count;
  
  pe_module single_pe(.a(a_pe), .b(b_pe), .clk(clk), .rst(rst_pe), .out(out), .out_a(),.out_b());
  
  always @(posedge clk, posedge rst)
  begin
    if(rst == 1'b1)
      begin
        rst_pe <= 1'b1;
        count <= 10'd0;
        result11 <= 10'd0; result12 <= 10'd0; result21 <=10'd0; result22 <= 10'd0;
        a_pe <= 8'd0; b_pe<= 8'd0;
        buff <= 2'b00;
      end
    else
      begin
      if (buff == 2'b10)
        buff = buff -1;
      else if(buff == 2'b01)
        begin
            case(count/9)
              1: result11 = out;
              2: result12 = out;
              3: result21 = out;
              4: result22 = out;
            endcase
            a_pe=8'd0; b_pe= 8'd0;
            rst_pe = 1'b1;
            buff = buff-1;
        end
      else if(rst_pe== 1'b1)
          rst_pe = 1'b0;
      else
        begin
          case(count)
          0:
            begin
              a_pe = in[0][0]; 
              b_pe = f[0][0];
            end
          1:
            begin
              a_pe = in[0][1]; 
              b_pe = f[0][1];
            end
          2:
            begin
              a_pe = in[0][2]; 
              b_pe = f[0][2];
            end
          3:
            begin
              a_pe = in[1][0]; 
              b_pe = f[1][0];
            end
          4:
            begin
              a_pe = in[1][1]; 
              b_pe = f[1][1];
            end
          5:
            begin
              a_pe = in[1][2]; 
              b_pe = f[1][2];
            end
          6:
            begin
              a_pe = in[2][0]; 
              b_pe = f[2][0];
            end
          7:
            begin
              a_pe = in[2][1]; 
              b_pe = f[2][1];
            end
          8:
            begin
              a_pe = in[2][2]; 
              b_pe = f[2][2]; //result11
            end
          9:
            begin
              a_pe = in[0][1]; 
              b_pe = f[0][0];
            end
          10:
            begin
              a_pe = in[0][2]; 
              b_pe = f[0][1];
            end
          11:
            begin
              a_pe = in[0][3]; 
              b_pe = f[0][2];
            end
          12:
            begin
              a_pe = in[1][1]; 
              b_pe = f[1][0];
            end
          13:
            begin
              a_pe = in[1][2]; 
              b_pe = f[1][1];
            end
          14:
            begin
              a_pe = in[1][3]; 
              b_pe = f[1][2];
            end
          15:
            begin
              a_pe = in[2][1]; 
              b_pe = f[2][0];
            end
          16:
            begin
              a_pe = in[2][2]; 
              b_pe = f[2][1];
            end
          17:
            begin
              a_pe = in[2][3]; 
              b_pe = f[2][2]; //result12
            end
          18:
            begin
              a_pe = in[1][0]; 
              b_pe = f[0][0];
            end
          19:
            begin
              a_pe = in[1][1]; 
              b_pe = f[0][1];
            end
          20:
            begin
              a_pe = in[1][2]; 
              b_pe = f[0][2];
            end
          21:
            begin
              a_pe = in[2][0]; 
              b_pe = f[1][0];
            end
          22:
            begin
              a_pe = in[2][1]; 
              b_pe = f[1][1];
            end
          23:
            begin
              a_pe = in[2][2]; 
              b_pe = f[1][2];
            end
          24:
            begin
              a_pe = in[3][0]; 
              b_pe = f[2][0];
            end
          25:
            begin
              a_pe = in[3][1]; 
              b_pe = f[2][1];
            end
          26:
            begin
              a_pe = in[3][2]; 
              b_pe = f[2][2]; //result21
            end
          27:
            begin
              a_pe = in[1][1]; 
              b_pe = f[0][0];
            end
          28:
            begin
              a_pe = in[1][2]; 
              b_pe = f[0][1];
            end
          29:
            begin
              a_pe = in[1][3]; 
              b_pe = f[0][2];
            end
          30:
            begin
              a_pe = in[2][1]; 
              b_pe = f[1][0];
            end
          31:
            begin
              a_pe = in[2][2]; 
              b_pe = f[1][1];
            end
          32:
            begin
              a_pe = in[2][3]; 
              b_pe = f[1][2];
            end
          33:
            begin
              a_pe = in[3][1]; 
              b_pe = f[2][0];
            end
          34:
            begin
              a_pe = in[3][2]; 
              b_pe = f[2][1];
            end
          35:
            begin
              a_pe = in[3][3]; 
              b_pe = f[2][2]; //result22
            end
         
          endcase     
         count = count + 1;
         if (count != 1'b0 && count % 9 == 0)
           buff <= 2'b10;
        end   
      end
    end
endmodule
