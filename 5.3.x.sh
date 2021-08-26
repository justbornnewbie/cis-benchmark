#5.3.1 Ensure permissions on /etc/ssh/sshd_config are configured
value=$(stat -c %a /etc/ssh/sshd_config)
value2=$(echo "${value: -2}")
if [ $value2 = 00 ]
then
        echo "group and others doesn't have any access"
else
        chown root:root /etc/ssh/sshd_config
        chmod og-rwx /etc/ssh/sshd_config
        echo "We have changed the ownership to root and removed the access of group and others"
fi

#5.3.2 Ensure permissions on SSH private host key files are configured 
value=$(stat -c %a /etc/ssh/ssh_host_*_key)
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
