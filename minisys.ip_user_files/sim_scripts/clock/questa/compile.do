vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../minisys.srcs/sources_1/ip/clock" "+incdir+../../../../minisys.srcs/sources_1/ip/clock" \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../minisys.srcs/sources_1/ip/clock" "+incdir+../../../../minisys.srcs/sources_1/ip/clock" \
"../../../../minisys.srcs/sources_1/ip/clock/clock_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

