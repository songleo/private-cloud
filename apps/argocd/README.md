```
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

kind load docker-image quay.io/argoproj/argocd:v2.9.3 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
```

### ref

- https://argo-cd.readthedocs.io/en/stable/getting_started/
