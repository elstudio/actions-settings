#!/bin/sh

set -e

if [ -n "$DEBUG" ]
then
  # Verbose debugging
  set -exuo pipefail
  export LOG_LEVEL=debug
fi

# Launch our probot app
probot receive -e $GITHUB_EVENT_NAME -p $GITHUB_EVENT_PATH /app/node_modules/probot-settings/index.js

# Try to remove the workflow file so we execute only when the repository is created
cd $GITHUB_WORKSPACE
rm .github/main.workflow
git add .github/main.workflow
git commit -m "Remove workflow file so it runs only once."
git push