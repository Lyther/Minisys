vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv -L xil_defaultlib "+incdir+../../../ipstatic" "+incdir+D:/Vivado/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+D:/Vivado/Vivado/2017.4/data/xilinx_vip/include" \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+D:/Vivado/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+D:/Vivado/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../minisys.srcs/sources_1/ip/clock/clock_clk_wiz.v" \
"../../../../minisys.srcs/sources_1/ip/clock/clock.v" \

vlog -work xil_defaultlib \
"glbl.v"

