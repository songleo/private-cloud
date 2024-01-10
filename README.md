This repository provides a tool that rapidly establishes a private cloud platform using kind. It's ideal for Proof of Concept (PoC), educational, or testing purposes.

# Prerequisites

- kubectl
- kind v0.20.0
- docker
- flux version 2.2.2
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
- Identity and Access Management
    - [ ] Keycloak
- Configuration Management
    - [x] Ansible/AWX: http://www.private-cloud.com/awx/#/home
    - [ ] Terraform
- GitOps
    - [ ] Jenkins
    - [x] Flux
    - [ ] Argo CD
- Message Queue
    - [ ] Kafka
    - [ ] RabbitMQ
- Security
    - [ ] Clair
    - [ ] Falco
    - [ ] Vault
    - [ ] Trivy
    - [ ] SonarQube
- Observability
    - [x] Metrics Server
    - [ ] Prometheus
    - [ ] Grafana
    - [ ] Alertmanager
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
kind load docker-image quay.io/ansible/awx-operator:2.10.0 --name private-cloud
kind load docker-image postgres:13 --name private-cloud
kind load docker-image docker.io/redis:7 --name private-cloud
kind load docker-image quay.io/ansible/awx:23.6.0 --name private-cloud
kind load docker-image quay.io/ansible/awx-ee:latest --name private-cloud
```
