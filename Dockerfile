FROM node:9

ADD app ./app/
CMD node ./app/example.js

EXPOSE 3000
