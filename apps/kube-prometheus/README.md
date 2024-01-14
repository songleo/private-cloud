```
git clone git@github.com:prometheus-operator/kube-prometheus.git
cd kube-prometheus
git checkout release-0.13
kubectl apply --server-side -f manifests/setup
kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring
kubectl apply -f manifests/

k port-forward -n monitoring svc/prometheus-k8s 9090:9090
k port-forward -n monitoring svc/alertmanager-main 9093:9093
k port-forward -n monitoring svc/grafana 3000:3000

http://localhost:9090/targets?search=
http://localhost:9093/#/alerts
http://localhost:3000/
```

### ref

- https://github.com/prometheus-operator/kube-prometheus/tree/release-0.13
