#!/bin/bash

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
