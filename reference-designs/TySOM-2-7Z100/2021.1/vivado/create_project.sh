#/bin/bash

set -euo pipefail
set -x

PROJECT=TySOM-2-7Z100_hdmi

if [ ! -d ip_repo ]; then
	echo "ip_repo not found!"
	mkdir ip_repo
fi
if [ ! -d $PROJECT".srcs" ]; then
	echo "sources not found!"
	exit 1
fi
if [ ! -e $PROJECT".tcl" ]; then
	echo "tcl script not found"
	exit 1
fi


git clone --depth=1 -b 2021_r1 https://github.com/analogdevicesinc/hdl ip_repo/hdl
echo "Building axi_clkgen ip..."
make -C ip_repo/hdl/library/axi_clkgen

vivado -source $PROJECT".tcl"
