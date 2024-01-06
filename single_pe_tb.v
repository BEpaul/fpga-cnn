`timescale 1ns/1ns

module tb_single_pe;
	//clock
	reg CLK;
  reg RST; 
  reg[7:0] IN11, IN12, IN13, IN14, 
  IN21, IN22, IN23, IN24, 
  IN31, IN32, IN33, IN34, 
  IN41, IN42, IN43, IN44,
  F11, F12, F13, 
  F21, F22, F23, 
  F31, F32, F33;
  
  wire [7:0] RES11, RES12, RES21, RES22;
  
  single_pe single_pe(.in11(IN11), .in12(IN12), .in13(IN13), .in14(IN14),
    .in21(IN21), .in22(IN22), .in23(IN23), .in24(IN24),
    .in31(IN31), .in32(IN32), .in33(IN33), .in34(IN34),
    .in41(IN41), .in42(IN42), .in43(IN43), .in44(IN44),
    .filter11(F11), .filter12(F12), .filter13(F13),
    .filter21(F21), .filter22(F22), .filter23(F23),
    .filter31(F31), .filter32(F32), .filter33(F33),
    .clk(CLK), .rst(RST),
    .res11(RES11), .res12(RES12), .res21(RES21), .res22(RES22));
  
	initial
	begin
    		IN11 = 8'd1; IN12 = 8'd2; IN13 = 8'd3; IN14 = 8'd4;
        IN21 = 8'd5; IN22 = 8'd6; IN23 = 8'd7; IN24 = 8'd8;
        IN31 = 8'd9; IN32 = 8'd10; IN33 = 8'd11; IN34 = 8'd12;
        IN41 = 8'd13; IN42 = 8'd14; IN43 = 8'd15; IN44 = 8'd16;
        F11 = 8'd17; F12 = 8'd18; F13 = 8'd19;
        F21 = 8'd20; F22 = 8'd21; F23 = 8'd22;
        F31 = 8'd23; F32 = 8'd24; F33 = 8'd25;
		    RST = 1'b1;
		    CLK = 1'b0;
	end
	
	  initial
	begin
		 forever
		 begin
			#10 CLK = !CLK;
		 end
	end

  initial
  begin
		#10 RST = 1'b0;
		#1000 RST = 1'b1;
    #10 RST = 1'b0;
    #1000 RST = 1'b1;
    #10 RST = 1'b0;
	end

endmodule
