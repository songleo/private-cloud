```
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.26.0/install.sh | bash -s v0.26.0

kubectl create -f https://operatorhub.io/install/pulp-operator.yaml

kubectl apply -f cr.yaml

kubectl get secret pulp-admin-password -n awx -o jsonpath="{.data.password}" | base64 --decode && echo

k port-forward -n awx svc/pulp-web-svc 24880:24880

k port-forward -n awx po/pulp-worker-759fc8795b-gvtnl 8080:8080

curl localhost:24880/pulp/api/v3/status/ | jq .



```

### ref

- https://docs.pulpproject.org/pulp_operator/quickstart/
