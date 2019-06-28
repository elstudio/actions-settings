FROM node:10-alpine

LABEL version="1.0.0"
LABEL repository="https://github.com/elstudio/actions-settings"
LABEL homepage="https://github.com/elstudio/actions-settings"
LABEL maintainer="el-studio Actions <servers+actions@el-studio.com>"

LABEL com.github.actions.name="GitHub Action to run Probot/settings"
LABEL com.github.actions.description="Sets and enforces repository defaults."
LABEL com.github.actions.icon="truck"
LABEL com.github.actions.color="purple"

ENV PATH=$PATH:/app/node_modules/.bin
WORKDIR /app
COPY . .
# Alpine doesn't include git by default, so let's install it
# (Since probot/settings isn't in NPM we'll need git)
RUN apk add git
RUN npm install --production
RUN ls /app

ENTRYPOINT ["probot", "receive"]
CMD ["/app/index.js"]

# ENTRYPOINT /app/entrypoint.sh
