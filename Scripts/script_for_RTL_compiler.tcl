## Setup technology files
include ../Technology/auxiliary_file.tcl

## Setup variables
set DESIGN Subsystem
set PARAMS {}

## Read in Verilog HDL files

# Timing controller module
read_hdl -v2001 ../Source/Timig_controller/Subsystem_timigcontroller_d1.v

# IIR filter
read_hdl -v2001 ../Source/Filter/IIR/Filter.v

# Top module
read_hdl -v2001 ../Source/Top/Subsystem.v

## Compile our code (create a technology-independent schematic)
elaborate -parameters $PARAMS $DESIGN
gui_show
## Setup design constraints
read_sdc ../Source/constraints.sdc

## Synthesize our schematic (create a technology-dependent schematic)
#synthesize -to_generic
synthesize -to_mapped
synthesize -incremental

## Write out area and timing reports
report timing > ../Reports/Top_synth_timing_report
report timing -worst 50 -encounter > ../Reports/Top_synth_timing_report2
report area > ../Reports/Top_synth_area_report

## Write out synthesized Verilog netlist
write_hdl -mapped > ../Source/Top/Synthesis/Top_synth.v

## Write out the SDC file we will take into the place n route tool
write_sdc > ../Source/Top/Synthesis/Top_out.sdc

gui_show

