#!/usr/bin/env bash

cat <<EOF > /tmp/config.toml
[server]
port = 8080
data_dir = "/data"
hostname = "http://localhost"

[database]
badger = { truncate = true, file_io = true }

[tokens]
youtube = "$YTTOKEN"

[feeds]
    [feeds.testfeed]
    url = "https://www.youtube.com/user/bbcnews"
    page_size = 1
    update_period = "100h"
    quality = "high"
    format = "audio"
    clean = { keep_last = 1 }

[downloader]
self_update = true
EOF

docker run --name=test -p 8080:8080 -d -v /tmp/config.toml:/app/config.toml:ro --health-cmd='wget localhost:8080/podsync.opml -O - > /dev/null' --health-interval=10s ${TESTIMAGE}

sleep 5

while [  $(docker inspect --format='{{.State.Health.Status}}' test) != "healthy" ]
do
  echo "Wait for image to become healthy"
  sleep 10
done

FILE=$(docker logs test 2>&1 | grep "creating file" | grep mp3 | cut -d'=' -f5)
wget -q localhost:8080/${FILE} -O - > /dev/null

RET=$?
if [ $RET == "0" ]; then
    echo "Testfile downloaded"
else
    echo "Failed to download testfile"
    exit 1
fi

docker stop test
docker rm test

rm /tmp/config.toml
