#!/usr/bin/env bash

if which kind > /dev/null 2>&1; then
    echo "install kind ..."
    curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64"
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

if which kubectl > /dev/null 2>&1; then
    echo "install kubectl ..."
    curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
fi

if which flux > /dev/null 2>&1; then
    # https://fluxcd.io/flux/installation/#install-the-flux-cli
    echo "install flux cli"
    curl -s https://fluxcd.io/install.sh | sudo bash
fi

# https://kind.sigs.k8s.io/docs/user/configuration/
echo "create kind cluster"
kind create cluster --name private-cloud --config kind-conf/kind-config.yaml

# https://fluxcd.io/flux/get-started/
echo "install flux"
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
