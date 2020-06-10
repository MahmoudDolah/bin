#!/usr/bin/env bash

URL=$(git config --get remote.origin.url)
echo "$URL"
GIT_REPO=$PWD
echo "$GIT_REPO"

cd ..

echo "removing repo"
rm -rf "$GIT_REPO"

git clone "$URL"

cd -
