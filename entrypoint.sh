#!/bin/sh

if [ "$DEBUG" == "false" ]
then
  # Carry on, but do quit on errors
  set -e
else
  # Verbose debugging
  set -exuo pipefail
  export LOG_LEVEL=debug
fi

# Launch our probot app
probot receive -e $GITHUB_EVENT_NAME -p $GITHUB_EVENT_PATH /app/node_modules/probot-settings/index.js
