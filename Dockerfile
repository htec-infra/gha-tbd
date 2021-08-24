# Container image that runs your code
FROM alpine:3.10

WORKDIR /app

COPY scripts/ .
COPY entrypoint.sh .
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["entrypoint.sh"]
