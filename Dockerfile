FROM linuxserver/baseimage
MAINTAINER Chase Bolt <chase.bolt@gmail.com>

RUN apt-get -qy update && apt-get -qy upgrade && \
  apt-get install -qy xorriso && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ks.cfg /tmp/ks.cfg
ADD isolinux.cfg /tmp/isolinux.cfg

ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/my_init.d/*.sh

VOLUME /data
