FROM node:14-buster-slim AS base
WORKDIR /usr/src/app

COPY . . 
RUN yarn
RUN yarn test
RUN yarn build 
RUN yarn export


FROM raudhahdev/adab4fe-apache:latest AS server
WORKDIR /var/www/html
COPY --chown=www-data:root --from=base /usr/src/app/out .
EXPOSE 80
CMD ["apache2", "-D", "FOREGROUND"]
