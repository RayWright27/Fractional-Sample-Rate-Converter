#######################################################
#                                                     
#  Encounter Command Logging File                     
#  Created on Fri Dec 10 15:07:03 2021                
#                                                     
#######################################################

#@(#)CDS: Encounter v14.28-s033_1 (64bit) 03/21/2016 13:34 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute v14.28-s005 NR160313-1959/14_28-UB (database version 2.30, 267.6.1) {superthreading v1.25}
#@(#)CDS: CeltIC v14.28-s006_1 (64bit) 03/08/2016 00:08:23 (Linux 2.6.18-194.el5)
#@(#)CDS: AAE 14.28-s002 (64bit) 03/21/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 14.28-s007_1 (64bit) Mar  7 2016 23:11:05 (Linux 2.6.18-194.el5)
#@(#)CDS: CPE v14.28-s006
#@(#)CDS: IQRC/TQRC 14.2.2-s217 (64bit) Wed Apr 15 23:10:24 PDT 2015 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799

save_global Default.globals
set init_gnd_net VSS
set init_lef_file {/Cadence/Libs/X_FAB/XKIT/xt018/cadence/v5_0/techLEF/v5_0_2/xt018_xx43_MET4_METMID_METTHK.lef /Cadence/Libs/X_FAB/XKIT/xt018/diglibs/D_CELLS_5V/v4_0/LEF/v4_0_0/xt018_D_CELLS_5V.lef} 
set init_design_settop 0
set init_verilog ../Source/Top/Synthesis/Top_synth.v
set init_mmmc_file ../Scripts/MMMC.tcl
set init_io_file ../Source/Module_pins
set init_pwr_net VDD
set init_gnd_net VSS
init_design
#---------------------------------------------------------------------------------
floorPlan -fplanOrigin center -site core_5v -r 1 0.40 10.08 10.37 10.08 10.37
floorPlan -fplanOrigin center -site core_5v -r 1 0.40 10.08 10.37 10.08 10.37
#floorPlan -fplanOrigin center -site core_5v -d 1100 900 10.08 10.37 10.08 10.37
#floorPlan -fplanOrigin center -site core_5v -d 1100 900 10.08 10.37 10.08 10.37

win
#---------------------------------------------------------------------------------
globalNetConnect VDD -type pgpin -pin vdd5! -inst * -module {}
globalNetConnect VDD -type tiehi -pin vdd5! -inst * -module {}
globalNetConnect VSS -type tielo -pin gnd! -inst * -module {}
globalNetConnect VSS -type pgpin -pin gnd! -inst * -module {}
win
#---------------------------------------------------------------------------------
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer METTPL -type core_rings -jog_distance 3.15 -threshold 3.15 -nets {VDD VSS} -follow core -stacked_via_bottom_layer MET1 -layer {bottom MET1 top MET1 right MET2 left MET2} -width 3 -spacing 0.35 -offset 3.15
win
#---------------------------------------------------------------------------------
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit MET3 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit MET1 -set_to_set_distance 50 -skip_via_on_pin Standardcell -stacked_via_top_layer METTPL -padcore_ring_top_layer_limit MET3 -spacing 25 -merge_stripes_value 3.15 -layer MET2 -block_ring_bottom_layer_limit MET1 -width 3 -nets {VDD VSS} -stacked_via_bottom_layer MET1
win
#---------------------------------------------------------------------------------
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { MET1 METTPL } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { MET1 METTPL } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { MET1 METTPL }
win
#---------------------------------------------------------------------------------
timeDesign -prePlace -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix Subsystem_prePlace -outDir timingReports

setMultiCpuUsage -localCpu 4 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setDistributeHost -local
setPlaceMode -fp false
placeDesign -inPlaceOpt
win
#---------------------------------------------------------------------------------
#Pre-Clock Tree Synthesis STA and optimization
#---------------------------------------------------------------------------------
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix Subsystem_preCTS -outDir timingReports

timeDesign -preCTS -hold -idealClock -pathReports -slackReports -numPaths 50 -prefix Subsystem_preCTS -outDir timingReports

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS

setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -preCTS -incr
win
#---------------------------------------------------------------------------------
#Clock Tree Synthesis
#---------------------------------------------------------------------------------


createClockTreeSpec -bufferList {BU_5VX0 BU_5VX1 BU_5VX12 BU_5VX16 BU_5VX2 BU_5VX3 BU_5VX4 BU_5VX6 BU_5VX8 DLY1_5VX1 DLY2_5VX1 DLY4_5VX1 DLY8_5VX1 IN_5VX0 IN_5VX1 IN_5VX12 IN_5VX16 IN_5VX2 IN_5VX3 IN_5VX4 IN_5VX6 IN_5VX8 STE_5VX1 STE_5VX2 STE_5VX3 STE_5VX4 ST_5VX1 ST_5VX2 ST_5VX3 ST_5VX4} -file Clock.ctstch
setCTSMode -engine ck
clockDesign -specFile Clock.ctstch -outDir clock_report -fixedInstBeforeCTS

win
#---------------------------------------------------------------------------------
#Post-CTS STA and optimization
#---------------------------------------------------------------------------------
timeDesign -postCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix Subsystem_postCTS -outDir timingReports
#timeDesign -postCTS -hold -pathReports -drvReports -slackReports -numPaths 50 -prefix Subsystem_postCTS -outDir timingReports

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS
optDesign -postCTS -hold

setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postCTS -incr
optDesign -postCTS -hold -incr
win
#---------------------------------------------------------------------------------
#Post-Route optimization
#---------------------------------------------------------------------------------
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -routeTopRoutingLayer 4
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
win
#---------------------------------------------------------------------------------
#Post-Route STA and optimization
#---------------------------------------------------------------------------------
setAnalysisMode -analysisType onChipVariation -skew true -clockPropagation sdcControl

timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix Subsystem_postRoute -outDir timingReports

timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix Subsystem_postRoute -outDir timingReports

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute
optDesign -postRoute -hold

setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postRoute -incr
optDesign -postRoute -hold -incr
win
#---------------------------------------------------------------------------------
#Add Fillers
#---------------------------------------------------------------------------------
getFillerMode -quiet
addFiller -cell FEED7_5V FEED5_5V FEED3_5V FEED2_5V FEED25_5V FEED1_5V FEED15_5V FEED10_5V DECAP7_5V DECAP5_5V DECAP25_5V DECAP15_5V DECAP10_5V -prefix FILLER

win
#---------------------------------------------------------------------------------
#Verify Geometry
#---------------------------------------------------------------------------------
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
#---------------------------------------------------------------------------------
#Verify DRC
#---------------------------------------------------------------------------------
verify_drc -report Subsystem.drc.rpt -limit 1000
#---------------------------------------------------------------------------------
#Verify Connectivity
#---------------------------------------------------------------------------------
verifyConnectivity -type all -error 1000 -warning 50
#---------------------------------------------------------------------------------
#Verify Process Antenna
#---------------------------------------------------------------------------------
verifyProcessAntenna -reportfile Subsystem.antenna.rpt -error 1000
#---------------------------------------------------------------------------------
#Verify AC Limit
#---------------------------------------------------------------------------------
verifyACLimit -report Subsystem.aclimit.rpt -ruleFile Subsystem.aclimit.rul -toggle 1.0 -error 1000 -scaleIrms 1.0
#---------------------------------------------------------------------------------
#Verify Bus Guide
#---------------------------------------------------------------------------------
verifyBusGuide -busMargin 0.0 -report Subsystem.busguide.rpt
#---------------------------------------------------------------------------------
#Verify End Cap
#---------------------------------------------------------------------------------
verifyEndCap
setMetalFill -layer MET1 -windowSize 200.000 200.000 -windowStep 100.000 100.000 -minDensity 20.000 -maxDensity 80.000
setMetalFill -layer MET2 -windowSize 200.000 200.000 -windowStep 100.000 100.000 -minDensity 20.000 -maxDensity 80.000
setMetalFill -layer MET3 -windowSize 200.000 200.000 -windowStep 100.000 100.000 -minDensity 20.000 -maxDensity 80.000
setMetalFill -layer MET4 -windowSize 200.000 200.000 -windowStep 100.000 100.000 -minDensity 20.000 -maxDensity 80.000
setMetalFill -layer METTP -windowSize 200.000 200.000 -windowStep 100.000 100.000 -minDensity 20.000 -maxDensity 80.000
setMetalFill -layer METTPL -windowSize 200.000 200.000 -windowStep 100.000 100.000 -minDensity 20.000 -maxDensity 80.000
#---------------------------------------------------------------------------------
#verifyMetalDensity
#---------------------------------------------------------------------------------
verifyMetalDensity -report Subsystem.density.rpt
setViaFill -layer VIA1 -windowSize 10.000 10.000 -windowStep 5.000 5.000 -minDensity 0.00 -maxDensity 30.00
setViaFill -layer VIA2 -windowSize 10.000 10.000 -windowStep 5.000 5.000 -minDensity 0.00 -maxDensity 30.00
setViaFill -layer VIA3 -windowSize 10.000 10.000 -windowStep 5.000 5.000 -minDensity 0.00 -maxDensity 30.00
setViaFill -layer VIATP -windowSize 10.000 10.000 -windowStep 5.000 5.000 -minDensity 0.00 -maxDensity 30.00
setViaFill -layer VIATPL -windowSize 10.000 10.000 -windowStep 5.000 5.000 -minDensity 0.00 -maxDensity 30.00
#---------------------------------------------------------------------------------
#verifyCutDensity
#---------------------------------------------------------------------------------
verifyCutDensity
#---------------------------------------------------------------------------------
#verifyPowerVia
#---------------------------------------------------------------------------------
verifyPowerVia
#---------------------------------------------------------------------------------
#extraction mode setting
#---------------------------------------------------------------------------------
setExtractRCMode -engine postRoute -effortLevel signoff 
extractRC
#---------------------------------------------------------------------------------
#sign-off timing report
#---------------------------------------------------------------------------------
timeDesign -signoff -pathReports -drvReports -slackReports -numPaths 50 -prefix Subsystem_signOff -outDir timingReports

timeDesign -signoff -hold -pathReports -slackReports -numPaths 50 -prefix Subsystem_signOff -outDir timingReports
win
#---------------------------------------------------------------------------------
#exporting netlist and layout
#---------------------------------------------------------------------------------
all_hold_analysis_views 
all_setup_analysis_views 

# write_sdf -view TYPview ../Output/Top_netlist_TYP.sdf
write_sdf -view MINview ../Output/Top_netlist_MIN.sdf
write_sdf -view MAXview ../Output/Top_netlist_MAX.sdf

saveNetlist ../Output/Top_netlist_for_sim.v
saveNetlist ../Output/Top_netlist.v -includePhysicalCell {FEED7_5V FEED5_5V FEED3_5V FEED2_5V FEED25_5V FEED1_5V FEED15_5V FEED10_5V DECAP7_5V DECAP5_5V DECAP25_5V DECAP15_5V DECAP10_5V }

global dbgLefDefOutVersion
set dbgLefDefOutVersion 5.8
defOut -floorplan -netlist -routing ../Output/Top.def
set dbgLefDefOutVersion 5.8

