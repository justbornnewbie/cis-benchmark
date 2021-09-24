#1.1.5 Ensure nosuid option set on /tmp partition (Automated)

echo "1.1.5 Ensure nosuid option set on /tmp partition (Automated)"

a=$(findmnt -n /tmp -n | grep -Ev '\bnosuid\b')
if [[ $a == "" && ! -f /etc/systemd/system/localfs.target.wants/tmp.mount ]]
then
echo "1.1.5 Ensure nosuid option set on /tmp partition (Automated) - false"
echo "/tmp is not configured separately hence no further intervention needed"
else
echo 'tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime 0 0' >> /etc/fstab
mount -o remount,nosuid /tmp
[ -f /etc/systemd/system/local-fs.target.wants/tmp.mount ]
echo '[Mount]
Options=mode=1777,strictatime,noexec,nodev,nosuid' >> /etc/systemd/system/local-fs.target.wants/tmp.mount
systemctl daemon-reload
systemctl --now unmask tmp.mount
fi