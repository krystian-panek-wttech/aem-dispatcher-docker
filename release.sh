#!/bin/bash

BUILD_ID=$1

if [ -z "$BUILD_ID" ]; then
  echo "Usage: release.sh [centos7-httpd24-haproxy24|...]"
  exit 1
fi

docker build -f "${BUILD_ID}.Dockerfile" -t ${BUILD_ID}:latest . && \
docker tag ${BUILD_ID}:latest krystianpanekwttech:${BUILD_ID} && \
docker push krystianpanekwttech/aem-dispatcher-docker:${BUILD_ID}