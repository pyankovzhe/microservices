# microservices

Build project

```sh
docker pull mongo:latest
docker build -t pyankov/post:1.0 ./post-py
docker build -t pyankov/comment:1.0 ./comment
docker build -t pyankov/ui:1.0 ./ui
docker network create reddit
docker volume create reddit_db
```

Run project

```sh
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post pyankov/post:1.0
docker run -d --network=reddit --network-alias=comment pyankov/comment:1.0
docker run -d --network=reddit -p 9292:9292 pyankov/ui:1.0
```

http://0.0.0.0:9292
