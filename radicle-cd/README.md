# Akash Radicle CD

Akash Radicle CD is a continuous development SDL build file to test NextJs, ReactJS or static web page builds and preview them in the akash network.  


## Limitations

Radicle is still under development.  Radicle has no CLI and may experience replication issues which could cause the repo clone to fail. A discoverable Active Seed Node serving a radicle repo is necessary at this moment.

## Setup

Port 3000 will map to 80, always use this port for the public web app.
Port 8080 maps the logs.  Basic authentication is required using the ADMIN_USERNAME and ADMIN_PASSWORD.
Port 9000 maps to the webhook. 

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
```
