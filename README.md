# microservices

Build project

```
docker-machine create --driver google --google-project <gcp-project-id> --google-zone europe-west1-b --google-machine-type g1-small --google-machine-image $(gcloud compute images list --filter ubuntu-1604-lts --uri) docker-host
```
```
eval $(docker-machine env docker-host)
```

Run container with reddit app
```
docker run --name reddit -d --network=host reddit:latest
```
