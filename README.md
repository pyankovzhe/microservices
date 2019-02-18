# Microservices

Original reddit application — https://github.com/Artemmkin/reddit

### GCP
With docker-machine and GCP

```sh
docker-machine create --driver google --google-project <gcp-project-id> --google-zone europe-west1-b --google-machine-type g1-small --google-machine-image $(gcloud compute images list --filter ubuntu-1604-lts --uri) docker-host

eval $(docker-machine env docker-host)
```

### Build project

```sh
docker pull mongo:latest
docker build -t post:1.0 ./post-py
docker build -t comment:1.0 ./comment
docker build -t ui:1.0 ./ui
docker network create reddit
docker volume create reddit_db
```

### Run project

```sh
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post post:1.0
docker run -d --network=reddit --network-alias=comment comment:1.0
docker run -d --network=reddit -p 9292:9292 ui:1.0
```

Or

### Run microservices in different network

ui service will not have access to db

```sh
docker network create back_net --subnet=10.0.2.0/24
docker network create front_net --subnet=10.0.1.0/24

docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=back_net --name post post:1.0
docker run -d --network=back_net --name comment comment:1.0
docker run -d --network=front_net -p 9292:9292 --name ui ui:1.0

# Connect post and comment containers to front_net network
docker network connect front_net post
docker network connect front_net comment
```

http://host:9292

### Mount work dir:
```sh
docker run --rm --mount type=bind,source="$(pwd)"/comment,destination=/app comment:1.0 bundle install
```

---

## Docker Compose

Use .env.local to override environment variables

```sh
docker-compose up -d
```
