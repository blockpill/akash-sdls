# Akash Github CD

Akash Github CD is a continuous development SDL build file to test and preview NextJs, ReactJS or static web page builds in the akash network.

<span style="color:red">This solution is a proof of concept for development purposes only.  Do not use any sensitive information with this solution, this include sensitive information in the environment variables or sensitive information in your github project. </span>


## Limitations

This is a proof of concept for development purposes only.  Do not use any sensitive information in the environment variables. 

## Setup

Port 3000 will map to 80.
Port 8080 maps to the build log file.  Basic authentication is required using the ADMIN_USERNAME and ADMIN_PASSWORD.
Port 9000 maps to the webhook service. 

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

To call the webhook when running in akash, create a webhook in github and add the Secret to the environment variable.  The webhook will redeploy the app anytime it is triggered. 

To setup githup webhook go to the project settings -> webhook and enter the url mapped to port 9000 with your WEBHOOOK_SECRET.

Payload URL*  (Replace the URL and Port to the forwarded_port mapped to the port 9000)
```
http://cluster.provider-0.prod.ams1.akash.pub:31742/hooks/redeploy-webhook
```

Content type
```
application/json
```

Secret
```
WEBHOOK_SECRET
```

## Environment Variables


### Required Variables

All variables are required.  Set the variable to "false" to ignore a COMMAND.
```
  - Github_REPO="https://github.com/blockpill/reactjs-starter"
  - INSTALL_COMMAND="yarn install --frozen-lockfile"
  - BUILD_COMMAND="yarn build"
  - START_COMMAND="serve -l 3000 -s build"
  - ADMIN_USERNAME="test"
  - ADMIN_PASSWORD="testing"
  - WEBHOOK_SECRET="webhooksecret"
```

## Examples
Replace the environment variables in the build.yml to run each example.

### NextJs 

To run a NextJs build, replace the environment variables in the YML file.  A new build is executed when the docker container is started.  
```
  - Github_REPO="https://github.com/blockpill/nextjs-starter"
  - INSTALL_COMMAND="yarn install --frozen-lockfile" 
  - BUILD_COMMAND="yarn build" 
  - START_COMMAND="yarn start" 
  - ADMIN_USERNAME="test"
  - ADMIN_PASSWORD="testing"
  - WEBHOOK_SECRET="webhooksecret"
```

### ReactJs

To run a React build, replace the environment variables in the YML file.  A new build is executed when the docker container is started. 
```
  - Github_REPO="https://github.com/blockpill/reactjs-starter"
  - INSTALL_COMMAND="yarn install --frozen-lockfile"
  - BUILD_COMMAND="yarn build"
  - START_COMMAND="serve -l 3000 -s build"
  - ADMIN_USERNAME="test"
  - ADMIN_PASSWORD="testing"
  - WEBHOOK_SECRET="webhooksecret"
```

### Serve Static/Public Files

To run a static website build, replace the environment variables in the YML file.  The build will serve all the html, css and image files in the public folder. 
```
- Github_REPO="https://github.com/blockpill/static-webpage"
- INSTALL_COMMAND="false"
- BUILD_COMMAND="false"
- START_COMMAND="http-server -s -p 3000 ./public"
- ADMIN_USERNAME="test"
- ADMIN_PASSWORD="testing"
- WEBHOOK_SECRET="webhooksecret"
```
