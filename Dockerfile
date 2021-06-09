# npm install, lint and run all tests
# docker build -t <tag> --target test .
FROM node:current-alpine as test

WORKDIR /src
COPY . .

RUN npm ci
RUN npm run lint
# In a perfect world:
# RUN npm run test


# Build dev image
# docker build -t <tag_name> --target dev .
FROM test as dev

EXPOSE 8080
CMD ["npm", "start"]


# Build prod-ready sources
FROM test as build

RUN npm run build


# Build production image
# docker build -t <tag> .
FROM nginx:stable-alpine

COPY --from=build /src/build /usr/share/nginx/html
# COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
