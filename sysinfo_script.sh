#!/bin/bash
# Name: sysinfo.sh 
# A menu driven script to to get information about your 
# Linux server / computer.
# Author: Tedley Meralus
# Contact: @TechGameTeddy
# Define variables
LSB=/usr/bin/lsb_release
EXCLUDE_LIST="/auto/ripper"
usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
partition=$(echo $output | awk '{print $2}')
alias="alias" 
EMAIL=tmeralus@gmail.com
# ----------------------------------
# Display pause prompt
# $1-> Message (optional)
# ----------------------------------
pause(){
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
}
# ----------------------------------
# function to display menus
# ----------------------------------
 show_menu(){
    date
        echo "|------------------------------|"
        echo "|        System Info           |"
        echo "|------------------------------|"
        echo "|                              |"
	echo "|1. Operating system info      |"
	echo "|2. Hostname and dns info      |"
	echo "|3. Network info               |"
	echo "|4. Who is online              |"
	echo "|5. Last logged in users       |"
	echo "|6. Free and used memory info  |"
	echo "|7. Check memory processes     |"
	echo "|8. Check Disk usage           |"
	echo "|9. Check for  high cpu        |"
	echo "|10. Check alias for $USER     |"
	echo "|                              |"  
	echo "| Type 'e' to exit script      |"
	echo "|                              |"
    	echo "|------------------------------|"
}
# ----------------------------------
# Display header 
# ----------------------------------
 write_header(){
	local h="$@"
	echo "---------------------------------------------------------------"
	echo "     ${h}"
	echo "---------------------------------------------------------------"
}
# ----------------------------------
#  OS info
# ----------------------------------
 os_info(){
	write_header " System information "
	echo "Operating system : $(uname)"
	[ -x $LSB ] && $LSB -a || echo "$LSB command is not insalled (set \$LSB variable)"
	#pause "Press [Enter] key to continue..."
	pause
}
# ----------------------------------
# Net info about host such as dns, IP, and hostname
# ----------------------------------
 host_info(){
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
	write_header " Hostname and DNS information "
	echo "Hostname : $(hostname -s)"
	echo "DNS domain : $(hostname -d)"
	echo "Fully qualified domain name : $(hostname -f)"
	echo "Network address (IP) :  $(hostname -i)"
	echo "DNS name servers (DNS IP) : ${dnsips}"
	pause
}
# ----------------------------------
# Network inferface and routing info
# ----------------------------------
 net_info(){
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
	write_header " Network information "
	echo "Total network interfaces found : $(wc -w <<<${devices})"

	echo "*** IP Addresses Information ***"
	ip -4 address show

	echo "***********************"
	echo "*** Network routing ***"
	echo "***********************"
	netstat -nr

	echo "**************************************"
	echo "*** Interface traffic information ***"
	echo "**************************************"
	netstat -i

	pause 
}
# ----------------------------------
# Shows  list of users currently logged on and
# Show list of recently loggged in users  
# ---------------------------------- 
 user_info(){
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Who is online "; who -H; pause ;;
		last) write_header " List of last logged in users "; last ; pause ;;
	esac 
}
# ----------------------------------
# Display used and free memory info
# ----------------------------------
 mem_info(){
	#write_header " Free memory MB "
	#free -m
	write_header " Free memory "
    	free -h
    echo "*********************************"
	echo "*** Virtual memory statistics ***"
    echo "*********************************"
	vmstat
}
# ----------------------------------
# Memory Leak Top 5 memory eating process
# ----------------------------------
 memory_leak(){
    echo "***********************************"
	echo "*** Top 5 memory eating process ***"
    echo "***********************************"	
	ps auxf | sort -nr -k 4 | head -5	
	pause
}
#-----------------------------------
## Display & Monitor Disk Usage info
## Send an email if (free available) percentage is above 90%
#-----------------------------------
#disk_usage(){
# set alert level 90% is default
ALERT=90
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
disk_usage(){
while read output;
do
#echo $output
  if [ $usep -ge $ALERT ] ; then
     echo "Running out of space \"$partition ($usep%)\" on server $(hostname), $(date)" | \
     mail -s "Alert: Almost out of disk space $usep%" $EMAIL
  fi
done
if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi
pause
}
#-----------------------------------
## View High CPU usage
#-----------------------------------
high_cpu(){
while [ true ] ;do
used=`free -m |awk 'NR==3 {print $4}'`

if [ $used -lt 1000 ] && [ $used -gt 800 ]; then
echo "Free memory is below 1000MB. Possible memory leak!!!" | /bin/mail -s "HIGH MEMORY ALERT!!!" $EMAIL
fi
sleep 5
done
pause
}
#-----------------------------------
## Check Alias's set by current user
#-----------------------------------
alias_check(){
$alias
}
# ----------------------------------
## Add to Bash Profile
# ----------------------------------
add_to_bashp(){
pause
	
}
# 
# ----------------------------------
## Exit Option ()
# ----------------------------------
exit_script(){
	clear
	exit
}
# ----------------------------------
# Keyboard input and make a decision 
# ---------------------------------- 
 read_input(){
	local c
	read -p "Enter your choice [ 1 - 10 ] " choice
	case $choice in
		1)	os_info ;;
		2)	host_info ;;
		3)	net_info ;;
		4)	user_info "who" ;;
		5)	user_info "last" ;;
		6)	mem_info ;;
		7)	memory_leak ;;
		8)	disk_usage ;;
		9)	high_cpu ;;
		10)	alias_check ;;
		[eE])	exit_script ;;
		[bB])   add_to_bashp ;;
		*)	
			echo "Please select between 1 to 10 choice only."
			pause
	esac
}
# ----------------------------------
# Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# ----------------------------------
# Main Menu logic - infinite loop
# ----------------------------------
while true
do
	clear
 	show_menu	
 	read_input  
done
