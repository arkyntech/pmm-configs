#!/bin/bash
# runs Plex-Meta-Manager -
# https://github.com/meisnate12/Plex-Meta-Manager
# pass the script the name of the config file you are using
# I have mine separated.  One to run daily, weekly, etc.
#
# Exmaple: ./pmm.sh config_daily.yml
#
# if you need/want to run this as a specific user in docker add something like --user seed:seed 
#
#

/bin/mkdir -p /opt/pmm
/usr/bin/docker pull meisnate12/plex-meta-manager:develop
cd /opt/pmm-configs && git pull
docker stop autoscan
wait
/usr/bin/docker run --rm -it -d --name pmm -v /opt/pmm/config:/config:rw -v /opt/pmm-configs/:/yml/ -v /opt/pmm-configs/images:/config/assets -v /mnt:/mnt meisnate12/plex-meta-manager:develop --config /config/"${1}" -r
docker start autoscan