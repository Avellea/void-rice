#!/bin/bash

# Initialization

mainMenu () {
	clear
	echo "void-rice bootstrap script"
	echo "Please ensure an active network connection before continuing."
	echo ""
	echo "1) Update kernel to 5.9.16_1 (Current: $(uname -r))"
	echo "2) Install packages I find required."
	echo "3) Set up system services (iwd, dbus) - REQUIRES OPT. 2"
	echo "4) Set up dwm, slstatus, and other desktop components."
	echo "q) Quit the bootstrap script"

	read -n 1 -p "Input selection: " "mainmenuinput"
	
	if [ "$mainmenuinput" = "1" ]; then
		updateKernel
	elif [ "$mainmenuinput" = "2" ]; then
		installSoftware
	elif [ "$mainmenuinput" = "3" ]; then
		setupServices
	elif [ "$mainmenuinput" = "4" ]; then
		setUpDesktop
	elif [ "$mainmenuinput" = "d" ]; then
		debugVars
	elif [ "$mainmenuinput" = "q" ]; then
		quitProgram
	else
		echo ""
		echo "You have entered an invalid selection."
		echo "Press any key to continue..."
		read -n 1
		clear
		mainMenu
	fi
}


# Ask if the user would like to update the kernel. 
updateKernel () {
	clear
	echo "This will require a reboot when the process has finished."
	read -n 1 -p "Are you sure? (y/n) " "kernelquestion"

	if [ "$kernelquestion" = "y" ]; then
		actuallyUpdateKernel
	else 
		clear
		mainMenu
	fi
}

# Actually update the kernel, called by updateKernel()
actuallyUpdateKernel () {
	echo ""
	xbps-query --regex -Rs '^linux[0-9.]+-[0-9._]+'
	sudo xbps-install linux5.9
	echo ""
	echo "If any errors were found, please fix them and re-run the kernel installation."
	echo "A reboot is required to apply the new kernel."
	echo "Press any key to return to the main menu..."
	read -n 1
	mainMenu
}

# Install basic software required for my current system. This list can and most likely will be expanded.
installSoftware () {
	clear
	echo "Preparing to install software."
	echo "Press any key to continue..."
	read -n 1
	sudo xbps-install neofetch kitty libXinerama-devel libXft-devel freetype-devel xinit feh neovim xrandr xtools iwd curl wget htop dbus
	echo ""
	echo "This next task is invasive and should be done manually. Follow the instructions below."
	echo "1) Open a new terminal."
	echo "2) git clone git://github.com/void-linux/void-packages.git"
	echo "3) cd void-packages"
	echo "4) ./xbps-src binary-bootstrap"
	echo "5) echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf"
	echo "6) ./xbps-src pkg broadcom-wl-dkms"
	echo "7) sudo xi broadcom-wl-dkms"
	echo ""
	echo "Done!"
	echo "You must reboot before you have the correct WiFi driver."
	echo "Press any key to return to the main menu..."
	read -n 1 
	mainMenu
}

# Some of the software installed above requires runit services. Create those here.
setupServices () {
	clear
	echo "Setting up services required for basic networking."
	sudo ln -s /etc/sv/iwd /var/service/
	sudo ln -s /etc/sv/dbus /var/service/
	# Do more here
	echo "Done!"
	echo "Press any key to return to the main menu..."
	read -n 1
	mainMenu
}

# Set up the dwm desktop, along with some of it's utilities such as slstatus and dmenu. 
setUpDesktop () {
	clear
	echo "Setting up desktop environment."
	pwd
	cd suckless-config/dwm/ && sudo make clean install
	cd ../dmenu && sudo make clean install
	cd ../slstatus && sudo make clean install
	cd .. && cp -rf .dwm/ ~/.dwm/
	echo exec dwm >> ~/.xinitrc
	cd ..
	cp -rf .config/ ~/.config/
	echo ""
	echo "Done! Check for any errors above and re-run if required."
	echo "Be sure to also make sure void-rice/suckless-config/.dwm/ and void-rice/.config/ were copied."
	echo "Press any key to return to the main menu..."
	read -n 1
	mainMenu
}

debugVars () {
	clear
	pwd
	read -n 1
	mainMenu
}

quitProgram () {
	clear
	echo "Exiting."
	echo ""
	exit
}

cd ..
mainMenu
