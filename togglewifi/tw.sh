#!/bin/bash
status=$(<.wifistatus)
if [ $status -eq 1 ]
then
        echo "stopping wifi"
        echo "0" > ".wifistatus"
        sudo create_ap --stop wlan0 >&/dev/null &
else
        echo "starting wifi"
        echo "1" > ".wifistatus"
        if [ -z "$1" ]
        then
                sudo create_ap --daemon wlan0 eth0 Raspwifi $2 >&/dev/null &
        else
                sudo create_ap --daemon wlan0 eth0 $1 $2 >&/dev/null &
        fi
fi
