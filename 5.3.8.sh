#!/bin/bash
value1=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ignorerhosts)
value2=$(grep -Ei '^\s*ignorerhosts\s+no\b' /etc/ssh/sshd_config)
value3=$(echo $?)
if [[ $value1 = 'ignorerhosts yes' &&  $value3 = 1  ]]
then
        echo "We  Changed the value of IgnoreRhosts to yes and uncomment it in /etc/ssh/sshd_config"
        sed -i 's/\#IgnoreRhosts/IgnoreRhosts/g' /etc/ssh/sshd_config

else
                echo "everything looks good"
fi