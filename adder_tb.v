`timescale 1ns / 1ps

`define summand_width1=6;
`define summand_width2=5;
`define result_width=5;

module adder_tb;
parameter in1w = 6;
parameter in2w = 5;
parameter outw = 5;
	reg [in1w-1:0] in1;
	reg [in2w-1:0] in2;
	wire  [outw-1:0] out;



adder  /*#(.summand_width1(in1w),.summand_width2(in2w), .result_width(outw))*/ add1 (.in1(in1),
		   .in2(in2),
		   .out(out));
	
	
		   
initial begin
  in1 = 8'h55;
  in2 = 8'h01;
   #10;
  in1 = 8'h55;
  in2 = 8'hAA;
   #10;
  in1 = 8'h55;
  in2 = 8'hAB;
   #10;
  in1 = 8'h99;
  in2 = 8'h05;
   #10;
  in1 = 8'h99;
  in2 = 8'h67;
   #10;
  in1 = 8'h99;
  in2 = 8'h66;
   #10;
end
endmodule