#!/bin/bash
adduser -g wheel cloudadmin
mkdir /home/cloudadmin/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA5+iHQ9ccManvOIurMid9ccm33Bdwq7UdaMIsQRe1BEv0XI0SSI4m3Y71ug3B4Sca+93ndYPa+k8zWXfAtoKuCAe2Qeou9A1t2NIERfAXsVwD0KeExh0G/vBFFngfmosC7LKfj7TE7IO+4FGShJKu4nsfGlqmdSUvl59nNwE6Csf6xDLzv1rsr7v75HG7Afi1Mkh25cuYu68xum/oxMf9U0NsqljFO+/zk8HNTKI/e8dReuCet/DORDlS3Q0VM4NJUoXiv7FVEFkPbI7s5L/sLtBLQM9XoXG6fuQXvA9nIi0SNE/jQZgGZvLGCpotPwMKSYGApkDOFUGItWF5ldOkdw==" > /home/cloudadmin/.ssh/authorized_keys
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
