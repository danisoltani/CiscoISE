mkdir /opt/unetlab/addons/qemu/ise-2.4.0.357 && cd $_
curl -e https://cisco.app.box.com -L "https://cisco.app.box.com/index.php?rm=box_download_shared_file&vanity_name=ISE-Eval&file_id=f_285777496618" -O ISE-2.4.0.357-virtual-Eval.ova
tar -xvf ISE-2.4.0.357-virtual-Eval.ova
cat ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000000 ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000001 ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000002 ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000003 ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000004 ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000005 ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz.000000006 > ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz
gunzip ISE-2.4.0.357-virtual-Eval-disk1.vmdk.gz
/opt/qemu/bin/qemu-img convert -f vmdk -O qcow2 ISE-2.4.0.357-virtual-Eval-disk1.vmdk hda.qcow2
rm ISE-2.4.0.357*
rm /opt/unetlab/html/templates/ise.php
sudo cat <<'EOF' >> /opt/unetlab/html/templates/ise.php
<?php
# vim: syntax=php tabstop=4 softtabstop=0 noexpandtab laststatus=1 ruler


$p['type'] = 'qemu';
$p['name'] = 'ISE';
$p['cpulimit'] = 0;
$p['icon'] = 'ISE.png';
$p['cpu'] = 4;
$p['ram'] = 16384;
$p['ethernet'] = 1;
$p['console'] = 'telnet';
$p['qemu_arch'] = 'x86_64';
$p['qemu_options'] = '-machine type=pc-1.0,accel=kvm -serial mon:stdio -nographic -nodefconfig -nodefaults -display none -vga std -rtc base=utc -cpu core2duo';
?>
EOF
/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
