```
git clone git@github.com:ansible/awx-operator.git
cd awx-operator || exit
git checkout 2.10.0
IMG=quay.io/ansible/awx-operator:2.10.0 make deploy
cd ..
rm -rf awx-operator
# deploy the awx instance
kubectl apply -f awx/awx.yaml
```

### ref

- https://ansible.readthedocs.io/projects/awx-operator/en/latest/installation/basic-install.html
