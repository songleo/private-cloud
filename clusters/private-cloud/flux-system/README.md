```
kind load docker-image ghcr.io/fluxcd/helm-controller:v0.37.2 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image ghcr.io/fluxcd/kustomize-controller:v1.2.1 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image ghcr.io/fluxcd/notification-controller:v1.2.3 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image ghcr.io/fluxcd/source-controller:v1.2.3 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
```
