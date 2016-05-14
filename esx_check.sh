#!/bin/bash     
#title          :esx_check.sh
#description    :Checks the version of ESX that the guest is running on.
#author         :cjohnson
#date           :20140911
#version        :0.2    
#usage          :./esx_check.sh
#notes          :N/A    
#bash_version   :4.2.42(1)-release
#============================================================================

#---------------------------------------------------
#Vars
#---------------------------------------------------

TIMESTAMP=$(date +%F-%H:%M)
USER=$(whoami)
LOG="script.log"
ESXTYPE="$(dmidecode | grep -A4 "BIOS Information" | grep Address: | awk '{print $2 }')"



#---------------------------------------------------
#Functions
#---------------------------------------------------
esx_type()
{
	case "$ESXTYPE" in
	"0xE8480" ) echo "ESX 2.5" ;;
	"0xE7C70" ) echo "ESX 3.0" ;;
	"0xE7910" ) echo "ESX 3.5" ;;
	"0xE7910" ) echo "ESX 4"   ;;
	"0xEA550" ) echo "ESX 4U1" ;;
	"0xEA2E0" ) echo "ESX 4.1" ;;
	"0xE72C0" ) echo "ESX 5"   ;;
	"0xEA0C0" ) echo "ESX 5.1" ;;
	"0xEA050" ) echo "ESX 5.5" ;;
	* ) echo "Unknown or Not an ESX version: "
	dmidecode | grep -A4 "BIOS Information"
	;;
	esac
}


#---------------------------------------------------
#Main Processing
#---------------------------------------------------

esx_type

#---------------------------------------------------
#Footer
#---------------------------------------------------

