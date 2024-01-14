#!/usr/bin/env bash

./install.sh

echo "run e2e test ..."

echo "reconcile flux resource ..."
flux reconcile source git flux-system
flux reconcile source git apps

flux reconcile helmrelease ww-gitops

flux reconcile kustomization flux-system
flux reconcile kustomization argocd
flux reconcile kustomization awx
flux reconcile kustomization ingress-nginx
flux reconcile kustomization kube-prometheus
flux reconcile kustomization metrics-server
flux reconcile kustomization nginx

echo "check all apps ..."
kubectl wait --timeout 60s --for=condition=available -n argocd \
    deployment/argocd-applicationset-controller \
    deployment/argocd-dex-server \
    deployment/argocd-notifications-controller \
    deployment/argocd-redis \
    deployment/argocd-repo-server \
    deployment/argocd-server \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n awx \
    deployment/awx-operator-controller-manager \
    deployment/awx-task \
    deployment/awx-web \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n default \
    deployment/nginx \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n flux-system \
    deployment/helm-controller \
    deployment/kustomize-controller \
    deployment/notification-controller \
    deployment/source-controller \
    deployment/ww-gitops-weave-gitops \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n ingress-nginx \
    deployment/ingress-nginx-controller \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n kube-system \
    deployment/coredns \
    deployment/metrics-server \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n local-path-storage \
    deployment/local-path-provisioner \
    || exit 1

kubectl wait --timeout 60s --for=condition=available -n monitoring \
    deployment/blackbox-exporter \
    deployment/grafana \
    deployment/kube-state-metrics \
    deployment/prometheus-adapter \
    deployment/prometheus-operator \
    || exit 1

kubectl get statefulset/argocd-application-controller -n argocd | grep '1/1' || exit 1
kubectl get statefulset/awx-postgres-13 -n awx | grep '1/1' || exit 1
kubectl get statefulset/alertmanager-main -n monitoring | grep '1/1' || exit 1
kubectl get statefulset/prometheus-k8s -n monitoring | grep '1/1' || exit 1
