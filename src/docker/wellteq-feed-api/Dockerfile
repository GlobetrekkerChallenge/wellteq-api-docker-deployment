FROM node:10.22.1
WORKDIR /usr/src/app

COPY feed-api.zip /usr/src/tmp/

RUN apt-get install -y unzip
RUN unzip /usr/src/tmp/feed-api.zip -d /usr/src/app/
RUN rm /usr/src/tmp/feed-api.zip

WORKDIR feed-api
RUN npm install

WORKDIR /usr/src/app/feed-api/src
CMD ["node", "server.js"]
