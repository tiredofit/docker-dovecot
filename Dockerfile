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


### Setup Container for Dovecot
	    rm -rf /etc/dovecot/* && \
    	mkdir -p /var/lib/dovecot && \
    	ln -s /assets/certs/dhparam.pem /var/lib/dovecot/ssl-parameters.dat && \

### Cleanup
	    rm -rf /var/cache/apk/* /usr/src/*


### Add Files
	ADD install /

### Networking Configuration
	EXPOSE 110 143 993 995
