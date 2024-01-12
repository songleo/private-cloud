This repository provides a tool that rapidly establishes a private cloud platform using kind. It's ideal for Proof of Concept (PoC), educational, or testing purposes.

# Prerequisites

- kubectl v1.27.3
- kind v0.20.0
- docker
- flux version 2.2.2
- weave-gitop 0.38.0
- $GITHUB_USER
- $GITHUB_TOKEN

Please ensure that you add the mapping of IP addresses and domain names in your `/etc/hosts` file. For example, if your local IP is `192.168.0.106`, you need to add the following content to your `/etc/hosts` file.

```
192.168.0.106 www.private-cloud.com
```

# Technology Stack

- Infrastructure
    - [x] Kubernetes
    - [x] Ingress NGINX
- Networking
    - [ ] Istio
- Database
    - [ ] MySQL
    - [ ] Redis
- Web Server
    - [x] [NGINX](http://www.private-cloud.com/nginx)
- Identity and Access Management
    - [ ] Keycloak
- Configuration Management
    - [x] [Ansible/AWX](http://www.private-cloud.com/awx/#/home)
    - [ ] Terraform
- GitOps
    - [ ] Jenkins
    - [x] Flux
    - [x] [Weave GitOps](http://www.private-cloud.com/weave-gitops)
    - [x] [Argo CD](http://www.private-cloud.com/argocd)
- Message Queue
    - [ ] Kafka
    - [ ] RabbitMQ
- Security
    - [ ] Clair
    - [ ] Falco
    - [ ] Vault
    - [ ] Trivy
    - [ ] SonarQube
    - [ ] cert-manager
- Observability
    - [x] Metrics Server
    - [x] [Prometheus](http://www.private-cloud.com/prometheus)
    - [x] [Grafana](http://www.private-cloud.com/grafana)
    - [x] [Alertmanager](http://www.private-cloud.com/alertmanager)
    - [ ] Loki
    - [ ] OTEL
    - [ ] Jaeger
- Image Registry
    - [ ] Harbor
- Project Management
    - [ ] GitLab
- Testing
    - [ ] Ginkgo
    - [ ] PyTest
- Backup and Disaster Recovery
    - [ ] Velero

# Troubleshooting

```
# flux
kind load docker-image ghcr.io/fluxcd/helm-controller:v0.37.2 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image ghcr.io/fluxcd/kustomize-controller:v1.2.1 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image ghcr.io/fluxcd/notification-controller:v1.2.3 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image ghcr.io/fluxcd/source-controller:v1.2.3 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker

# awx
kind load docker-image quay.io/ansible/awx-operator:2.10.0 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image postgres:13 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image docker.io/redis:7 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image quay.io/ansible/awx:23.6.0 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
kind load docker-image quay.io/ansible/awx-ee:latest --name private-cloud --nodes private-cloud-worker2,private-cloud-worker

# argocd
kind load docker-image quay.io/argoproj/argocd:v2.9.3 --name private-cloud --nodes private-cloud-worker2,private-cloud-worker
```
