```
kubectl port-forward svc/vault 8200:8200

export VAULT_ADDR='http://127.0.0.1:8200'
vault operator init
vault operator unseal
```
