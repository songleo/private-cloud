This repository primarily offers a tool that enables users to quickly build a private cloud platform on Kubernetes. This platform is mainly intended for the research and study of various [cloud-native projects](https://landscape.cncf.io/) and technologies.

# Prerequisites

- kubectl v1.27.3
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

- Orchestration & Management
  - [x] Kubernetes
  - [x] Ingress NGINX
- Web Server
  - [x] [NGINX](http://www.private-cloud.com/nginx)
- Automation & Configuration
  - [x] [Ansible/AWX](http://www.private-cloud.com/awx/#/home)
- Continuous Integration & Delivery
  - [x] Flux
  - [x] [Weave GitOps](http://www.private-cloud.com/weave-gitops)
  - [x] [Argo CD](http://www.private-cloud.com/argocd)
- Observability and Analysis
  - [x] Metrics Server
  - [x] [Prometheus](http://www.private-cloud.com/prometheus)
  - [x] [Grafana](http://www.private-cloud.com/grafana)
  - [x] [Alertmanager](http://www.private-cloud.com/alertmanager)
- Cloud Native Storage
  - [x] [MinIO](https://www.private-cloud.com/minio/)
- Key Management
  - [x] Vault
- Security & Compliance
  - [x] external-secrets

# Deploy

```
./install.sh
```

# Test

```
./test/deployment-test.sh
./test/ingress-test.sh
```
