# Container image that runs your code
FROM alpine:3.14

WORKDIR /app

ADD entrypoint.sh .

COPY scripts/ .

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
