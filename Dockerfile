# Container image that runs your code
FROM alpine:3.14

WORKDIR /app

ADD entrypoint.sh .

COPY scripts/ .

RUN apk update && apk upgrade && apk add bash && apk add git

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
