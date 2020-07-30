#!/usr/bin/env bash

set -e

CACHE_DIR=$HOME/carrot2/$CARROT2_VERSION

if [ ! -d "$CACHE_DIR" ]; then
  wget https://github.com/carrot2/carrot2/releases/download/release%2F$CARROT2_VERSION/carrot2-$CARROT2_VERSION.zip
  unzip carrot2-$CARROT2_VERSION.zip
  mv carrot2-$CARROT2_VERSION $CACHE_DIR
else
  echo "Carrot2 cached"
fi

cd $CACHE_DIR/dcs
./dcs.sh &
for i in {1..12}; do wget -O- -v http://127.0.0.1:8080/ && break || sleep 5; done
