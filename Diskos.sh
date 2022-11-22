#! /usr/bin/bash

#Made by Anurag Yadav.

# BASH menu script that :
#   - Verify Disk Health
#   - View all Disk Partition
#   - Smartctl check
#   - Benchmark

server_name=$(hostname)

# Root check
function root_check () {
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
}

# Smartctl tool check 
function tool_check () {
	if ! [ -x "$(command -v smartctl)" ]; then
  echo 'Error: smartctl is not installed.' >&2
  else echo -ne "Smartctl found, You can proceed! \n \n" 
fi
}

# User Input
function disk_sel () {
    echo ""
	echo "Input Disc Name (Eg - sda, sdb) :"  
read disk   

echo "Partition number: (Eg - 2,3) :"  
read part 
	echo ""
}

##
# Main-menu functions
##

function empty () {
    echo ""
	echo "Disks Space Status on ${server_name} is: "
	echo ""
	df -h
	echo ""
}

function disk_health () {
    echo ""
	echo "Disk Health Status on ${server_name} is: "
	echo ""
	smartctl -i /dev/${disk}
	echo ""
}

function disk_part () {
    echo ""
	echo "Disk Partition on ${server_name} is: "
    echo ""
	fdisk -l
    echo ""
}

function smart_check() {
    echo ""
	echo "Quick Smart Check  on ${server_name}: "
    echo ""
	badblocks -sv /dev/${disk}${part} -o Bad_Blocks.md && smartctl -H /dev/${disk}
    echo ""
}

function bench_mark () {
    echo ""
	echo "Benchmarking on disk ${disk} partition ${part} on ${server_name} : "
	echo ""
#	export disk=${disk}
#export part=3
echo "test size for benchmark in MB () "  
read testsize
#export testsize=100 # in megabytes
cd /tmp
rmdir mntbench 2&>1 >/dev/null
mkdir mntbench
mount /dev/${disk}${part} ./mntbench
cd mntbench
dd if=/dev/zero of=temp oflag=direct bs=1048576 count="${testsize}" status=progress
rm temp
cd
umount /tmp/mntbench
rmdir /tmp/mntbench

    echo ""
}

function all_checks() {
	empty
	disk_health 
	disk_part 
	smart_check
	bench_mark
}

##
# Color  Variables
##

green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}

##
# Main-menu
##

menu(){
													# Tool check function call
echo -ne "
$(ColorGreen '1)') Verify Disk Health
$(ColorGreen '2)') View all Disk Partition
$(ColorGreen '3)') Quick Smartctl Check 
$(ColorGreen '4)') Benchmark
$(ColorGreen '5)') Check All
$(ColorGreen '6)') Select Disk & Partition
$(ColorGreen '7)') Disk Space Result (ONLY MOUNTED)
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read a
        case $a in
	        1) disk_health  ; menu ;;
	        2) disk_part  ; menu ;;
	        3) smart_check ; menu ;;
	        4) bench_mark  ; menu ;;
	        5) all_checks ; menu ;;
			6) disk_sel ; menu ;;
			7) empty ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}

# Call the menu function
echo -ne "Diskos \n "
root_check
tool_check
echo -ne "If you do not know you Disk and Partition, Press Enter \n  and use Option 2 (View all Disk Partition) to know your Disk and Partition \n Use Option 6 (Select Disk & Partition) to select. \n "
disk_sel
menu
