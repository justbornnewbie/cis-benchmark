#5.1.1 Ensure cron daemon is enabled and running (Automated)
cronstatus=$(systemctl is-enabled cron)
if [ $cronstatus = $"enabled" ]
then
echo "5.1.1 Ensure cron daemon is enabled and running (Automated):Already enabled"
else
systemctl --now enable cron
echo "5.1.1 Ensure cron daemon is enabled and running (Automated):We have enabled it"
fi

#5.1.2Ensure permissions on /etc/crontab are configured (Automated)
cronstatus=$(stat /etc/crontab | grep  -Eo [0-9][0-9][0-9][0-9]\/)
if [ $cronstatus = 0600 ]
then
echo "5.1.2 Ensure permissions on /etc/crontab are configured (Automated):Already enabled"
else
chown root:root /etc/crontab
#chmod 600 /etc/crontab
chmod og-rwx /etc/crontab
echo "5.1.2 Ensure permissions on /etc/crontab are configured (Automated):We have enabled it"
fi

#5.1.8 Ensure cron is restricted to authorized users (Automated)
stat /etc/cron.deny 2>/dev/null
lastop=$(echo $?)
#echo $lastop
if [ $lastop = 0 ]
then
        rm -rf /etc/cron.deny
        echo "removed cron.deny file"
else
        touch /etc/cron.allow
        chmod g-wx,o-rwx /etc/cron.allow
        chown root:root /etc/cron.allow
        echo "Created cron.allow file and have set the permission to root user only"
        echo "5.1.8 Ensure cron is restricted to authorized users (Automated):Changed the permission"

fi