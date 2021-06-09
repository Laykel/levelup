# npm install, lint and run all tests
# docker build -t <tag> --target test .
FROM node:current-alpine as test

WORKDIR /src
COPY . .

RUN npm ci
RUN npm run lint
# In a perfect world:
# RUN npm run test

RUN npm run build


# Build nginx web server
FROM nginx:stable-alpine as server

COPY --from=build /src/build /usr/share/nginx/html
# COPY docker/nginx.conf /etc/nginx/conf.d/default.conf


# Build dev image
# docker build -t <tag_name> --target dev .
FROM server as dev

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]


# Build production image
# docker build -t <tag> .
FROM server

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
