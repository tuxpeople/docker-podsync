# Podsync
![Github Workflow Badge](https://github.com/tuxpeople/docker-podsync/actions/workflows/release.yml/badge.svg)
![Github Last Commit Badge](https://img.shields.io/github/last-commit/tuxpeople/docker-podsync)
![Docker Pull Badge](https://img.shields.io/docker/pulls/tdeutsch/podsync)
![Docker Stars Badge](https://img.shields.io/docker/stars/tdeutsch/podsync)
![Docker Size Badge](https://img.shields.io/docker/image-size/tdeutsch/podsync)

## Quick reference

This Repo is solely for me having a arm64 image for [Podsync](https://github.com/mxpv/podsync). It includes a GitHub Workflow to build Podsync for AMD64, ARM64, ARMv6 and ARMv7. Use it at your own risk. No warranty. No support.

Read here for more: https://github.com/mxpv/podsync/issues/56

* **Code repository:**
  https://github.com/tuxpeople/docker-podsync
* **Where to file issues:**
  https://github.com/tuxpeople/docker-podsync/issues
* **Supported architectures:**
  ```amd64```, ```armv7```, ```armv6``` and ```arm64```

## Image tags
- ```latest``` gets automatically built on every push to master and also via a weekly cron job
- There are tags for major, minor and dotreleases (eg. ```1.0.0```, ```1.0```, ```1``` )

## Usage

```sh
docker pull tdeutsch/podsync:<tag>
```

or

```sh
docker pull quay.io/tdeutsch/podsync:<tag>
```