## Timing constraints file from the synthesis
create_constraint_mode -name CONSTRAINTS -sdc_files {../Source/constraints.sdc}


## Create timing library sets
# The slowest corner
create_library_set -name SLOWlib \
-timing {/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/liberty_CPF_LP5MOS_MOS5/v4_0_1/PVT_3_30V_range/D_CELLS_5V_LP5MOS_MOS5_CPF_slow_3_00V_175C.lib}

# Typical corner
create_library_set -name TYPlib \
-timing {/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/liberty_CPF_LP5MOS_MOS5/v4_0_1/PVT_3_30V_range/D_CELLS_5V_LP5MOS_MOS5_CPF_typ_3_30V_25C.lib}

# The fastest corner
create_library_set -name FASTlib \
-timing {/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/liberty_CPF_LP5MOS_MOS5/v4_0_1/PVT_3_30V_range/D_CELLS_5V_LP5MOS_MOS5_CPF_fast_3_60V_m40C.lib}


## Create operating conditions (P-V-T) for the timing libraries
# The slowest operation condition
create_op_cond -name PVT_slow_3_00V_175C \
-library_file {/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/liberty_CPF_LP5MOS_MOS5/v4_0_1/PVT_3_30V_range/D_CELLS_5V_LP5MOS_MOS5_CPF_slow_3_00V_175C.lib} \
-P {1} -V {3} -T {175}

# Typical operation condition
create_op_cond -name PVT_typ_3_30V_25C \
-library_file {/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/liberty_CPF_LP5MOS_MOS5/v4_0_1/PVT_3_30V_range/D_CELLS_5V_LP5MOS_MOS5_CPF_typ_3_30V_25C.lib} \
-P {1} -V {3.3} -T {25}

# The fastest operation condition
create_op_cond -name PVT_fast_3_60V_-40C \
-library_file {/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/liberty_CPF_LP5MOS_MOS5/v4_0_1/PVT_3_30V_range/D_CELLS_5V_LP5MOS_MOS5_CPF_fast_3_60V_m40C.lib} \
-P {1} -V {3.6} -T {-40}


## Create RC corner(s) from capacitance table(s)
#Temperature can be configured by adding "-T {25}"
create_rc_corner -name RCcornerMIN \
-cap_table /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v5_0/capTbl/v5_0_1_2/xt018_xx43_MET4_METMID_METTHK_min.capTbl\
-qx_tech_file /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v7_0/QRC_pvs/v7_0_3/XT018_1243/QRC-Min/qrcTechFile

create_rc_corner -name RCcornerTYP \
-cap_table /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v5_0/capTbl/v5_0_1_2/xt018_xx43_MET4_METMID_METTHK_typ.capTbl \
-qx_tech_file /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v7_0/QRC_pvs/v7_0_3/XT018_1243/QRC-Typ/qrcTechFile

create_rc_corner -name RCcornerMAX \
-cap_table /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v5_0/capTbl/v5_0_1_2/xt018_xx43_MET4_METMID_METTHK_max.capTbl \
-qx_tech_file /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v7_0/QRC_pvs/v7_0_3/XT018_1243/QRC-Max/qrcTechFile

## Create delay corner(s)
# Delay corner = timing library plus rc corner
# Operation condition can be configured by adding "-opcond PVT_typ_3_30V_25C"
create_delay_corner -name DELAYcornerSLOW -library_set SLOWlib -rc_corner RCcornerMAX
create_delay_corner -name DELAYcornerTYP -library_set TYPlib -rc_corner RCcornerTYP 
create_delay_corner -name DELAYcornerFAST -library_set FASTlib -rc_corner RCcornerMIN

## Create analysis views
# Analysis view = delay corner matched to constraints
create_analysis_view -name MAXview -delay_corner {DELAYcornerSLOW} -constraint_mode {CONSTRAINTS}
create_analysis_view -name TYPview -delay_corner {DELAYcornerTYP} -constraint_mode {CONSTRAINTS}
create_analysis_view -name MINview -delay_corner {DELAYcornerFAST} -constraint_mode {CONSTRAINTS}

## Set analysis view to above for both setup and hold
# Worst-case corner = max delay/affects setup times
# Best-case corner = min delay/affects hold times
# For 1-corner use typical values for both
#set_analysis_view -setup {TYPview} -hold {TYPview}
set_analysis_view -setup {MAXview} -hold {MINview}




