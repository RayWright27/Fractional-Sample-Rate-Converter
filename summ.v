`timescale 1ns / 1ps
//parameter summand_width1=4;
//parameter summand_width2=4;
//parameter result_width=4;
module adder
			(input wire [summand_width1-1:0] in1,
			 input wire [summand_width2-1:0] in2,
			 output wire [result_width-1:0] out);
			 
			 parameter summand_width1=2;
			 parameter summand_width2=2;
			 parameter result_width=2;

			 assign out = in1 + in2;
endmodule
