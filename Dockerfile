FROM golang:alpine@sha256:6c5c9590f169f77c8046e45c611d3b28fe477789acd8d3762d23d4744de69812 AS builder
# UPSTREAM_VERSION can be changed, by passing `--build-arg UPSTREAM_VERSION=<new version>` during docker build
ARG UPSTREAM_VERSION=master
ENV UPSTREAM_VERSION=${UPSTREAM_VERSION}
LABEL stage=builder
WORKDIR /workspace
#hadolint ignore=DL4006
RUN wget -nv -O - https://github.com/mxpv/podsync/archive/${UPSTREAM_VERSION}.tar.gz | tar -xz --strip-components=1; go build -o /bin/podsync ./cmd/podsync

FROM alpine:3.21.0@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && \
    apk --no-cache add ca-certificates ffmpeg tzdata python3 && \
    wget -q -O /usr/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && \
    chmod +x /usr/bin/yt-dlp && \
    ln -s /usr/bin/yt-dlp /usr/bin/youtube-dl
COPY --from=builder /bin/podsync .
CMD ["/app/podsync"]