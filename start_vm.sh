#!/usr/bin/env bash
#title          :start_vm.sh
#description    :Start a VirtualBox VM headless
#author         :cjohnson
#date           :20160513
#version        :0.1
#usage          :./start_vm.sh
#notes          :N/A
#bash_version   :4.2.42(1)-release
#============================================================================


#---------------------------------------------------
#Vars
#---------------------------------------------------

#Edit these vars as needed
TIMESTAMP=$(date +%F-%H:%M)
USER=$(whoami)
LOG="script.log"

#---------------------------------------------------
#Functions
#---------------------------------------------------

#---------------------------------------------------
#Main Processing
#---------------------------------------------------

clear screen

if test -z "$1"
then
echo "This script will start a VBox image"
echo "Would you like to continue? "
echo "Enter yes or no"
read TXT
if [[ $TXT = no ]]; then
    exit 1
fi
echo "#########################################################"
echo "What is the name of the VBox image you wish to start? >"
echo "#########################################################"
echo "VBox Images"
echo "Please enter the name of the image as it appears in the list:"
echo "#########################################################"
vboxmanage list vms
read VBox
    vboxmanage startvm $VBox
else
    vboxmanage startvm $1
fi
echo "#########################################################"
echo "Currently running VBox Images"
vboxmanage list  runningvms

#---------------------------------------------------
#Footer
#---------------------------------------------------
