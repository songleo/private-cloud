#!/usr/bin/env bash

./install.sh

echo "run e2e test ..."

echo "reconcile flux resource ..."

flux reconcile source git flux-system
flux reconcile source git apps

flux reconcile kustomization flux-system
kubectl wait --timeout 300s --for=condition=available -n flux-system \
    deployment/helm-controller \
    deployment/kustomize-controller \
    deployment/notification-controller \
    deployment/source-controller \
    || exit 1

flux reconcile kustomization ingress-nginx
kubectl wait --timeout 300s --for=condition=available -n ingress-nginx \
    deployment/ingress-nginx-controller \
    || exit 1

flux reconcile kustomization metrics-server
kubectl wait --timeout 300s --for=condition=available -n kube-system \
    deployment/coredns \
    deployment/metrics-server \
    || exit 1

flux reconcile kustomization nginx
kubectl wait --timeout 300s --for=condition=available -n default \
    deployment/nginx \
    || exit 1

kubectl wait --timeout 300s --for=condition=available -n local-path-storage \
    deployment/local-path-provisioner \
    || exit 1

flux reconcile kustomization kube-prometheus
kubectl wait --timeout 300s --for=condition=available -n monitoring \
    deployment/blackbox-exporter \
    deployment/grafana \
    deployment/kube-state-metrics \
    deployment/prometheus-adapter \
    deployment/prometheus-operator \
    || exit 1

flux reconcile kustomization argocd
kubectl wait --timeout 300s --for=condition=available -n argocd \
    deployment/argocd-applicationset-controller \
    deployment/argocd-dex-server \
    deployment/argocd-notifications-controller \
    deployment/argocd-redis \
    deployment/argocd-repo-server \
    deployment/argocd-server \
    || exit 1

flux reconcile kustomization awx
kubectl wait --timeout 300s --for=condition=available -n awx \
    deployment/awx-operator-controller-manager \
    deployment/awx-task \
    deployment/awx-web \
    || exit 1

kubectl get statefulset/argocd-application-controller -n argocd | grep '1/1' || exit 1
kubectl get statefulset/awx-postgres-13 -n awx | grep '1/1' || exit 1
kubectl get statefulset/alertmanager-main -n monitoring | grep '1/1' || exit 1
kubectl get statefulset/prometheus-k8s -n monitoring | grep '1/1' || exit 1

flux reconcile kustomization weave-gitops
kubectl wait --timeout 300s --for=condition=available -n flux-system \
    deployment/ww-gitops-weave-gitops \
    || exit 1

# for debug
kubectl get po -A
kubectl get ingress -A
flux get all

echo "add the mapping of IP addresses and domain name"
IP_ADDRESS=$(hostname -I | awk '{print $1}')
HOSTNAME="www.private-cloud.com"
sudo sed -i "/$IP_ADDRESS /c\\$IP_ADDRESS $HOSTNAME" /etc/hosts

echo "verify all ingress ..."
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
