## use the docker to simulate vm

we can use this Dockerfile to build a image and simulate the vm, then we can use the playbook to configure this vm:

```
docker run -d -p 11111:22 --name vm1 songleo/ubuntu-ssh
ssh admin@192.168.0.106 -p 11111
```

## build image

```
$ docker build -t songleo/ubuntu-ssh .
$ docker push songleo/ubuntu-ssh
```
