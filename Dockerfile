FROM golang:alpine AS builder
# UPSTREAM_VERSION can be changed, by passing `--build-arg UPSTREAM_VERSION=<new version>` during docker build
ARG UPSTREAM_VERSION=v1
ENV UPSTREAM_VERSION=${UPSTREAM_VERSION}
LABEL stage=builder
WORKDIR /workspace
#hadolint ignore=DL4006
RUN wget -nv -O - https://github.com/mxpv/podsync/archive/${UPSTREAM_VERSION}.tar.gz | tar -xz --strip-components=1; go build -o /bin/podsync ./cmd/podsync

FROM alpine:3.14.3
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && apk --no-cache add ca-certificates ffmpeg tzdata youtube-dl
COPY --from=builder /bin/podsync .
CMD ["/app/podsync"]
