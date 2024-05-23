# Use Rocky Linux 8 as the base image
FROM --platform=linux/amd64 rockylinux:8.8

# Install EPEL repository, HTTPD, OpenSSL, OpenSSL development libraries and dependencies, and clean up
RUN yum -y install epel-release \
    && yum -y update \
    && yum -y install httpd openssl openssl-devel mod_ssl procps iputils tree telnet less sudo wget gcc perl pcre-devel zlib-devel make \
    && yum clean all \
    && rm -rf /var/cache/yum

# Build HAProxy 2.4 with OpenSSL 1.1 to support HTTP/2
RUN cd /tmp \
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