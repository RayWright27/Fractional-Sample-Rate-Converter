// -------------------------------------------------------------
// 
// File Name: max_opt\hdlsrc\FSRC\Subsystem_tb.v
// Created: 2021-11-30 14:35:36
// 
// Generated by MATLAB 9.11 and HDL Coder 3.19
// 
// 
// -- -------------------------------------------------------------
// -- Rate and Clocking Details
// -- -------------------------------------------------------------
// Model base rate: 0.000549451
// Target subsystem base rate: 0.000549451
// 
// 
// Clock      Domain  Description
// -- -------------------------------------------------------------
// clk        1       base rate clock
// clk_1_5    2       5x slower than base rate clock
// clk_1_13   3       13x slower than base rate clock
// -- -------------------------------------------------------------
// 
// Output Signal                 Clock      Domain  Sample Time
// -- -------------------------------------------------------------
// Out1                          clk_1_5    2       0.00274725
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: Subsystem_tb
// Source Path: 
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ps

module Subsystem_tb;



  reg  clk;
  reg  reset_x;
  wire clk_enable;
  reg  clk_1_5;
  wire reset_x_1_5;
  reg  clk_1_13;
  wire reset_x_1_13;
  wire clk_enable_5;
  wire Out1_done;  // ufix1
  wire Out1_done_enb;  // ufix1
  reg  check1_done;  // ufix1
  reg [15:0] Out1_addr;  // ufix16
  wire Out1_active;  // ufix1
  wire snkDonen;
  wire resetn;
  wire tb_enb;
  reg  tb_enb_delay;
  wire notDone;
  wire clock_enable_out;
  wire Out1_enb;  // ufix1
  wire Out1_lastAddr;  // ufix1
  reg [14:0] Data_Type_Conversion_out1_addr;  // ufix15
  wire Data_Type_Conversion_out1_active;  // ufix1
  wire Data_Type_Conversion_out1_enb;  // ufix1
  wire [14:0] Data_Type_Conversion_out1_addr_delay_1;  // ufix15
  reg signed [31:0] fp_In1;  // sfix32
  reg signed [12:0] In1raw;  // sfix13_En9
  reg signed [31:0] status_In1;  // sfix32
  wire signed [12:0] rawData_In1;  // sfix13_En9
  reg signed [12:0] holdData_In1;  // sfix13_En9
  reg signed [12:0] In1_offset;  // sfix13_En9
  wire signed [12:0] In1;  // sfix13_En9
  wire clk_enable_13_1;  // ufix1
  wire signed [12:0] Out1;  // sfix13_En9
  wire [15:0] Out1_addr_delay_1;  // ufix16
  reg signed [31:0] fp_Out1_expected;  // sfix32
  reg signed [12:0] Out1_expected;  // sfix13_En9
  reg signed [31:0] status_Out1_expected;  // sfix32
  reg signed [12:0] Out1_ref_hold;  // sfix13_En9
  wire signed [12:0] Out1_refTmp;  // sfix13_En9
  wire signed [12:0] Out1_ref;  // sfix13_En9
  reg  Out1_testFailure;  // ufix1
  wire testFailure;  // ufix1


  assign Out1_done_enb = Out1_done & clk_enable;
  


  assign reset_x_1_5 = reset_x;

  always 
    begin : clk_1_5_gen
      clk_1_5 <= 1'b1;
      # (25);
      clk_1_5 <= 1'b0;
      # (25);
      if (check1_done == 1'b1) begin
        clk_1_5 <= 1'b1;
        # (25);
        clk_1_5 <= 1'b0;
        # (25);
        $stop;
      end
    end

  assign Out1_active = Out1_addr != 16'b1101010101001000;



  assign snkDonen =  ~ check1_done;



  always 
    begin : clk_gen
      clk <= 1'b1;
      # (5);
      clk <= 1'b0;
      # (5);
      if (check1_done == 1'b1) begin
        clk <= 1'b1;
        # (5);
        clk <= 1'b0;
        # (5);
        $stop;
      end
    end
  //reg reset
  reg reset;
  initial begin
  	reset<=1;
  	#10
  	reset<=0;
  end
  //
  initial
    begin : reset_x_gen
      reset_x <= 1'b1;
      # (1292);
      reset_x <= 1'b0;
    end

  assign resetn =  ~ reset_x;



  assign tb_enb = resetn & snkDonen;



  // Delay inside enable generation: register depth 1
  always @(posedge clk)
    begin : u_enable_delay
      if (reset_x) begin
        tb_enb_delay <= 0;
      end
      else begin
        tb_enb_delay <= tb_enb;
      end
    end

  assign notDone = tb_enb_delay & snkDonen;



  assign clk_enable = notDone; // delay #2

  assign clock_enable_out = clk_enable & (clk_enable & tb_enb_delay);



  assign Out1_enb = clock_enable_out & Out1_active;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 54600
  always @(posedge clk_1_5)
    begin : c_3_process
      if (reset_x_1_5 == 1'b1) begin
        Out1_addr <= 16'b0000000000000000;
      end
      else begin
        if (Out1_enb) begin
          if (Out1_addr >= 16'b1101010101001000) begin
            Out1_addr <= 16'b0000000000000000;
          end
          else begin
            Out1_addr <= Out1_addr + 16'b0000000000000001;
          end
        end
      end
    end



  assign Out1_lastAddr = Out1_addr >= 16'b1101010101001000;



  assign Out1_done = Out1_lastAddr & resetn;



  // Delay to allow last sim cycle to complete
  always @(posedge clk)
    begin : checkDone_1
      if (reset_x) begin
        check1_done <= 0;
      end
      else begin
        if (Out1_done_enb) begin
          check1_done <= Out1_done;
        end
      end
    end

  always 
    begin : clk_1_13_gen
      clk_1_13 <= 1'b1;
      # (65);
      clk_1_13 <= 1'b0;
      # (65);
      if (check1_done == 1'b1) begin
        clk_1_13 <= 1'b1;
        # (65);
        clk_1_13 <= 1'b0;
        # (65);
        $stop;
      end
    end

  assign #12 clk_enable_5 = tb_enb_delay;

  assign reset_x_1_13 = reset_x;

  assign Data_Type_Conversion_out1_active = Data_Type_Conversion_out1_addr != 15'b101001000001000;



  assign Data_Type_Conversion_out1_enb = Data_Type_Conversion_out1_active & (clk_enable & tb_enb_delay);



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 21000
  always @(posedge clk_1_13)
    begin : DataTypeConversion_process
      if (reset_x_1_13 == 1'b1) begin
        Data_Type_Conversion_out1_addr <= 15'b000000000000000;
      end
      else begin
        if (Data_Type_Conversion_out1_enb) begin
          if (Data_Type_Conversion_out1_addr >= 15'b101001000001000) begin
            Data_Type_Conversion_out1_addr <= 15'b000000000000000;
          end
          else begin
            Data_Type_Conversion_out1_addr <= Data_Type_Conversion_out1_addr + 15'b000000000000001;
          end
        end
      end
    end



  assign Data_Type_Conversion_out1_addr_delay_1 = Data_Type_Conversion_out1_addr;// delay #1

  // Data source for In1
  initial
    begin : In1_fileread
      fp_In1 = $fopen("In1.dat", "r");
      status_In1 = $rewind(fp_In1);
    end

  always @(Data_Type_Conversion_out1_addr_delay_1, clk_enable, tb_enb_delay)
    begin
      if (tb_enb_delay == 0) begin
        In1raw <= 0;
      end
      else if (clk_enable == 1) begin
        status_In1 = $fscanf(fp_In1, "%h", In1raw);
      end
    end

  assign rawData_In1 = (clk_enable == 1'b0 ? 13'sb0000000000000 :
              In1raw);



  // holdData reg for Data_Type_Conversion_out1
  always @(posedge clk)
    begin : stimuli_Data_Type_Conversion_out1
      if (reset_x) begin
        holdData_In1 <= 0;
      end
      else begin
        holdData_In1 <= rawData_In1;
      end
    end

  always @(rawData_In1 or clk_enable or tb_enb_delay)
    begin : stimuli_Data_Type_Conversion_out1_1
      if (tb_enb_delay == 1'b0) begin
        In1_offset <= 13'b0;
      end
      else begin
        if (clk_enable == 1'b0) begin
          In1_offset <= holdData_In1;
        end
        else begin
          In1_offset <= rawData_In1;
        end
      end
    end

  assign In1 = In1_offset; //delay #2


  Subsystem u_Subsystem (.clk(clk),
                         .clk_1_5(clk_1_5),
                         .clk_1_13(clk_1_13),
                         .reset(reset),
                         .reset_x(reset_x),
                         .clk_enable(clk_enable),
                      //   .clk_enable_5(clk_enable_5),
                      //   .clk_enable_13(clk_enable_13_1),  // ufix1
                         .In1(In1),  // sfix13_En9
                         .Out1_reg(Out1)  // sfix13_En9
                         );
  initial
	$sdf_annotate("../Outputs/Top_netlist_MIN", u_Subsystem);
  
 

  assign Out1_addr_delay_1 = Out1_addr; // dat. file test values assignment delays, here was #1

  // Data source for Out1_expected
  initial
    begin : Out1_expected_fileread
      fp_Out1_expected = $fopen("Out1_expected.dat", "r");
      status_Out1_expected = $rewind(fp_Out1_expected);
    end

  always @(Out1_addr_delay_1,  tb_enb_delay)
    begin
      if (tb_enb_delay == 0) begin
        Out1_expected <= 0;
      end
      else  begin
        status_Out1_expected = $fscanf(fp_Out1_expected, "%h", Out1_expected);
      end
    end

  // Bypass register to hold Out1_ref
  always @(posedge clk)
    begin : DataHold_Out1_ref
      if (reset_x) begin
        Out1_ref_hold <= 0;
      end
      else begin
        if (clock_enable_out) begin
          Out1_ref_hold <= Out1_expected;
        end
      end
    end

  assign Out1_refTmp = Out1_expected;

  assign Out1_ref = (clock_enable_out == 1'b0 ? Out1_ref_hold :
              Out1_refTmp);



  always @(posedge clk_1_5)
    begin : Out1_checker
      if (reset_x_1_5 == 1'b1) begin
        Out1_testFailure <= 1'b0;
      end
      else begin
        if (clock_enable_out == 1'b1 && Out1 !== Out1_ref) begin
          Out1_testFailure <= 1'b1;
          $display("ERROR in Out1 at time %t : Expected '%h' Actual '%h'", $time, Out1_ref, Out1);
        end
      end
    end

  assign testFailure = Out1_testFailure;

  always @(posedge clk)
    begin : completed_msg
      if (check1_done == 1'b1) begin
        if (testFailure == 1'b0) begin
          $display("**************TEST COMPLETED (PASSED)**************");
        end
        else begin
          $display("**************TEST COMPLETED (FAILED)**************");
        end
      end
    end
   
   
endmodule  // Subsystem_tb

