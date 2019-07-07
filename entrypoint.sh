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


# Set up .netrc file with GitHub credentials
git_setup ( ) {
  cat <<- EOF > $HOME/.netrc
		machine github.com
		login $GITHUB_ACTOR
		password $GITHUB_TOKEN
		machine api.github.com
		login $GITHUB_ACTOR
		password $GITHUB_TOKEN
EOF
  chmod 600 $HOME/.netrc

  # Git requires our "name" and email address -- use GitHub handle
  git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
  git config user.name "$GITHUB_ACTOR"
  
  # Push to the current branch if PUSH_BRANCH hasn't been overriden
  : ${PUSH_BRANCH:=`echo "$GITHUB_REF" | awk -F / '{ print $3 }' `}
}


# Try to remove the workflow file so we execute only when the repository is created
git_setup
cd $GITHUB_WORKSPACE
rm .github/main.workflow
git add .github/main.workflow
git commit -m "Remove workflow file so it runs only once."
git push --set-upstream origin $PUSH_BRANCH
