# Use Rocky Linux 8 as the base image
FROM --platform=linux/amd64 rockylinux:8.8

# Set environment variable
ENV LD_LIBRARY_PATH=/usr/local/openssl11/lib

# Install EPEL repository, HTTPD and dependencies, and clean up
RUN yum -y install epel-release \
    && yum -y update \
    && yum -y install httpd mod_ssl procps iputils tree telnet less sudo wget gcc perl pcre-devel zlib-devel make \
    && yum clean all \
    && rm -rf /var/cache/yum

# Build HAProxy 2.4 with OpenSSL 1.1 to support HTTP/2
RUN cd /tmp \
    && wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz \
    && tar xzvf openssl-1.1.1l.tar.gz \
    && cd openssl-1.1.1l \
    && ./config --prefix=/usr/local/openssl11 --openssldir=/usr/local/openssl11 \
    && make \
    && make install \
    && cd .. \
    && wget http://www.haproxy.org/download/2.4/src/haproxy-2.4.25.tar.gz \
    && tar xzvf haproxy-2.4.25.tar.gz \
    && cd haproxy-2.4.25 \
    && make TARGET=linux-glibc USE_OPENSSL=1 SSL_INC=/usr/local/openssl11/include SSL_LIB=/usr/local/openssl11/lib \
    && make install \
    && make install-bin \
    && ln -sf /usr/local/sbin/haproxy /usr/sbin/haproxy \
    && groupadd haproxy \
    && useradd -g haproxy haproxy \
    && mkdir -p /var/lib/haproxy \
    && chown haproxy:haproxy /var/lib/haproxy \
    && rm -rf /tmp/*