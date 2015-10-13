#!/bin/bash

[ -z $URL ] && URL="http://mirror.beyondhosting.net/CentOS/7/isos/x86_64/CentOS-7-x86_64-NetInstall-1503.iso"
[ ! -f /data/ks.cfg ] && cp /tmp/ks.cfg /data/ks.cfg

curl -o /tmp/centos-7.iso "$URL"
[ $? -ne 0 ] && (echo 'Download failed. Aborting!'; exit 1)

mkdir -p /tmp/centos-r /tmp/centos-rw
xorriso -osirrox on -indev /tmp/centos-7.iso -extract / /tmp/centos-r
cp -a /tmp/centos-r/* /tmp/centos-rw/

# embedding the kickstart file into initrd
# prevents dealing with drive letter assignment
mkdir /tmp/initrd
cd /tmp/initrd || (echo 'Failed to cd. Aborting!'; exit 1)
xz -d < /tmp/centos-r/isolinux/initrd.img | cpio --extract --make-directories --no-absolute-filenames
cp /data/ks.cfg .
find . | cpio -H newc --create | xz --format=lzma --compress --stdout > /tmp/centos-rw/isolinux/initrd.img

cd /tmp/centos-rw || (echo 'Failed to cd. Aborting!'; exit 1)
[ ! -f /data/isolinux.cfg ] && cp /tmp/isolinux.cfg isolinux/ || cp /data/isolinux.cfg isolinux/
xorriso -as mkisofs -R -J -V "CentOS-7" -o "/data/centos-7.iso" -b isolinux/isolinux.bin \
  -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -isohybrid-mbr \
  /usr/lib/syslinux/isohdpfx.bin .
