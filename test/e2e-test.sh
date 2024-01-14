#!/usr/bin/env bash

./install.sh

echo "run e2e test"

sleep 1200
flux get all
kubectl get po -A
