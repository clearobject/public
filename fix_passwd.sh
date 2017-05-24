#!/bin/sh
#
# rob.hough@clearobject.com  
# 
# Needed a way to quickly change passwords for multiple users on
# a Linux machine. Change the ${USERS} value(s) to reflect your
# users and 
#############################################################################
CREDENTIALS="${HOME}/credentials"

USERS="user1 user2 user3 user4 user5 user6"
USERS="${USERS} user7 user8 user9 user10"

# run through our list of users, change the password.
for USER in ${USERS}
 do
    ### If you want all of the passwords to be the same
    ### move the $RANDPWD variable to the top of this script
    RANDPWD=$(openssl rand -base64 18)

    ### Change the user's password, store credentials
    ### Would like to see this get moved to vault.
    echo "${USER}:${RANDPWD}" | tee -a ${CREDENTIALS} |  chpasswd

    ### protect our credentials file from non privileged users
    chmod 0600 ${CREDENTIALS}
 done

### All done here
exit 0