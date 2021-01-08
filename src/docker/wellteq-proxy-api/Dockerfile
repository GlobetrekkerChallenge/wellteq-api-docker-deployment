FROM node:10.22.1
WORKDIR /usr/src/app

COPY api-proxy.zip /usr/src/tmp/

RUN apt-get install -y unzip
RUN unzip /usr/src/tmp/api-proxy.zip -d /usr/src/app/
RUN rm /usr/src/tmp/api-proxy.zip

WORKDIR api-proxy
RUN npm install

WORKDIR /usr/src/app/api-proxy/src
CMD ["node", "proxy.js"]
