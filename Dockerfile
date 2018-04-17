FROM node:9-alpine

ADD app ./app/
CMD node ./app/example.js

EXPOSE 3000
