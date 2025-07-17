FROM golang:alpine@sha256:daae04ebad0c21149979cd8e9db38f565ecefd8547cf4a591240dc1972cf1399 AS builder
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

FROM alpine:3.22.0@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && \
    apk --no-cache add ca-certificates ffmpeg tzdata python3 && \
    wget -q -O /usr/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && \
    chmod +x /usr/bin/yt-dlp && \
    ln -s /usr/bin/yt-dlp /usr/bin/youtube-dl
COPY --from=builder /bin/podsync .
CMD ["/app/podsync"]
