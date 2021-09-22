#1.1.1 Disable unused filesystems

#1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated)

echo "1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated)"

a=$(modprobe -n -v squashfs | grep -E '(squashfs|install)' | grep -o install)

if [[ $(lsmod | grep squashfs) == "" && $a == "install" ]]
then
echo "1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated) - true"
else
echo 'install squashfs /bin/true' > /etc/modprobe.d/squashfs.conf
rmmod squashfs > /dev/null
fi
