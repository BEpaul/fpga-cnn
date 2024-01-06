
`timescale 1ns/1ns

module tb_pe;
  reg [7:0] A,B;
  reg CLK;
  reg RST;
  wire [7:0] OUT;
  wire [7:0] OUT_A, OUT_B;
  
  //instantiation
  PE_module PE1(.a(A), .b(B), .clk(CLK), .rst(RST), .out(OUT), .out_a(OUT_A), .out_b(OUT_B));
  
  
  initial
  begin
		 forever
		 begin
			#10 CLK = !CLK;
		 end
	end
		 
	initial 
		 begin
		 CLK = 1'b0;
		 RST = 1'b1;
		 end
	
	initial
	 begin
		 #20 RST = 1'b0; 
		 	 A = 8'd2; B = 8'd1;
		 #20 A = 8'd7; B = 8'd1;
		 #20 A = 8'd4; B = 8'd1;
		 #20 A = 8'd5; B = 8'd3;
		 #20 A = 8'd4; B = 8'd1;
		 #20 A = 8'd4; B = 8'd0;
		 #20 A = 8'd8; B = 8'd4;
		 #20 A = 8'd7; B = 8'd2;
		 #20 A = 8'd2; B = 8'd2;

	end
		 
  

  
endmodule
