FROM tiredofit/alpine:edge
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Disable Features From Base Image
	ENV ENABLE_SMTP=false

### Install Dependencies
	RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
		apk update && \
	    apk add \
	        dovecot \
	        dovecot-ldap \
            dovecot-mysql \
            dovecot-pigeonhole-plugin \
            dovecot-pigeonhole-plugin-extdata \
            dovecot-pgsql \
            dovecot-sql \
            dovecot-sqlite \
            mariadb-client \
            postgresql-client \
            rspamd-client \
	        && \

### Create Vmail User
	    addgroup -S -g 5000 vmail && \
	    adduser -S -D -H -u 5000 -G vmail -g "Dovecot Vmail" vmail && \

### Setup Container for Dovecot
		rm -rf /etc/dovecot/* && \
	   	mkdir -p /var/lib/dovecot && \
        mkdir -p /var/log/dovecot && \

### Cleanup
	    rm -rf /var/cache/apk/* /usr/src/*


### Add Files
	ADD install /

### Networking Configuration
	EXPOSE 110 143 993 995
