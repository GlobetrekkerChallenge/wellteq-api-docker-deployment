FROM node:10.22.1
WORKDIR /usr/src/app

COPY survey-api.zip /usr/src/tmp/

RUN apt-get install -y unzip
RUN unzip /usr/src/tmp/survey-api.zip -d /usr/src/app/
RUN rm /usr/src/tmp/survey-api.zip

WORKDIR survey-api
RUN npm install
RUN npm install -g knex

WORKDIR /usr/src/app/survey-api
CMD ["node", "src/server.js"]
