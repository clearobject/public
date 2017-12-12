#!/bin/bash
adduser -g wheel cloudadmin
mkdir /home/cloudadmin/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6sMBWqeONW+0kEtXEmi3BdxKxu0R+kNVZf4xsjgWqigWvr//02DNw8zrV34uljT9KACy0ZpMtyyABUZ/pZOVT4g4HU5ONIMqpxxTrHXIx/+dy3TF544XdFXUImfzUS5IIPZaDf3MU+r3X4fHiuTK1y9PbR6hYJIUMZHO3hvIy7PPrKZwx4r+BlUEP8BYn5Sl9FkMNdFd+WJmyZ8svD+fRNIOZm+2U+1uyMLLgCZxEYCy0NP19pZijNovLtt2v27LV6q1WNPjaz5/UZAHbHF70fZMsAQaUcHs0xBGSc6rJrXsbpsoC1kY8fUpu4VIvQzn5mIuSf/a2F/l5FbruplkfQ==" > /home/cloudadmin/.ssh/authorized_keys
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
