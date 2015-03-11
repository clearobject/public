#!/bin/bash
adduser cloudadmin
mkdir /home/cloudadmin/.ssh
cp ~/.ssh/authorized_keys /home/cloudadmin/.ssh/authorized_keys
chown -R cloudadmin:cloudadmin /home/cloudadmin/.ssh
