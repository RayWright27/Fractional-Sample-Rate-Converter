#-------------------------------------------TIMING SPECIFICATIONS CONSTRAINTS-------------------------------------------#

create_clock -name clk -period 50 [get_ports clk]
create_generated_clock -source clk -divide_by 13  clk_1_13
create_generated_clock -source clk -divide_by 13 -multiply_by 5 clk_1_5
##############
set_clock_uncertainty -setup [expr 5/1] [get_ports clk]
set_clock_uncertainty -hold [expr 5/1] [get_ports clk]

set_clock_uncertainty -setup [expr 65/1]  [get_ports clk_1_13]
set_clock_uncertainty -hold [expr 65/1]  [get_ports clk_1_13]

set_clock_uncertainty -setup [expr 25/1] [get_ports clk_1_5]
set_clock_uncertainty -hold [expr 25/1] [get_ports clk_1_5]

set_multicycle_path -setup 13 -from clk_1_13 -to clk
set_multicycle_path -hold 13 -from clk_1_13 -to clk
#---------------------------------------------------INPUT/OUTPUT DELAYS-------------------------------------------------#
#CREATING IN/OUT DELAYS according to clk default 0.5 or 0.333 of Tclk
set_input_delay -clock [get_clocks clk] -max -add_delay 214.5 [get_ports {{In1[0]} {In1[1]} {In1[2]} {In1[3]} {In1[4]} {In1[5]} {In1[6]} {In1[7]} {In1[8]} {In1[9]} {In1[10]} {In1[11]} {In1[12]}}]

set_output_delay -clock [get_clocks clk_1_5] -max -add_delay 82.5 [get_ports {{Out1[0]} {Out1[1]} {Out1[2]} {Out1[3]} {Out1[4]} {Out1[5]} {Out1[6]} {Out1[7]} {Out1[8]} {Out1[9]} {Out1[10]} {Out1[11]} {Out1[12]}}]

#---------------------------------------------------FALSE PATH DETECTION------------------------------------------------#
set_false_path -from [get_ports reset_x]

#create test case constraints if test case CHANGES the design itself


