FROM debian:buster-slim

ENV DEBIAN_KERNEL vmlinuz-4.19.0-10-armmp
ENV DEBIAN_RAMDISK initrd.img-4.19.0-10-armmp

WORKDIR /root

# Install dependencies. qemu version is 3.1.0
RUN set -x \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  curl \
  qemu \
  qemu-system-arm \
  libguestfs-tools \
  unzip \
  netcat

# Copy debian raspi2 kernel and ramdisk.
COPY debian/$DEBIAN_KERNEL debian/$DEBIAN_RAMDISK /root/

#Copy shell
COPY run.sh /root/run.sh
RUN chmod 755 /root/run.sh

EXPOSE 2222

HEALTHCHECK CMD ["nc", "-z", "-w5", "localhost", "2222"]

CMD ["/root/run.sh"]