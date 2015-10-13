FROM phusion/baseimage
MAINTAINER Chase Bolt <chase.bolt@gmail.com>

RUN apt-get -qy update && apt-get -qy upgrade && \
  apt-get install -qy xorriso syslinux && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ks.cfg /tmp/ks.cfg
ADD isolinux.cfg /tmp/isolinux.cfg

ADD build_img.sh /tmp/build_img.sh
RUN chmod -v +x /tmp/build_img.sh

VOLUME /data

CMD ["/sbin/my_init", "/tmp/build_img.sh"]
