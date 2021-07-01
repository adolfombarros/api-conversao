FROM node:alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

RUN npm install

RUN npm install -g npm to update

COPY . .

COPY --chown=node:node . .

USER node

EXPOSE 3001

#DEFAULT
#HEALTHCHECK CMD curl --fail http://localhost:3001 || exit 1

#CUSTOM
HEALTHCHECK --interval=12s --timeout=12s --start-period=30s CMD node healthcheck.js

CMD [ "node", "app.js" ]