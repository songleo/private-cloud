#!/usr/bin/env bash

echo "install kind ..."
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "install kubectl ..."
curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "create kind cluster"
kind create cluster --name private-cloud --config kind-conf/kind-config.yaml

echo "install flux cli"
curl -s https://fluxcd.io/install.sh | sudo bash

echo "install flux"
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=private-cloud \
  --branch=main \
  --path=./clusters/private-cloud \
  --personal \
  --private false

# echo "running e2e test ..."
sleep 1200
flux get all
kubectl get po -A
