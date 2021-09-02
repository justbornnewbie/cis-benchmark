#!/bin/bash
value1=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Eo '(VERBOSE|INFO)')
value2=$(grep -i 'loglevel' /etc/ssh/sshd_config | grep -Evi '(VERBOSE|INFO)')
if [[ $value2="" ]]
then
        sed -i 's/\#LogLevel/LogLevel/' /etc/ssh/sshd_config
        echo " We have changed the Loglevel to $value1"
fi
~
