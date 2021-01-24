#!/bin/bash

# pi1 [armv6l versatilepb] it can work on qemu-3.1.0 or later
#qemu-system-arm -kernel /root/kernel-qemu-buster -dtb /root/versatile-pb.dtb -machine versatilepb -cpu arm1176 -m 256 -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda /root/raspbian-lite.qcow2 -no-reboot -nographic -net "user,hostfwd=tcp::2222-:22" -net "nic"

# pi2 [armv7l raspi2] didnt work network on qemu-5.2.0
#qemu-system-arm -kernel /root/kernel7.img -dtb /root/bcm2709-rpi-2-b.dtb -machine raspi2 -m 1024 -append "rw earlyprintk loglevel=8 console=ttyAMA0 root=/dev/mmcblk0p2 rw rootwait panic=1 rootfstype=ext4" -sd /root/2019-09-26-raspbian-buster-lite.img -no-reboot -nographic

# pi3 [aarch64 raspi3] network fine on qemu-5.2.0 but .net Core didnt work
#qemu-system-aarch64 -kernel /root/kernel8.img -dtb /root/bcm2710-rpi-3-b-plus.dtb -machine raspi3 -m 1024 -append "rw earlyprintk loglevel=8 console=ttyAMA0 root=/dev/mmcblk0p2 rootwait panic=1 rootfstype=ext4" -sd /root/2019-09-26-raspbian-buster-lite.img -no-reboot -nographic -device usb-net,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2222-:22

# debian buster pi2 [armv7l virt] check dependencies on docs.microsoft.com before install .net Core mannually.
#see about .net Core dependencies - https://docs.microsoft.com/en-us/dotnet/core/install/linux-debian#dependencies
#see about docker and iptables - https://matsuand.github.io/docs.docker.jp.onthefly/network/iptables/
qemu-system-arm -kernel /root/vmlinuz-4.19.0-10-armmp -initrd /root/initrd.img-4.19.0-10-armmp -machine virt -m 1024 -append "root=/dev/vda2 panic=1 rootfstype=ext4 rw" -drive if=none,file=/home/debian_raspi_2.img,format=raw,id=hd -device virtio-blk-device,drive=hd -device virtio-rng-device -no-reboot -nographic -netdev user,id=mynet,hostfwd=tcp::2222-:22 -device virtio-net-device,netdev=mynet