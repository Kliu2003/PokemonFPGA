# Legal Notice: (C)2022 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	Pokemon_soc_nios2_gen2_0_cpu 	Pokemon_soc_nios2_gen2_0_cpu:*
set 	Pokemon_soc_nios2_gen2_0_cpu_oci 	Pokemon_soc_nios2_gen2_0_cpu_nios2_oci:the_Pokemon_soc_nios2_gen2_0_cpu_nios2_oci
set 	Pokemon_soc_nios2_gen2_0_cpu_oci_break 	Pokemon_soc_nios2_gen2_0_cpu_nios2_oci_break:the_Pokemon_soc_nios2_gen2_0_cpu_nios2_oci_break
set 	Pokemon_soc_nios2_gen2_0_cpu_ocimem 	Pokemon_soc_nios2_gen2_0_cpu_nios2_ocimem:the_Pokemon_soc_nios2_gen2_0_cpu_nios2_ocimem
set 	Pokemon_soc_nios2_gen2_0_cpu_oci_debug 	Pokemon_soc_nios2_gen2_0_cpu_nios2_oci_debug:the_Pokemon_soc_nios2_gen2_0_cpu_nios2_oci_debug
set 	Pokemon_soc_nios2_gen2_0_cpu_wrapper 	Pokemon_soc_nios2_gen2_0_cpu_debug_slave_wrapper:the_Pokemon_soc_nios2_gen2_0_cpu_debug_slave_wrapper
set 	Pokemon_soc_nios2_gen2_0_cpu_jtag_tck 	Pokemon_soc_nios2_gen2_0_cpu_debug_slave_tck:the_Pokemon_soc_nios2_gen2_0_cpu_debug_slave_tck
set 	Pokemon_soc_nios2_gen2_0_cpu_jtag_sysclk 	Pokemon_soc_nios2_gen2_0_cpu_debug_slave_sysclk:the_Pokemon_soc_nios2_gen2_0_cpu_debug_slave_sysclk
set 	Pokemon_soc_nios2_gen2_0_cpu_oci_path 	 [format "%s|%s" $Pokemon_soc_nios2_gen2_0_cpu $Pokemon_soc_nios2_gen2_0_cpu_oci]
set 	Pokemon_soc_nios2_gen2_0_cpu_oci_break_path 	 [format "%s|%s" $Pokemon_soc_nios2_gen2_0_cpu_oci_path $Pokemon_soc_nios2_gen2_0_cpu_oci_break]
set 	Pokemon_soc_nios2_gen2_0_cpu_ocimem_path 	 [format "%s|%s" $Pokemon_soc_nios2_gen2_0_cpu_oci_path $Pokemon_soc_nios2_gen2_0_cpu_ocimem]
set 	Pokemon_soc_nios2_gen2_0_cpu_oci_debug_path 	 [format "%s|%s" $Pokemon_soc_nios2_gen2_0_cpu_oci_path $Pokemon_soc_nios2_gen2_0_cpu_oci_debug]
set 	Pokemon_soc_nios2_gen2_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $Pokemon_soc_nios2_gen2_0_cpu_oci_path $Pokemon_soc_nios2_gen2_0_cpu_wrapper $Pokemon_soc_nios2_gen2_0_cpu_jtag_tck]
set 	Pokemon_soc_nios2_gen2_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $Pokemon_soc_nios2_gen2_0_cpu_oci_path $Pokemon_soc_nios2_gen2_0_cpu_wrapper $Pokemon_soc_nios2_gen2_0_cpu_jtag_sysclk]
set 	Pokemon_soc_nios2_gen2_0_cpu_jtag_sr 	 [format "%s|*sr" $Pokemon_soc_nios2_gen2_0_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sr*    -to *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$Pokemon_soc_nios2_gen2_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$Pokemon_soc_nios2_gen2_0_cpu_oci_debug_path|monitor_go
