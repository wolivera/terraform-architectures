########################
# Build Base
########################
FROM node:16-alpine AS base
WORKDIR /app
COPY ./package.json ./yarn.lock /app/

RUN yarn
COPY . /app/

########################
# Run
########################
FROM base AS app

EXPOSE 3001
CMD ["yarn", "start"]
