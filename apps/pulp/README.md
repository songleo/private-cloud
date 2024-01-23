```
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.26.0/install.sh | bash -s v0.26.0

kubectl create -f https://operatorhub.io/install/pulp-operator.yaml

kubectl apply -f cr.yaml
```

### ref

- https://docs.pulpproject.org/pulp_operator/quickstart/
