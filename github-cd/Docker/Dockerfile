FROM node:lts

RUN apt-get update
RUN apt-get install webhook lsof

RUN npm install http-server -g
RUN yarn global add serve

ENV NODE_ENV=production
ENV GITHUB_REPO="https://github.com/blockpill/nextjs-starter.git"
ENV INSTALL_COMMAND="yarn install --frozen-lockfile"
ENV BUILD_COMMAND="yarn build"
ENV START_COMMAND="yarn start"
ENV ADMIN_USERNAME="admin"
ENV ADMIN_PASSWORD="password"
ENV WEBHOOK_SECRET="webhooksecret"

WORKDIR /
COPY /build-script.sh ./
COPY /deploy.sh ./
COPY /hook.json ./

RUN chmod +x ./build-script.sh
RUN chmod +x ./deploy.sh

# App Port
EXPOSE 3000

# Logs Server Port
EXPOSE 8080

# Webhook Server Port
EXPOSE 9000

# Create logs directory
RUN mkdir /var/tmp/logs
RUN touch /var/tmp/logs/log.txt

# ENTRYPOINT ./build-script.sh "$GITHUB_REPO" "$INSTALL_COMMAND" "$BUILD_COMMAND" "$START_COMMAND" "$ENABLE_LOG" "$ADMIN_USERNAME" "$ADMIN_PASSWORD"
ENTRYPOINT ./build-script.sh