#!/bin/bash

echo "REDEPLOY GITHUB_REPO " $GITHUB_REPO
echo "DEPLOY STATUS"  $DEPLOY_STATUS

if [[ -z "${DEPLOY_STATUS}" ]]; then
  echo "Error: DEPLOY_STATUS env not set. " $DEPLOY_STATUS
  exit 1
else
  case "$DEPLOY_STATUS" in
    "active") 
      echo "Deploy already in progress " $DEPLOY_STATUS
      exit 1
    ;;
  esac
fi

export DEPLOY_STATUS="active"

eval cd /var/tmp

if [[ -z "${GITHUB_REPO}" ]]; then
  echo "Error: GITHUB_REPO env not set. "
  export DEPLOY_STATUS="idle"
  exit 1
fi

echo $(basename -s .git $GITHUB_REPO)
ls /var/tmp

if eval rm -rf /var/tmp/$(basename -s .git $GITHUB_REPO) ; then
  echo 'Active Repo Removed:: ' /var/tmp/$(basename -s .git $GITHUB_REPO)
else
  echo 'Filed to remove base file.'
  export DEPLOY_STATUS="idle"
  exit 1
fi


if eval git clone $GITHUB_REPO /var/tmp/$(basename -s .git $GITHUB_REPO) ; then
  echo 'Repo Cloned: ' $GITHUB_REPO
else
  echo 'Failed to clone directory.'
  export DEPLOY_STATUS="idle"
  exit 1
fi

if eval cd /var/tmp/$(basename -s .git $GITHUB_REPO) ; then
  echo 'CD ' $(basename -s .git $GITHUB_REPO)
else
  echo 'Cannot find directory ' $(basename $GITHUB_REPO)
  export DEPLOY_STATUS="idle"
  exit 1
fi

# Destroy any service using the default App port. 
eval kill -9 $(lsof -t -i:3000)

echo 'Running Install Command: '${INSTALL_COMMAND}
eval $INSTALL_COMMAND >> /var/tmp/logs/log.txt 2>> /var/tmp/logs/log.txt

echo 'Running Build Command: '${BUILD_COMMAND}
eval $BUILD_COMMAND >> /var/tmp/logs/log.txt 2>> /var/tmp/logs/log.txt

echo 'Running Start Command: '${START_COMMAND}
eval $START_COMMAND >> /var/tmp/logs/log.txt 2>> /var/tmp/logs/log.txt &

export DEPLOY_STATUS="idle"

echo "Execution finalized, Build Status: " $DEPLOY_STATUS