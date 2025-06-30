FROM alpine:latest
RUN apk add --no-cache git bash
COPY auto_commit.sh /usr/local/bin/auto_commit.sh
ENTRYPOINT ["/usr/local/bin/auto_commit.sh"]
