# Name: Sysadmin Kit 
# Author: Tedley Meralus
# Contact: @TechGameTeddy
# Menu driven script to to quickly run common syadmin tasks
#
# Define Variables

#Variables for apps being installed
ALLAPPS="android-tools-adb android-tools-fastboot chromium-browser docker elinks filezilla gimp git coreutils inkscape libappindicator1 libindicator7 evolution national-geographic-wallpaper neofetch npm playonlinux putty shutter steam synaptic terminator tor transmission ubuntu-cleaner unity-tweak-tool uget vagrant virtualbox open-vm-tools-desktop"
# ----------------------------------
# function to display menus
# ----------------------------------
show_menus() {
	clear
	date
	echo "|-----------------------------------------------------------------------------------"
	echo "|-----------------------------------------------------------------------------------"
	echo "|-----------------------------Sysadmin Toolkit------------------------------------- "
	echo "|-----------------------------------------------------------------------------------"
	echo "|.dP'Y8 Yb  dP .dP''Y8    db    8888b.  8b    d8 88 88b 88     88  dP 88 888888     "
	echo "|	`Ybo.'  YbdP  `Ybo.'   dPYb    8I  Yb 88b  d88 88 88Yb88     88odP  88   88       "
	echo "|	o.`Y8b   8P   o.`Y8b  dP__Yb   8I  dY 88YbdP88 88 88 Y88     88'Yb  88   88       "
	echo "|	8bodP'  dP    8bodP' dP""""Yb 8888Y'  88 YY 88 88 88  Y8     88  Yb 88   88       "
	echo "|-----------------------------------------------------------------------------------"
	echo "|-----------------------------------------------------------------------------------"
	echo "|-----------------------------------------------------------------------------------"
	echo "| Essential tools/utilities to finish 	        	                          "
	echo "| common sysadmin tasks                                                             "
	echo "| created By @TechGameTeddy                                                         "
	echo "|                                                                                   "
	echo "|1. Backup Script                                                                   "
	echo "|2. Add to .bashrc                                                                  "
	echo "|3. Check High CPU usage                                                            "
	echo "|4. Database Backup                                                                 "
	echo "|5. Check Disk Usage                                                                "
	echo "|6. New user script                                                                 "
	echo "|7. Sysinfo script                                                                  "
	echo "|8. Ranger -Terminal File Manager                                                   "
	echo "|9. HTOP - Terminal based sys tool                                                  "
	echo "|10. Exit                                                                           "
	echo "|-----------------------------------------------------------------------------------"
}


# ----------------------------------
#  Return functions
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
# ----------------------------------
#back to main menu
# ----------------------------------
backtomain(){
  show_menus
}
# ----------------------------------
#  Main Menu Option
# ----------------------------------
one(){
	while true; do
	read -p "Are you sure you want to run the unattended installer?[y/n]" input
	case $input in
	[yY][eE][sS]|[yY])
		uinstaller
		;;
	[nN][oO]|[nN])
		backtomain
       		break;;
    *)
	echo "Invalid input..."
	echo "Please type (y)Yes or (n)No"
	;;
esac
done
        pause
}
## Option two Update PPA List ()
two(){
	sudo apt-add-repository ${ALLPPA[*]}
        pause
}
## Option three Check Software List()
three(){
	software_list
        #pause
}
## Option four Exit ()
four(){
	clear
	exit
}
# ----------------------------------
#  MAIN MENU
# ----------------------------------
read_options(){
	local choice
	read -p "Enter your choice [ 1 - 4] " choice
	case $choice in
		1) one    ;;
		2) two    ;;
		3) three  ;;
		4) four   ;;
		4) five   ;;
		4) six   ;;
		4) seven   ;;
		4) eight   ;;
		4) nine   ;;
		4) ten   ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}


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
	show_menus
	read_options
	date_and_time

