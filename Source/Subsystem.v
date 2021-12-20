`timescale 1 ns / 1 ps
// -- -------------------------------------------------------------
// File Name: Subsystem.v
// Created: 2021-11-30 14:35:22
// Clock      Domain  Description
// -- -------------------------------------------------------------
// clk        1       base rate clock
// clk_1_5    2       5x slower than base rate clock
// clk_1_13   3       13x slower than base rate clock
// -- ------------------------------------------------------------- 
// Output Signal                 Clock      Domain  Sample Time
// -- -------------------------------------------------------------
// Out1                          clk_1_5    2       0.00274725
// -------------------------------------------------------------
// Module: Subsystem
// Source Path: FSRC/Subsystem
// Hierarchy Level: 0
// -------------------------------------------------------------

module Subsystem
          (input                clk,
           input            clk_1_5,
           input           clk_1_13,
           input            reset_x,
           input              reset,
           input         clk_enable,
           input  signed [12:0] In1,  // sfix13_En9
           output reg signed [12:0] Out1_reg);// sfix13_En9

  wire enable;
  wire enable_r1_1_5_1;
  wire enable_r1_1_13_1;
  wire enable_r1_1_1_1;
  wire enable_1_5_0;
  reg signed [12:0] In_reg;
  wire signed [12:0] Upsample3_zero;  // sfix13_En9
  wire signed [12:0] Upsample3_muxout;  // sfix13_En9
  reg signed [12:0] Upsample3_bypass_reg;  // sfix13
  wire signed [12:0] Upsample3_bypassout;  // sfix13_En9
  wire signed [17:0] Filter_out1;  // sfix18_En19
  reg signed [17:0] Filter_out1_1;  // sfix18_En19
  reg signed [17:0] Downsample4_out1;  // sfix18_En19
  reg signed [17:0] Downsample4_out1_1;  // sfix18_En19
  reg signed [17:0] Downsample_output;
  reg signed [17:0] Domain_cross_reg;
  reg signed [17:0] convert_reg;
  wire convert_summand_1_wire;
  reg convert_summand_1;
  wire signed [12:0] convert_summand_2_wire;
  reg signed [12:0] convert_summand_2;
  wire signed [12:0] convert_LPF_FIR_ellipt_7ord_transpos_1;  // sfix13_En9
 
  
  always@(posedge clk_1_13)begin
  	if(reset==1)begin
		In_reg<=13'sb0000000000000;
		Upsample3_bypass_reg <= 13'sb0000000000000;
    end
    else begin 
		In_reg <= In1;//Input reg
		Upsample3_bypass_reg <= Upsample3_muxout;//Upsample3_bypass_process
    end
  end 	

  always@(posedge clk)begin
  	if(reset==1)begin			
		Filter_out1_1 <= 18'sb000000000000000000;
    end
    else begin	
		Filter_out1_1 <= Filter_out1;//Delay_match_process
    end
  end
	
  always@(posedge clk_1_5) begin
	if(reset==1) begin			
		Downsample4_out1 <= 18'sb000000000000000000;
		Downsample4_out1_1 <= 18'sb000000000000000000;
		Downsample_output<=18'sb000000000000000000;
		Domain_cross_reg<=18'sb000000000000000000;
		convert_reg<=18'sb000000000000000000;
		Out1_reg<=13'sb000000000000;
		convert_summand_1<=1'b0;
	 	convert_summand_2<=13'sb000000000000;
	end
	else begin

		Downsample4_out1 <= Filter_out1_1;//Downsample4_output_process
        	Downsample4_out1_1 <= Downsample4_out1;//PipelineRegister_processFilter_out1[17:0]
		Downsample_output<=Downsample4_out1_1;
		Domain_cross_reg<=Downsample_output;
		convert_reg<=Domain_cross_reg;
		convert_summand_1<=convert_summand_1_wire;
		convert_summand_2<=convert_summand_2_wire;
		Out1_reg<=convert_LPF_FIR_ellipt_7ord_transpos_1;//for output sync
	end
  end
  Subsystem_timigcontroller_d1 Subsystem_timigcontroller_d1_2 (.clk(clk),
                                                               .clk_1_5(clk_1_5),
                                                               .clk_1_13(clk_1_13),
                                                               .reset_x(reset_x),
                                                               .clk_enable(clk_enable),
                                                               .enable(enable),
                                                               .enable_r1_1_1_1(enable_r1_1_1_1),
                                                               .enable_r1_1_5_1(enable_r1_1_5_1),
                                                               .enable_r1_1_13_1(enable_r1_1_13_1)
                                                               );

  // Upsample3: Upsample by 13, Sample offset 0 
  assign Upsample3_zero = 13'sb0000000000000;
  assign Upsample3_muxout = (enable_r1_1_13_1 == 1'b1 ? In_reg : /*In1 */
              Upsample3_zero);
  assign Upsample3_bypassout = (enable_r1_1_1_1 == 1'b1 ? Upsample3_muxout :
              Upsample3_bypass_reg);

  // <S2>/Filter
  Filter Filter_1_1 (.clk(clk),
                     .enable(enable),
                     .reset(reset),
                     .In1(Upsample3_bypassout),  // sfix13_En9
                     .Out1(Filter_out1)  // sfix18_En19
			);

  assign enable_1_5_0 = 1'b0;//delete later

  // <S2>/ Data type conversion 
  assign convert_summand_1_wire = $signed( { 1'b0, convert_reg[9] & ( ( ~ convert_reg[17]) | (|convert_reg[8:0]) ) } ); 
  assign convert_summand_2_wire = ({{5{convert_reg[17]}}, convert_reg[17:10]});
  assign convert_LPF_FIR_ellipt_7ord_transpos_1 = convert_summand_1 + convert_summand_2;
 // assign convert_LPF_FIR_ellipt_7ord_transpos_1 = ({{5{convert_reg[17]}}, convert_reg[17:10]}) + $signed( { 1'b0, convert_reg[9] & ( ( ~ convert_reg[17]) | (|convert_reg[8:0]) ) } );
 // assign convert_LPF_FIR_ellipt_7ord_transpos_1 = ({{5{Downsample4_out1_1[17]}}, Downsample4_out1_1[17:10]}) 
 //   + $signed({1'b0, Downsample4_out1_1[9] & (( ~ Downsample4_out1_1[17]) | (|Downsample4_out1_1[8:0]))});


endmodule  // Subsystem

