This directory contains all the files used to build the custom Docker image. 

# Build Image
```bash
  docker build . -t blockpilld/github-cd:1.3
```

# Run docker container locally
The following commands will run the container locally after the image has been built.
## NextJS Test
```bash
  docker run \
  --env GITHUB_REPO="https://github.com/blockpill/nextjs-starter.git" \
  --env INSTALL_COMMAND="yarn install --frozen-lockfile" \
  --env BUILD_COMMAND="yarn build" \
  --env START_COMMAND="yarn start" \
  --env ADMIN_USERNAME="test" \
  --env ADMIN_PASSWORD="testing" \
  --env WEBHOOK_SECRET="webhooksecret" \
  --name client_container \
  -p 3000:3000  -p 8080:8080 -p 9000:9000 \
  blockpilld/github-cd:1.3
```

## ReactJS Test
```bash
  docker run \
  --env GITHUB_REPO="https://github.com/blockpill/reactjs-starter" \
  --env INSTALL_COMMAND="yarn install --frozen-lockfile" \
  --env BUILD_COMMAND="yarn build" \
  --env START_COMMAND="serve -l 3000 -s build" \
  --env ADMIN_USERNAME="test" \
  --env ADMIN_PASSWORD="testing" \
  --env WEBHOOK_SECRET="webhooksecret" \
  --name client_container \
  -p 3000:3000  -p 8080:8080 -p 9000:9000 \
  blockpilld/github-cd:1.3
```

## Static Web Page Test
```bash
  docker run \
  --env GITHUB_REPO="https://github.com/blockpill/static-webpage" \
  --env INSTALL_COMMAND="false" \
  --env BUILD_COMMAND="false" \
  --env START_COMMAND="http-server -s -p 3000 ./public" \
  --env ADMIN_USERNAME="test" \
  --env ADMIN_PASSWORD="testing" \
  --env WEBHOOK_SECRET="webhooksecret" \
  --name client_container \
  -p 3000:3000  -p 8080:8080 -p 9000:9000 \
  blockpilld/github-cd:1.3
```

# Test build-script.sh
The following commands are for testing the build-script.sh. 

## NextJS Test
```bash
  export GITHUB_REPO="https://github.com/blockpill/nextjs-starter.git"; \
  export INSTALL_COMMAND="yarn install --frozen-lockfile"; \
  export BUILD_COMMAND="yarn build"; \
  export START_COMMAND="yarn start"; \
  export ADMIN_USERNAME="test"; \
  export ADMIN_PASSWORD="testing"; \
  export WEBHOOK_SECRET="webhooksecret" \
  ./build-script.sh  
      
```

## Static Web Page Test
```bash
  export GITHUB_REPO="https://github.com/blockpill/static-webpage.git"; \
  export INSTALL_COMMAND="false"; \
  export BUILD_COMMAND="false"; \
  export START_COMMAND="http-server -s -p 3000 ./public"; \
  export ADMIN_USERNAME="test"; \
  export ADMIN_PASSWORD="testing"; \
  export WEBHOOK_SECRET="webhooksecret" \
  ./build-script.sh  
```


