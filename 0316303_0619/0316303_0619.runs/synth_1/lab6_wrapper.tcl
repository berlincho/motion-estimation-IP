# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.cache/wt [current_project]
set_property parent.project_path C:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property ip_repo_paths c:/Users/shlab_89/Desktop/0620_lab_BRAM/ip_repo/me_match_1.0 [current_project]
set_property ip_output_repo c:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib C:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/hdl/lab6_wrapper.v
add_files C:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/lab6.bd
set_property used_in_implementation false [get_files -all c:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/ip/lab6_processing_system7_0_0/lab6_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/ip/lab6_rst_ps7_0_100M_0/lab6_rst_ps7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/ip/lab6_rst_ps7_0_100M_0/lab6_rst_ps7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/ip/lab6_rst_ps7_0_100M_0/lab6_rst_ps7_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/ip/lab6_auto_pc_0/lab6_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/lab6_ooc.xdc]
set_property is_locked true [get_files C:/Users/shlab_89/Desktop/0620_lab_BRAM/0316303_0619/0316303_0619.srcs/sources_1/bd/lab6/lab6.bd]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top lab6_wrapper -part xc7z020clg484-1


write_checkpoint -force -noxdef lab6_wrapper.dcp

catch { report_utilization -file lab6_wrapper_utilization_synth.rpt -pb lab6_wrapper_utilization_synth.pb }
