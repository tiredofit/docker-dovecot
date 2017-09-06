FROM tiredofit/alpine:3.6
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Disable Features From Base Image
ENV ENABLE_SMTP=false

### Install Dependencies
RUN apk update && \
    apk add \
        dovecot \
        dovecot-ldap \
        && \

### Remove Dovecot Configuration Files
    rm -rf /etc/dovecot/* && \

### Cleanup
    rm -rf /var/cache/apk/* /usr/src/*


### Add Files
ADD install /

### Networking Configuration
EXPOSE 110 143 993 995
