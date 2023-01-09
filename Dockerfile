FROM golang:alpine AS builder
# UPSTREAM_VERSION can be changed, by passing `--build-arg UPSTREAM_VERSION=<new version>` during docker build
ARG UPSTREAM_VERSION=master
ENV UPSTREAM_VERSION=${UPSTREAM_VERSION}
LABEL stage=builder
WORKDIR /workspace
#hadolint ignore=DL4006
RUN wget -nv -O - https://github.com/mxpv/podsync/archive/${UPSTREAM_VERSION}.tar.gz | tar -xz --strip-components=1; go build -o /bin/podsync ./cmd/podsync

FROM alpine:3.17.1
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && \
    apk --no-cache add ca-certificates ffmpeg tzdata python3 && \
    wget -q -O /usr/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && \
    chmod +x /usr/bin/yt-dlp && \
    ln -s /usr/bin/yt-dlp /usr/bin/youtube-dl
COPY --from=builder /bin/podsync .
CMD ["/app/podsync"]