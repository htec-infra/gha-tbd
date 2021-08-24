# Container image that runs your code
FROM alpine:3.14

ADD entrypoint.sh /entrypoint.sh

WORKDIR /app

COPY scripts/ .

ENTRYPOINT ["/entrypoint.sh"]
