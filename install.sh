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

# add label for ingress-nginx
kubectl label nodes private-cloud-control-plane ingress-ready="true"

# deploy flux
# https://fluxcd.io/flux/get-started/
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=private-cloud \
  --branch=main \
  --path=./clusters/private-cloud \
  --personal \
  --private false
