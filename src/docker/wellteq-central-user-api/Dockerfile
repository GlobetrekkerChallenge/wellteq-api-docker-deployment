FROM node:10.22.1
WORKDIR /usr/src/app

COPY central-user-api.zip /usr/src/tmp/

RUN apt-get install -y unzip
RUN unzip /usr/src/tmp/central-user-api.zip -d /usr/src/app/
RUN rm /usr/src/tmp/central-user-api.zip

WORKDIR central-user-api
RUN npm install
RUN npm install -g knex

WORKDIR /usr/src/app/central-user-api
CMD ["node", "server.js"]
