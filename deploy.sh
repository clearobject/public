#!/bin/bash
adduser -g wheel cloudadmin
mkdir /home/cloudadmin/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1ra4FjavvNUu4xN3RcFwUw9qQQBssmKDm9J/lBHPMvSDroVR//anOa+1ZUOryu5FkmsQuYPs59umXiUuVkoO5F0B6HQMUpcuuNc745VHA8SNmMj3ceqY7T2otsjosqZLmVdVjzd8+umHq5C9yRX13ldc6zFeF0ajZhuR3kCrS8Tjjn4yXuRpYTjrsUMVJEpXHjuW9CmuVoBltAAHTS/D7MTID/TcFw0YaNA1WRsZ/gPbmLg6bVR1uCrafh0sodbfy3XwS8lyuXT+rYgoiT+Sy+HBtqK8I0gYxUAU0gxb3CVeVLskY3P89SsOMAyYfDbeypxrlYIAk5nCLg3E4Bb+J cloudone-staff" > /home/cloudadmin/.ssh/authorized_keys
chown -R cloudadmin:wheel /home/cloudadmin/
chmod 0700 /home/cloudadmin/.ssh
chmod 0600 /home/cloudadmin/.ssh/authorized_keys

if [ -f "/etc/sudoers.tmp" ]; then
    exit 1
fi
touch /etc/sudoers.tmp
cat > /tmp/sudoers.new << '#EOF#'
Defaults    always_set_home
Defaults    env_reset
Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"
Defaults    env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
Defaults    env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin
root    ALL=(ALL)       ALL
 %wheel ALL=(ALL)       ALL
 %wheel ALL=(ALL)       NOPASSWD: ALL
## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)
#includedir /etc/sudoers.d
#EOF#
visudo -c -f /tmp/sudoers.new
if [ "$?" -eq "0" ]; then
    cp -f /tmp/sudoers.new /etc/sudoers
fi
rm /etc/sudoers.tmp



echo 'Complete!'
