FROM node:10.22.1
WORKDIR /usr/src/app

COPY wellteq-api.zip /usr/src/tmp/

RUN apt-get install -y unzip
RUN unzip /usr/src/tmp/wellteq-api.zip -d /usr/src/app/
RUN rm /usr/src/tmp/wellteq-api.zip

WORKDIR wellteq-api
RUN npm install

WORKDIR cloud_code
RUN npm install
RUN ./node_modules/.bin/gulp copy-theme --theme DBS
RUN ./node_modules/.bin/gulp switch-env --env DBS

WORKDIR public/client
RUN yarn

WORKDIR /usr/src/app/wellteq-api/cloud_code/cloud
RUN npm install

WORKDIR /usr/src/app/wellteq-api/cloud_code
CMD ["node", "index.js"]
