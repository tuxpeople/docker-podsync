FROM golang:alpine@sha256:c8c5f95d64aa79b6547f3b626eb84b16a7ce18a139e3e9ca19a8c078b85ba80d AS builder
# UPSTREAM_VERSION can be changed, by passing `--build-arg UPSTREAM_VERSION=<new version>` during docker build
ARG UPSTREAM_VERSION=master
ENV UPSTREAM_VERSION=${UPSTREAM_VERSION}
LABEL stage=builder
WORKDIR /workspace
#hadolint ignore=DL4006
RUN wget -nv -O - https://github.com/mxpv/podsync/archive/${UPSTREAM_VERSION}.tar.gz \
    | tar -xz --strip-components=1 \
    && go get golang.org/x/net@v0.38.0 \
    && go build -o /bin/podsync ./cmd/podsync
# remove `go get golang.org/x/net@v0.38.0` once https://github.com/mxpv/podsync/pull/692 is merged

FROM alpine:3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && \
    apk --no-cache add ca-certificates ffmpeg tzdata python3 && \
    wget -q -O /usr/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && \
    chmod +x /usr/bin/yt-dlp && \
    ln -s /usr/bin/yt-dlp /usr/bin/youtube-dl
COPY --from=builder /bin/podsync .
CMD ["/app/podsync"]
