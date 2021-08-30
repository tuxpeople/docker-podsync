FROM golang:alpine AS builder
# PODSYNC_VERSION can be changed, by passing `--build-arg PODSYNC_VERSION=<new version>` during docker build
ARG PODSYNC_VERSION=v1
ENV PODSYNC_VERSION=${PODSYNC_VERSION}
LABEL stage=builder
WORKDIR /workspace
#hadolint ignore=DL4006
RUN wget -nv -O - https://github.com/mxpv/podsync/archive/${PODSYNC_VERSION}.tar.gz | tar -xz --strip-components=1; go build -o /bin/podsync ./cmd/podsync

FROM alpine:3.14.2
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && apk --no-cache add ca-certificates ffmpeg tzdata youtube-dl
COPY --from=builder /bin/podsync .
CMD ["/app/podsync"]
