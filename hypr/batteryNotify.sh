#!/bin/bash
while true
do

    if [ -d /sys/class/power_supply/BAT* ]; then
        CHARGE=$(cat /sys/class/power_supply/BAT*/capacity)
        STATUS=$(cat /sys/class/power_supply/BAT*/status)
        #CHARGE=$(upower -i $(upower -e | grep '/battery') | grep -E percentage|xargs|cut -d' ' -f2|sed s/%//)
        #STATE=$(upower -i $(upower -e | grep '/battery') | grep  -E state)
        #STATUS=$(echo "${STATE}" | grep -wo "charging")
    else
        exit
    fi

       if [ "$STATUS" = "Charging" ]; then
   if [ "$CHARGE" = "90" ]; then
       notify-send --urgency=CRITICAL "Disconnect Charger" "Level: ${CHARGE}%"
       paplay /usr/share/sounds/freedesktop/stereo/service-login.oga
   fi

else
        if [ "$STATUS" = "Discharging" ]; then
    if [ "$CHARGE" = "30" ]; then
        notify-send --urgency=CRITICAL "Connect Charger" "Level: ${CHARGE}%"
        paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
        fi

    else
            if [ "$STATUS" = "Discharging" ]; then
        if [ "$CHARGE" = "20" ]; then
                notify-send --urgency=CRITICAL "Shutting Down!" "Level: ${CHARGE}%"
                sleep 10s
                paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
                systemctl poweroff
        fi
             fi
    fi
fi
sleep 60s
done
