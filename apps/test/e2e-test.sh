#!/usr/bin/env bash

echo "running e2e test ..."

echo "install kind ..."
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "create kind cluster"
kind create cluster

echo "install kubectl ..."
curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "running e2e test ..."
kubectl cluster-info
