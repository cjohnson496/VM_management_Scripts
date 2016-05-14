#! /bin/bash
# Simple VirtualBox script

#Edit these vars
VMUSER=admin
VMNAME="Win8" # Change as needed
BASEFOLDER=/Users/admin/ # Change as needed

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
