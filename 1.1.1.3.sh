#1.1.1 Disable unused filesystems

#1.1.1.3 Ensure mounting of udf filesystems is disabled (Automated)

echo "1.1.1.3 Ensure mounting of udf filesystems is disabled (Automated)"

a=$(modprobe -n -v udf | grep -E '(udf|install)' | grep -o install)

if [[ $(lsmod | grep udf) == "" && $a == "install" ]]
then
echo "1.1.1.3 Ensure mounting of udf filesystems is disabled (Automated) - true"
else
echo 'install udf /bin/true' > /etc/modprobe.d/udf.conf
rmmod udf > /dev/null
fi
