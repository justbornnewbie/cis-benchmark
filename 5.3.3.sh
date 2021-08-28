#!/bin/bash
value=$(stat -c %a /etc/ssh/ssh_host_*_key.pub)
value1=$(echo $value | awk '{print $1}')
value11=$(echo ${value1: -2})

value2=$(echo $value | awk '{print $2}')
value22=$(echo ${value2: -2})

value3=$(echo $value | awk '{print $3}')
value33=$(echo ${value3: -2})

value4=$(echo $value | awk '{print $4}')
value44=$(echo ${value4: -2})
if [ $value11 = 00 -a $value22 = 00 -a $value33 = 00 -a $value44 = 00 ]
then
        echo "group and others doesn't have any access"
else
        find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chmod u-x,go-rwx {} \;
        find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chown root:root {} \;
        echo "We have changed the ownership to root and removed the access of group and others"
fi