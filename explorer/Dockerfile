FROM node:14.19-alpine3.14 as builder

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/ping-pub/explorer.git \
    && cd explorer && yarn && yarn build

FROM nginx:alpine

COPY ping.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/explorer/dist /usr/share/nginx/html