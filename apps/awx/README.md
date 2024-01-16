```
git clone git@github.com:ansible/awx-operator.git
cd awx-operator || exit
git checkout 2.10.0
IMG=quay.io/ansible/awx-operator:2.10.0 make deploy
cd ..
rm -rf awx-operator
# deploy the awx instance
kubectl apply -f awx/awx.yaml

kind load docker-image quay.io/ansible/awx-operator:2.10.0 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image postgres:13 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image docker.io/redis:7 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image quay.io/ansible/awx:23.6.0 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image quay.io/ansible/awx-ee:latest --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
```

### ref

- https://ansible.readthedocs.io/projects/awx-operator/en/latest/installation/basic-install.html
