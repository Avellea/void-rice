#!/bin/bash

#xrandr --output HDMI1 --primary --mode 1920x1080 --output LVDS1 --off && feh --bg-fill ~/Pictures/wallpapers/snow.jpg 

dte()
{
  dte="$(date +"%A, %B %d - %H:%M")"
  echo -e "$dte"
}
# upd()
# {
#   upd="$(eix -uc | wc -l)"
#   echo -e "Updates $upd"
# }
mem()
{
  mem=`free |awk '/Mem/ {printf "%d MiB/%d Mib\n", $3 / 1024.0, $2 / 1024.0}'`
  echo -e "Mem $mem"
}
net()
{
  net="$(cat /sys/class/net/w*/operstate)"
  ip="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
  if [ "$net" != "up" ]; then
    echo -e "No networking"
else
    echo -e "IP $ip"
fi
}
# pkg()
# {
#   pkg="$(qlist -IRv |wc -l)"
#   echo -e "Packages $pkg"
# }
cpu()
{
 read cpu a b c previdle rest < /proc/stat
 prevtotal=$((a+b+c+previdle))
 sleep 0.5
 read cpu a b c idle rest < /proc/stat
 total=$((a+b+c+idle))
 cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
 echo -e " CPU $cpu%"
}
# doge()
# {
# doge="$(curl rate.sx/1doge)":w

# echo -e "Ð $doge$"
# }



while true; do
    status="^f-1^"
    status="$status^b#020202^^c#d2d2d4^ "$(cpu)" "
    status="$status^c#8a2be2^^r-70,18,100,20^"
    status="$status^b#020202^^c#d2d2d4^ "$(mem)" "
    status="$status^c#e57c46^^r-184,18,500,20^"
#    status="$status^b#020202^^c#d2d2d4^ "$(net)" "
#    status="$status^b#a3be8c^^c#2e3440^ "$(upd)" "
#    status="$status^b#5e81ac^^c#2e3440^ "$(pkg)" "
    status="$status^b#020202^^c#d2d2d4^ "$(dte)" "
    status="$status^c#2cc46c^^r-232,18,500,20^"
    status="$status^f-1^"
    xsetroot -name "$(echo $status)"
  sleep 1m
done &
#urxvtd -q &
#xrandr --output HDMI1 --primary --mode 1920x1080 --output LVDS1 --off && feh --bg-fill ~/Pictures/wallpapers/snow.jpg &
#picom --backend glx --blur-background --blur-method dual_kawase
picom --experimental-backend
