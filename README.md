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
- ```latest``` always refers to the latest tagged release ([Dockerfile])(https://github.com/tuxpeople/docker-podsync/blob/master/Dockerfile)

## Usage
You can either deploy this container standalone to test stuff, or use it as a side car if you need some special features in your pod. One use case as a side car is analyse traffic with tcpdump.

```sh
docker pull tdeutsch/podsync:<tag>
```

or

```sh
docker pull quay.io/tdeutsch/podsync:<tag>
```