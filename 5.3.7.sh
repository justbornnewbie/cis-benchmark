#!/bin/bash
value1=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries)
value2=$value2 | awk ' { print $2 }'
value3=$(grep -Ei '^\s*maxauthtries\s+([5-9]|[1-9][0-9]+)' /root/sshd_config)
if [[ $value3=" " ]]
then
        sed -i  's/\#MaxAuthTries 6/MaxAuthTries 4/' /root/sshd_config | grep -i maxauth
        echo "We have changed the MaxAuthTries to 4"
fi
