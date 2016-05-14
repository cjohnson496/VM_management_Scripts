#!/usr/bin/env bash
#title          :Vbox.sh
#description    :Start a VirtualBox VM headless
#author         :cjohnson
#date           :20160513
#version        :0.1
#usage          :./Vbox.sh
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

VMUSER=admin
VMNAME="Win8" # Change as needed
BASEFOLDER=/Users/admin/ # Change as needed

#---------------------------------------------------
#Functions
#---------------------------------------------------

#---------------------------------------------------
#Main Processing
#---------------------------------------------------

case "$1" in
    start)
        echo "Starting VirtualBox VM..."
        sudo -H -u $VMUSER VBoxManage startvm "$VMNAME" --type headless
        ;;
    reset)
        echo "Resetting VirtualBox VM..."
        sudo -H -u $VMUSER VBoxManage controlvm "$VMNAME" reset
        ;;
    stop)
        echo "Saving state of Virtualbox VM..."
        sudo -H -u $VMUSER VBoxManage controlvm "$VMNAME" savestate
        ;;
    shutdown)
        echo "Shutting down Virtualbox VM..."
        sudo -H -u $VMUSER VBoxManage controlvm "$VMNAME" acpipowerbutton
        ;;
    status)
        sudo -H -u $VMUSER VBoxManage list vms -l | grep -e ^"$VMNAME": -e ^State | sed s/\ \ //g | cut -d: -f2-
        ;;
    backup)
        echo ""
        sudo -H -u $VMUSER VBoxManage controlvm "$VMNAME" acpipowerbutton

        echo "Waiting for VM "$VMNAME" to poweroff..."
        until $(sudo -H -u $VMUSER VBoxManage showvminfo --machinereadable "$VMNAME" | grep -q ^VMState=.poweroff.)
        do
          sleep 1
        done

        FILENAME=$(date +"%Y_%m_%d-%T")
        echo "Backing up Virtualbox VM to '$BASEFOLDER$FILENAME'..."
        sudo -H -u $VMUSER VBoxManage clonevm "$VMNAME" --options keepallmacs --name $FILENAME --basefolder $BASEFOLDER

        echo "Restarting VirtualBox VM..."
        sudo -H -u $VMUSER VBoxManage startvm "$VMNAME" --type headless
        echo ""
        ;;
    *)
        echo "Usage: sudo service vbox {start|stop|status|shutdown|reset|backup}"
        exit 1
        ;;
esac

exit 0

#---------------------------------------------------
#Footer
#---------------------------------------------------
