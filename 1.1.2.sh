#1.1.2 Ensure /tmp is configured (Automated)

echo "1.1.2 Ensure /tmp is configured (Automated)"

a=$(findmnt -n /tmp | grep -o tmp)
b=$( systemctl show "tmp.mount" | grep -i unitfilestate)

if [[ $a == "" && $b == "" ]]
then
echo "1.1.2 Ensure /tmp is configured (Automated) - false"
echo "/tmp is not configured separately hence no further intervention needed"
else
echo 'tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime 0 0' >> /etc/fstab
mount -o remount,noexec,nodev,nosuid /tmp
[ ! -f /etc/systemd/system/tmp.mount ] && cp -v /usr/lib/systemd/system/tmp.mount /etc/systemd/system/
echo '[Mount]
What=tmpfs
Where=/tmp
Type=tmpfs
Options=mode=1777,strictatime,noexec,nodev,nosuid
' > /etc/systemd/system/tmp.mount
systemctl daemon-reload
systemctl --now unmask tmp.mount

fi
