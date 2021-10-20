#!/bin/bash

echo "REDEPLOY RADICLE_REPO " $RADICLE_REPO
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

if [[ -z "${RADICLE_REPO}" ]]; then
  echo "Error: RADICLE_REPO env not set. "
  export DEPLOY_STATUS="idle"
  exit 1
fi

if eval rm -rf /var/tmp/$(basename -s .git $RADICLE_REPO) ; then
  echo 'Active Repo Removed:: ' /var/tmp/$(basename -s .git $RADICLE_REPO)
else
  echo 'Filed to remove base file.'
  export DEPLOY_STATUS="idle"
  exit 1
fi


if eval git clone $RADICLE_REPO /var/tmp/$(basename -s .git $RADICLE_REPO) ; then
  echo 'Repo Cloned: ' $RADICLE_REPO
else
  echo 'Failed to clone directory.'
  export DEPLOY_STATUS="idle"
  exit 1
fi

if eval cd /var/tmp/$(basename -s .git $RADICLE_REPO) ; then
  echo 'CD ' $(basename -s .git $RADICLE_REPO)
else
  echo 'Cannot find directory ' $(basename $RADICLE_REPO)
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