FROM tiredofit/alpine:edge
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Disable Features From Base Image
ENV ENABLE_SMTP=false

### Install Dependencies
RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .dovecot-run-deps \
        		dovecot \
		        dovecot-ldap \
		        dovecot-mysql \
		        dovecot-pigeonhole-plugin \
		        dovecot-pgsql \
		        dovecot-sql \
		        dovecot-sqlite \
		        mariadb-client \
		        postgresql-client \
		        rspamd-client \
		        && \
    \
### Create Vmail User
    addgroup -S -g 5000 vmail && \
    adduser -S -D -H -u 5000 -G vmail -g "Dovecot Vmail" vmail && \
    \
### Setup Container for Dovecot
    rm -rf /etc/dovecot/* && \
    mkdir -p /var/lib/dovecot && \
    mkdir -p /var/log/dovecot && \
    \
### Cleanup
    rm -rf /var/cache/apk/* /usr/src/*

### Networking Configuration
EXPOSE 110 143 993 995

### Add Files
ADD install /
