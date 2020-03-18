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
	echo "|-----------------------------------------------------------------------------------|"
	echo "|-----------------------------Sysadmin Toolkit------------------------------------- |"
	echo "|-----------------------------------------------------------------------------------|"
	echo "|                                                                                   |"
	echo "| Essential tools/utilities to finish 	        	                                  |"
	echo "| common sysadmin tasks                                                             |"
	echo "| created By @TechGameTeddy                                                         |"
	echo "|                                                                                   |"
	echo "|1. Backup Script                                                                   |"
	echo "|2. Add to .bashrc                                                                  |"
	echo "|3. Check High CPU usage                                                            |"
	echo "|4. Database Backup                                                                 |"
	echo "|5. Check Disk Usage                                                                |"
	echo "|6. New user script                                                                 |"
	echo "|7. Sysinfo script                                                                  |"
	echo "|8. Ranger -Terminal File Manager                                                   |"
	echo "|9. HTOP - Terminal based sys tool                                                  |"
	echo "|10. Unused tool                                                                    |"
	echo "|                                                                                   |"
	echo "| Type 'e' to exit script                                                           |"
	echo "|                                                                                   |"
	echo "|-----------------------------------------------------------------------------------|"
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
#  Main Menu Options
# ----------------------------------
one(){
	numbertest
	pause
}
## Option two
two(){
	numbertest
	pause
}
## Option three
three(){
	numbertest
	pause
}
## Option four
four(){
	numbertest
	pause
}
five(){
	numbertest
	pause
}
six(){
	numbertest
	pause
}
seven(){
	numbertest
	pause
}
eight(){
	numbertest
	pause
}
nine(){
	numbertest
	pause
}
ten(){
	numbertest
	pause
}
# ----------------------------------
## Exit Option ()
# ----------------------------------
exit_script(){
	clear
	exit
}
numbertest(){
  read -p "no function used right now..."
  backtomain
}
# ----------------------------------
#  MAIN MENU
# ----------------------------------
read_options(){
	local choice
	read -p "Enter your choice [ 1 - 10] " choice
	case $choice in
		1) one    ;;
		2) two    ;;
		3) three  ;;
		4) four   ;;
		5) five   ;;
		6) six   ;;
		7) seven   ;;
		8) eight   ;;
		9) nine   ;;
		10) ten   ;;
		[eE])	exit_script ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
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
	show_menus
	read_options
	date_and_time
done
