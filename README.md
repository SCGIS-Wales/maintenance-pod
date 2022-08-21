# Containerised maintenance pod

Maintenance pod with swiss knife tools for ad-hoc support within a Kubernetes cluster


## Flavours

There are two (2) different flavours for the container images:

- **Ubuntu** container image

``
docker.io/ssddgreg/maintenance-pod:ubuntu-latest

``

- **Alpine**  container image

``
docker.io/ssddgreg/maintenance-pod:alpine-latest

``


## Example use as a Kubernetes deployment pod

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: maintenance-pod
  labels:
    app: maintenance-pod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: maintenance-pod
  template:
    metadata:
      labels:
        app: maintenance-pod
    spec:
      containers:
      - name: maintenance-pod
        image: ssddgreg/maintenance-pod:latest
        command: [ "sleep" ]
        args: [ "infinity" ]
        imagePullPolicy: IfNotPresent
        resources:
          limits:
            cpu: 1
            memory: 512Mi
          requests:
            cpu: 500m
            memory: 75Mi
```

## References

- location of the container image on Docker Hub<br>
[https://hub.docker.com/repository/docker/ssddgreg/maintenance-pod](https://hub.docker.com/repository/docker/ssddgreg/maintenance-pod)


## Known issues, limitations

