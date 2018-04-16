# Sensu-client docker container.
## This was intended to be a minimal sensu-client container, but has grown with plugins and the like.



All cofiguration values are passed as environment variables. eg.

Running this as-is:
```
docker build -t sensu-client:latest .
docker run -dit -e "SENSU_SERVER=127.0.0.1" -e "SENSU_USER=sensu" -e "SENSU_PASSWORD=password" -e "CLIENT_IP_ADDRESS=127.0.0.1" -e "CLIENT_NAME=wibble" sensu-server:latest
```

To pull the latest pre-built image from Docker Hub:
```
docker pull megah3rtz/sensu-client
docker run -dit -e "SENSU_SERVER=127.0.0.1" -e "SENSU_USER=sensu" -e "SENSU_PASSWORD=password" -e "CLIENT_IP_ADDRESS=127.0.0.1" -e "CLIENT_NAME=wibble" sensu-server:latest
```

For a sensu server, I would suggest using this sensu-server docker container:
https://github.com/hiroakis/docker-sensu-server

This also includes a buildspec.yml for automating builds with AWS Codebuild, and pushes to DockerHub.

