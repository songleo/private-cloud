#!/usr/bin/env bash

echo "run deployment test ..."

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

# flux reconcile kustomization olm
# kubectl wait --timeout 300s --for=condition=available -n olm \
#     deployment/blackbox-exporter \
#     deployment/olm-operator \
#     deployment/packageserver \
#     || exit 1

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
# waiting awx ready
sleep 300
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
    deployment/weave-gitops \
    || exit 1

flux reconcile kustomization minio
kubectl wait --timeout 300s --for=condition=available -n minio \
    deployment/minio \
    || exit 1
