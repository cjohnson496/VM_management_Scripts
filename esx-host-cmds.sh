#!/usr/bin/env bash
#title          :esx_host_cmds.sh
#description    :Info to and from VM Host
#author         :cjohnson
#date           :20160513
#version        :0.1
#usage          :./esx_host_cmds.sh
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

IFS=$'\n'

for VM in $(vmware-cmd -l);
do
        VM_STATE=$(vmware-cmd "${VM}" getstate | awk -F "= " '{print $2}')
        if [ "${VM_STATE}" == "on" ]; then
                echo "Setting info for ${VM}"
                vmware-cmd "${VM}" setguestinfo hypervisor.hostname "$(hostname)"
                vmware-cmd "${VM}" setguestinfo hypervisor.build "$(vmware -v)"
        fi
done

unset IFS

#---------------------------------------------------
#Footer
#---------------------------------------------------
