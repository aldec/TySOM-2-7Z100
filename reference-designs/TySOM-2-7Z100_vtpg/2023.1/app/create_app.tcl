# Script settings
set ws			vtpg_example.sdk
set name		vtpg_example
set platform	TySOM-2-7Z100_vtpg_sw
set xsa			../platform/TySOM-2-7Z100_vtpg_sw/hw/system_wrapper.xsa

# Procedures
proc create_app_xsa args {
	if {[llength $args] != 3} {
		puts "error: invalid number of paramaters!"
		puts "Please specify parameters to process"
		puts "Example Usage: create_app.tcl <workspace> <app_name> <xsa_name>"
	} else {

		set ws_name [lindex $args 0]
		set app_name [lindex $args 1]
		set xsa [lindex $args 2]


		#set workspace
		puts "Create Workspace"
		setws ${ws_name}
		set a [getws]
		set app "Empty Application"

		app create -name ${app_name} -template ${app} -hw ./$xsa -os standalone -proc {ps7_cortexa9_0}

		#copy example source files tp app project
		puts "Get Example Design Source Files"
		importsources -name ${app_name} -path ./src

		#build project
		puts "Build Project"
		app build -name ${app_name}
	}
}
proc create_app_pfm args {
	if {[llength $args] != 3} {
		puts "error: invalid number of paramaters!"
		puts "Please specify parameters to process"
		puts "Example Usage: create_app.tcl <workspace> <app_name> <platform_name>"
	} else {

		set ws_name [lindex $args 0]
		set app_name [lindex $args 1]
		set pfm_name [lindex $args 2]

		#set workspace
		puts "Create Workspace"
		setws ${ws_name}
		set a [getws]
		set app "Empty Application"

		app create -name ${app_name} -template ${app} -platform ${pfm_name} -domain standalone_domain

		#copy example source files tp app project
		puts "Get Example Design Source Files"
		importsources -name ${app_name} -path ./src

		#build project
		puts "Build Project"
		app build -name ${app_name}
	}
}

# Run procedures
create_app_xsa ${ws} ${name} ${xsa}
#create_app_pfm ${ws} ${name}_1 ${platform}
