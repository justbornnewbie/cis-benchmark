#5.2.1 Ensure sudo is installed (Automated)
sudovalue2=$(dpkg -s sudo | grep -o "Status: install")
if [  "$sudovalue2" = "Status: install" ]
then
        echo "Sudo is already installed"

else
        apt install sudo -y
        echo "Sudo was not installed. We have installed it now"

fi

#5.2.3 Ensure sudo log file exists (Automated)
var1=$(grep -Ei '^\s*Defaults\s+logfile=\S+' /etc/sudoers /etc/sudoers.d/*|grep -io defaults)
if [ "$var1" = "Defaults" ]
then
        echo "Custom log location is already set"
else
        echo "Custom log location is not set, we have set to manually to /var/log/sudo.log"
        echo 'Defaults logfile="/var/log/sudo.log"' >> /etc/sudoers
fi

