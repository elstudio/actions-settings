FROM node:10-alpine

LABEL version="1.0.0"
LABEL repository="https://github.com/elstudio/actions-settings"
LABEL homepage="https://github.com/elstudio/actions-settings"
LABEL maintainer="el-studio Actions <servers+actions@el-studio.com>"

LABEL com.github.actions.name="GitHub Action to run Probot/settings"
LABEL com.github.actions.description="Sets and enforces repository defaults."
LABEL com.github.actions.icon="settings"
LABEL com.github.actions.color="purple"

ENV PATH=$PATH:/app/node_modules/.bin
WORKDIR /app
COPY . .
# Since probot/settings isn't in NPM we'll need to install git
RUN apk add git
RUN npm install --production

ENTRYPOINT ["probot", "receive"]
CMD ["-e $GITHUB_EVENT_NAME", "-p $GITHUB_EVENT_PATH", "/app/node_modules/probot-settings/index.js"]
