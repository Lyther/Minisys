vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../minisys.srcs/sources_1/ip/clock" "+incdir+../../../../minisys.srcs/sources_1/ip/clock" \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../minisys.srcs/sources_1/ip/clock" "+incdir+../../../../minisys.srcs/sources_1/ip/clock" \
"../../../../minisys.srcs/sources_1/ip/clock/clock_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

