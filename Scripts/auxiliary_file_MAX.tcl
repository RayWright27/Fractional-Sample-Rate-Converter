## Setup path for liberty CPF directory
set_attribute lib_search_path /Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v5_0/liberty_LP5MOS_MOS5/v5_0_0/PVT_3_30V_range
##set_attribute lib_search_path /Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v5_0/liberty_LP5MOS_MOS5/v5_0_0/PVT_5_00V_range

## Setup PVT corner .lib file
set_attribute library {D_CELLS_5V_LP5MOS_MOS5_fast_3_60V_m40C.lib}
##set_attribute library {D_CELLS_5V_LP5MOS_MOS5_typ_5_00V_25C.lib}

## Setup LEF files
set_attribute lef_library {/Cadence/Libs/X_FAB/XKIT/xt018/cadence/v5_0/techLEF/v5_0_2/xt018_xx43_MET4_METMID_METTHK.lef \
/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/LEF/v4_0_0/xt018_D_CELLS_5V.lef \
/Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/LEF/v4_0_0/xt018_xx43_MET4_METMID_METTHK_D_CELLS_5V_mprobe.lef}

## Setup Capacitance Table file
set_attribute cap_table_file /Cadence/Libs/X_FAB/XKIT/xt018/cadence/v5_0/capTbl/v5_0_1_2/xt018_xx43_MET4_METMID_METTHK_typ.capTbl

## Setup error on blackbox
set_attribute hdl_error_on_blackbox true

