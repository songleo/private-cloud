#!/usr/bin/env bash

echo "add the mapping of IP addresses and domain name"
IP_ADDRESS=$(hostname -I | awk '{print $1}')
HOSTNAME="www.private-cloud.com"
sudo sed -i "/$IP_ADDRESS /c\\$IP_ADDRESS $HOSTNAME" /etc/hosts

echo "test nginx ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/nginx | grep -q 200 || exit 1
echo "test awx ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/awx/#/home | grep -q 200 || exit 1
echo "test argocd ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/argocd | grep -q 308 || exit 1
echo "test prometheus ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/prometheus | grep -q 302 || exit 1
echo "test grafana ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/grafana | grep -q 302 || exit 1
echo "test alertmanager ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/alertmanager | grep -q 200 || exit 1
echo "test weave-gitops ingress"
curl -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/weave-gitops | grep -q 301 || exit 1
echo "test minio ingress"
curl -k -o /dev/null -s -w "%{http_code}" http://www.private-cloud.com/minio/ | grep -q 200 || exit 1
