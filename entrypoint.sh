#!/bin/sh

set -e
export DEBUG=true

if [ -n "$DEBUG" ]
then
  # Verbose debugging
  set -exuo pipefail
  export LOG_LEVEL=debug
fi

# Launch our probot app
probot receive -e $GITHUB_EVENT_NAME -p $GITHUB_EVENT_PATH /app/node_modules/probot-settings/index.js
