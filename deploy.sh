#!/bin/bash
adduser cloudadmin
mkdir /home/cloudadmin/.ssh
cp ~/.ssh/authorized_keys /home/cloudadmin/.ssh/authorized_keys
chown -R cloudadmin:cloudadmin /home/cloudadmin/.ssh

cat > /etc/sudoers << '#EOF#'
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

echo 'Complete!'
