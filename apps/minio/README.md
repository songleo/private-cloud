```
k apply -f minio-deployment.yaml

k port-forward svc/minio 9001:9001

mc alias set minio http://localhost:9000 minio minio123

mc mb minio/bucket
```
