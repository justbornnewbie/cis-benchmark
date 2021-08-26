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
