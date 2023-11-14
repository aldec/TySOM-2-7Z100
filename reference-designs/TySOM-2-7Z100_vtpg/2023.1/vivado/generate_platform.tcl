# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct generate_platform.tcl
# 
# OR launch xsct and run below command.
# source generate_platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

set project_name TySOM-2-7Z100_vtpg
set pfm_name TySOM-2-7Z100_vtpg_sw
set xsa $project_name/system_wrapper.xsa 

puts $pfm_name
puts $project_name

platform create -name ${pfm_name}\
-hw ${xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out ${project_name}/${project_name}.sdk

platform write
platform generate -domains 
platform active ${pfm_name}
platform generate
