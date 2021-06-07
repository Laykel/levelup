# Build environment
FROM node:current-alpine as build

WORKDIR /src
COPY . .

RUN npm install
RUN npm test # coverage and stuff?

RUN npm run build

# Production environment
FROM nginx:stable-alpine

COPY --from=build /src/build /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
