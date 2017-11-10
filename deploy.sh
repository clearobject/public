#!/bin/bash
adduser -g wheel cloudadmin
mkdir /home/cloudadmin/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2d99zK9WsoVUZYRpphGqDaaij0aJLu1446u45UKnQasacJIZbJTxgxwVP0xj3wHb3qs+VG6IqT95PgNXE2CVPYE1Xceht0HOOc0PMDbwLxYrd2Y459lT7Wikvr3p0xW1oJANOy15Qipw8UDph2HlWWJQx3qMyihkOiaribv4uh0547hvuW4Drt+TG6DIEgHBOvqZNvyOBGdDuQ2jkppq2AUGW7CpPxjBo+ZTE9BCw9GqPGUAyrMMiViOg0SMGwtg651BlRsKTeX3t0Gh2/kUr+uiaPgAkc3mggDAkOSZhzuuZOgWUBFcgBYVn0F3Laz1cDT3/71aRVrqku2yAT004w==" > /home/cloudadmin/.ssh/authorized_keys
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
