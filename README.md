This is fractional sample rate converter device project for implementation in ASIC.

Top verilog file is /Source/Subsystem.v

In order to generate ASIC layout and netlist go through the following steps:
1) To simulate open Incisive and use Subsystem_tb.v.
2) To run synthesis launch RTL Compiler with a script ../Scripts/script_for_RTL_compiler.tcl
3) To generate a layout open Encounter with a script ../Script/FSRC_PaR_4.tcl
   Then Top_netlist.v and Top_netlist_for_sim.v will be created in Output folder. The first file is for furhter export in Virtuoso for verification, the second one is for signOff simulation in Incisive (for this simulation use Subsystem_tb_signoff.v).
   .sdf and .def files will appear as well, they are also for verification in Virtuoso.
4) To make verification launch Virtuoso and import Top_netlist.v and Top.def files.
5) Run "remaster instances". In viewname field input "abstract", in update field input "layout".
6) Place labels.
7) Run DRC and LVS

