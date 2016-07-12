#!/bin/bash
adduser -g wheel cloudadmin
mkdir /home/cloudadmin/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUlLp39Lyb6fJ8JHOUwKZxVIQ5uEAPHTduY5298dL8Dobd9D6LWUT07SHrraCI76eYK33a9kLXrfCI3owotBpgeDtrBlXM2Hg/6D9QBgN9X/n2LjtFhMeF83v7uGz36zOKNaa9HXbd89gadEm1si50y3pKUC5UQN/FXtqJ1whAl8AHJUaa0VdG4s4rE87LA1JwfEGjb6qHN79Lq9DY89gVuAvZ346VT9XkEfDGN/aqrn9ZDayYUxImIIQy9F0BCTpJVQg2przGponrqv+1HOF8gTzpHhfuzQpG6tcoN/jSNLYMb7FDseWBBAxCCt9mXuBHDnUHHYzn07ut7TvYxkAR cloudadmin-no-reply@oncloudone.com" > /home/cloudadmin/.ssh/authorized_keys
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
