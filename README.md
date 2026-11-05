> [!IMPORTANT]
> **This image is no longer maintained, use the official image instead:** [`ghcr.io/mxpv/podsync`](https://github.com/mxpv/podsync/pkgs/container/podsync). Upstream now ships yt-dlp ([mxpv/podsync#683](https://github.com/mxpv/podsync/pull/683)) and arm64 images, the two reasons this image existed. It also includes `deno`, which yt-dlp now needs for YouTube.
>
> It is a drop-in replacement (same `/app/config.toml`, same binary):
>
> ```yaml
> image: ghcr.io/mxpv/podsync:v2.8.0   # or :nightly, built daily from master
> ```
>
> With a release tag, let yt-dlp update itself in `config.toml`:
>
> ```toml
> [downloader]
> self_update = true
> ```
>
> **arm/v6 and arm/v7:** upstream has no images for these. The last image here stays available but gets no updates.
>
> This repository is archived.

# Podsync
![Github Workflow Badge](https://github.com/tuxpeople/docker-podsync/actions/workflows/release.yml/badge.svg)
![Github Last Commit Badge](https://img.shields.io/github/last-commit/tuxpeople/docker-podsync)
![Docker Pull Badge](https://img.shields.io/docker/pulls/tdeutsch/podsync)
![Docker Stars Badge](https://img.shields.io/docker/stars/tdeutsch/podsync)
![Docker Size Badge](https://img.shields.io/docker/image-size/tdeutsch/podsync)

    Caution: No more quay.io!

**Warning:** This image now uses [yt-dlp](https://github.com/yt-dlp/yt-dlp) instead of [youtube-dl](https://github.com/ytdl-org/youtube-dl/)  
*(see https://github.com/mxpv/podsync/issues/236 and https://github.com/mxpv/podsync/issues/237)*
## Quick reference

This Repo is solely for me having an arm64 image for [Podsync](https://github.com/mxpv/podsync). It includes a GitHub Workflow to build Podsync for AMD64, ARM64, ARMv6 and ARMv7. Use it at your own risk. No warranty. No support.

Read here for more: https://github.com/mxpv/podsync/issues/56

* **Code repository:**
  https://github.com/tuxpeople/docker-podsync
* **Where to file issues:**
  https://github.com/tuxpeople/docker-podsync/issues
* **Supported architectures:**
  ```amd64```, ```armv7```, ```armv6``` and ```arm64```

## Image tags
- There are tags for major, minor and dotreleases of podsync (eg. ```1.0.0```, ```1.0```, ```1``` )
- ```latest``` refers to the latest release of podsync

The images get rebuilt automatically every week.
## Usage

```sh
docker pull tdeutsch/podsync:<tag>
```

or

```sh
docker pull ghcr.io/tuxpeople/podsync:<tag>
```
