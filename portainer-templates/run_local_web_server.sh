#!/bin/bash

set -e

LOCAL_PORT=8080
REAL_NIC=$(lshw -C network -short 2>/dev/null | grep network | tr -s ' ' | cut -d' ' -f2)
LOCAL_IP=$(ifconfig $REAL_NIC | grep "inet " | tr -s ' ' | cut -d' ' -f3)
LOCAL_DIR=$(realpath $(pwd)/../)

echo "Hosted Path:"
echo "${LOCAL_DIR}"
echo ""

echo "Template file:"
echo "http://${LOCAL_IP}:8080/portainer-templates/templates.json"
echo ""

echo "Docker container (mini-web):"
docker run --name mini-web -p ${LOCAL_PORT}:3000 -v ${LOCAL_DIR}:/app/public:ro -d tobilg/mini-webserver
echo ""

echo "To stop web server:"
echo "docker container stop mini-web && docker container rm mini-web"
echo ""
