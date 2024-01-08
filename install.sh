#!/usr/bin/env bash

# deploy kind cluster
# https://kind.sigs.k8s.io/docs/user/configuration/
# for testing
kind delete cluster --name private-cloud
# for testing
kind create cluster --name private-cloud --config kind/kind-config.yaml
kind export kubeconfig --name private-cloud
kubectl label nodes private-cloud-worker node-role.kubernetes.io/worker=worker
kubectl label nodes private-cloud-worker2 node-role.kubernetes.io/worker=worker
kubectl label nodes private-cloud-control-plane ingress-ready="true"

# deploy ingress-nginx
# https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx
kubectl apply -f ingress-nginx/deploy.yaml

# deploy flux
# https://fluxcd.io/flux/get-started/
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=private-cloud \
  --branch=main \
  --path=./clusters/private-cloud \
  --personal \
  --private false

# deploy podinfo app via flux
git clone https://github.com/$GITHUB_USER/fleet-infra
cd fleet-infra
mkdir -p ./clusters/private-cloud/podinfo
flux create source git podinfo \
  --url=https://github.com/songleo/podinfo \
  --branch=master \
  --interval=1m \
  --export > ./clusters/private-cloud/podinfo/podinfo-source.yaml
git add -A && git commit -m "Add podinfo GitRepository"
git push

flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --wait=true \
  --interval=30m \
  --retry-interval=2m \
  --health-check-timeout=3m \
  --export > ./clusters/private-cloud/podinfo/podinfo-kustomization.yaml
git add -A && git commit -m "Add podinfo Kustomization"
git push

# deploy metrics-server with --kubelet-insecure-tls
# https://github.com/kubernetes-sigs/metrics-server?tab=readme-ov-file#installation
kubectl apply -f metrics-server/components.yaml

# deploy the awx
# https://ansible.readthedocs.io/projects/awx-operator/en/latest/installation/basic-install.html
git clone git@github.com:ansible/awx-operator.git
cd awx-operator || exit
git checkout 2.10.0
IMG=quay.io/ansible/awx-operator:2.10.0 make deploy
cd ..
rm -rf awx-operator
# deploy the awx instance
kubectl apply -f awx/awx.yaml
