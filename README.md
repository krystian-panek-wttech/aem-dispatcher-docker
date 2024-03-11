# AEM Dispatcher Docker Images

Collection of Docker images to support AEM dispatcher development when the target environment is AMS.
Supplement for: <https://github.com/adobe/aem-dispatcher-docker>.

Images are pushed to: <https://hub.docker.com/r/krystianpanekwttech/aem-dispatcher-docker/tags>

## Centos7 + HTTPD 2.4 + HAProxy 2.4

To support HTTP/2 and TLS 1.3, the image (see [Dockerfile](centos7-httpd24-haproxy24.Dockerfile)) is based on CentOS 7 and includes the latest version of HAProxy 2.4 and Apache HTTPD 2.4. 
The image is designed to be used to support local development for which the target/production environment is the AEM on AMS.