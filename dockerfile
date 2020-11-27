FROM alpine:latest

RUN apk --update --no-cache upgrade && \
    apk add --update --no-cache bind \
    openrc \
    rm -rf /var/cache/apk/*

#Import init.sh and permition
ADD init.sh /init.sh
RUN chmod 750 /init.sh

#Create log file and create symbol link
RUN mkdir /var/log/named/ \
    && touch /var/log/named/general.log \
    && ln -sf /dev/stdout /var/log/named/general.log

#Import config file
ADD named.conf /etc/bind/

RUN rc-update add named sysinit \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

EXPOSE 53/udp

WORKDIR /etc/bind

CMD ["/init.sh"]


