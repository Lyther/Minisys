-makelib ies_lib/xil_defaultlib -sv \
  "D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Vivado/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../minisys.srcs/sources_1/ip/clock/clock_clk_wiz.v" \
  "../../../../minisys.srcs/sources_1/ip/clock/clock.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

