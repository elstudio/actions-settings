#!/bin/sh

set -e

WD_PATH=/app
PATH=$PATH:/app/node_modules/.bin

if [ -n "$WD_PATH" ]
then
  echo "Changing dir to $WD_PATH"
  cd $WD_PATH
fi

#echo "Installing NPM dependencies"
#npm install --production

echo ls .
ls .
echo ls /app/node_modules
ls /app/node_modules
echo ls /app/node_modules/.bin
ls /app/node_modules/.bin

echo "Running probot/settings"
probot receive /app/index.js
