# Akash Radicle CD

Akash Radicle CD is a continuous development SDL build file to test NextJs, ReactJS or static web page builds and preview them in the akash network.  

<span style="color:red">This solution is a proof of concept for development purposes only.  Do not use any sensitive information with this solution, this include environment variables or your github project. </span>


## Limitations

This is a proof of concept for development purposes only.  Do not use any sensitive information in the environment variables.  Radicle is still under development.  Radicle has no CLI and may experience replication issues which could cause the repo clone to fail. A discoverable Active Seed Node serving a radicle repo is necessary at this moment. 

## Setup

Port 3000 will map to 80, always use this port for the public web app.
Port 8080 maps the build log file.  Basic authentication is required using the ADMIN_USERNAME and ADMIN_PASSWORD.
Port 9000 maps to the webhook service. A token needs to be provided in the url to re-deploy the solution.

## Check deploy logs

Deploy logs are served in the log.txt file.  

Navigate to the log.txt url to access logs. Use the ADMIN_USERNAME and to login ADMIN_PASSWORD. Logs are for development purposes only, they are not secure and not served through a secured connection.

```
http://url:8080/logs.txt
```

```
http://cluster.provider-0.prod.ams1.akash.pub:31841/log.txt
```

## Webhook

At the moment of writing this, Radicle does not have webhook capabilities.  The webhook in this solution will deploy the github repo.  Webhook is for development purposes only, the url to invoke the webhook is not secure. 

To call the webhook when running locally:
```
http://url:9000/hooks/redeploy-webhook?token=WEBHOOK_TOKEN
```

To call the webhook when running in akash, replace url and port with the forwarded_ports returned by the lease-status of your akash service.
```
http://cluster.provider-0.prod.ams1.akash.pub:31742/hooks/redeploy-webhook?token=WEBHOOK_TOKEN
```

## Environment Variables


### Required Variables

All variables are required.  Set the variable to "false" to ignore a COMMAND.
```
  - RADICLE_REPO="https://github.com/blockpill/reactjs-starter"
  - INSTALL_COMMAND="yarn install --frozen-lockfile"
  - BUILD_COMMAND="yarn build"
  - START_COMMAND="serve -l 3000 -s build"
  - ADMIN_USERNAME="test"
  - ADMIN_PASSWORD="testing"
  - WEBHOOK_TOKEN="webhooktoken"
```

## Examples
Replace the environment variables in the build.yml to run each example.

### NextJs 

To run a NextJs build, replace the environment variables in the YML file with the following environment variables.  A new build is executed when the docker container is started.  
```
  - RADICLE_REPO="https://github.com/blockpill/nextjs-starter"
  - INSTALL_COMMAND="yarn install --frozen-lockfile" 
  - BUILD_COMMAND="yarn build" 
  - START_COMMAND="yarn start" 
  - ADMIN_USERNAME="test"
  - ADMIN_PASSWORD="testing"
  - WEBHOOK_TOKEN="webhooktoken"
```

### ReactJs

To run a React build, replace the environment variables in the YML file with the following environment variables.  A new build is executed when the docker container is started. 
```
  - RADICLE_REPO="https://github.com/blockpill/reactjs-starter"
  - INSTALL_COMMAND="yarn install --frozen-lockfile"
  - BUILD_COMMAND="yarn build"
  - START_COMMAND="serve -l 3000 -s build"
  - ADMIN_USERNAME="test"
  - ADMIN_PASSWORD="testing"
  - WEBHOOK_TOKEN="webhooktoken"
```

### Serve Static/Public Files

To run a static website build, replace the environment variables in the YML file with the following environment variables.  The build will serve all the html, css and image files in the public folder. 
```
- RADICLE_REPO="https://github.com/blockpill/static-webpage"
- INSTALL_COMMAND="false"
- BUILD_COMMAND="false"
- START_COMMAND="http-server -s -p 3000 ./public"
- ADMIN_USERNAME="test"
- ADMIN_PASSWORD="testing"
- WEBHOOK_TOKEN="webhooktoken"
```
