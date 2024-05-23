#!/bin/bash

BUILD_ID=$1

LOCAL_IMAGE="${BUILD_ID}:latest"
PUSH_IMAGE="krystianpanekwttech/aem-dispatcher-docker:${BUILD_ID}"

if [ -z "$BUILD_ID" ]; then
  echo "Usage: release.sh [centos7-httpd24-haproxy24|rocky8-httpd24-haproxy24|...]"
  exit 1
fi

docker build -f "${BUILD_ID}.Dockerfile" -t "${LOCAL_IMAGE}" . #&& \
#docker tag "${LOCAL_IMAGE}" "${PUSH_IMAGE}" && \
#docker push "${PUSH_IMAGE}"