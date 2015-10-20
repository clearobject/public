#!/bin/bash
# Copyright CloudOne 2015
# Benjamin Chodroff - benjamin.chodroff@oncloudone.com
# Script to download and install the cloudstats registration client on RHEL 6.6

##echo "Removing Cloudstats2 and all server registration keys - dangerous"
##rm -rf /cloudstats2
# exit if any error is encountered
set -e
mkdir -p /cloudstats2
cd /cloudstats2
wget https://sunlight.oncloudone.com/downloads/cloudstats-3.0.77.linux-x86_64.zip
unzip cloudstats-3.0.77.linux-x86_64.zip
echo "Creating Default Cloudstats2 log_directories configuration in /cloudstats2/sunlight.conf"
echo -e """[global]\nlog_directories=/opt/IBM/JazzTeamServer/server/logs,/opt/IBM/JazzTeamServer/server/tomcat/logs\n" > sunlight.conf
croncmd='(cd /cloudstats2;timeout 300 ./cloudstats > lastrun.txt 2>&1)'
cronjob="*/5 * * * * $croncmd"
echo 'Adding cronjob for cloudstats'
# ignore errors because if the cron is empty grep will error with exit code of 1
set +e
existingcron=`crontab -l | grep -v cloudstats`
# resume error checking
set -e
# append the existingcron and update the cloudstats line to the cron
( echo "$existingcron" ; echo "$cronjob" ) | crontab -
echo 'Crontab is set to:'
crontab -l
echo
echo "SUCCESS: Installation of cloudstats complete in /cloudstats2"
exit 0
