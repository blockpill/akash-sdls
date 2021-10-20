#!/bin/bash

echo "RADICLE_REPO " $RADICLE_REPO
echo "INSTALL_COMMAND " $INSTALL_COMMAND
echo "BUILD_COMMAND " $BUILD_COMMAND
echo "START_COMMAND " $START_COMMAND
echo "ADMIN_USERNAME " $ADMIN_USERNAME
echo "ADMIN_PASSWORD " $ADMIN_PASSWORD

eval cd /

DEPLOY_STATUS="idle"

eval http-server -s --username $ADMIN_USERNAME --password $ADMIN_PASSWORD -p 8080 /var/tmp/logs >> /var/tmp/logs/log.txt 2>> /var/tmp/logs/log.txt &

# Run deploy.sh when server is started
eval '
  export RADICLE_REPO=$RADICLE_REPO; 
  export INSTALL_COMMAND=$INSTALL_COMMAND 
  export BUILD_COMMAND=$BUILD_COMMAND; 
  export START_COMMAND=$START_COMMAND; 
  export ADMIN_USERNAME=$ADMIN_USERNAME; 
  export ADMIN_PASSWORD=$ADMIN_PASSWORD; 
  export DEPLOY_STATUS=$DEPLOY_STATUS;
  ./deploy.sh
'


# Run webhook after server is started.  hook.json will re-run deploy.sh when the hook is triggered
eval  '
  export RADICLE_REPO=$RADICLE_REPO; 
  export INSTALL_COMMAND=$INSTALL_COMMAND 
  export BUILD_COMMAND=$BUILD_COMMAND; 
  export START_COMMAND=$START_COMMAND; 
  export ADMIN_USERNAME=$ADMIN_USERNAME; 
  export ADMIN_PASSWORD=$ADMIN_PASSWORD;
  export DEPLOY_STATUS=$DEPLOY_STATUS;
  webhook -hooks /hook.json -verbose >> /var/tmp/logs/log.txt 2>> /var/tmp/logs/log.txt 
'