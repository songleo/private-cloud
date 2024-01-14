#!/usr/bin/env bash

# deploy kind cluster
# https://kind.sigs.k8s.io/docs/user/configuration/
kind create cluster --name private-cloud --config kind-conf/kind-config.yaml
kind export kubeconfig --name private-cloud

# deploy flux
# https://fluxcd.io/flux/get-started/
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=private-cloud \
  --branch=main \
  --path=./clusters/private-cloud \
  --personal \
  --private false

# PASSWORD="admin"
# gitops create dashboard ww-gitops \
#   --password=$PASSWORD \
#   --export > ./clusters/private-cloud/weave-gitops-dashboard.yaml
# git add -A && git commit -m "Add Weave GitOps Dashboard"
# git push
# kubectl port-forward svc/ww-gitops-weave-gitops -n flux-system 9001:9001
