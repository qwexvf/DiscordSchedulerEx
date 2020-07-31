FROM elixir:alpine

RUN export TZ=Asia/Tokyo

RUN \
      mkdir -p /opt/app && \
      chmod -R 777 /opt/app && \
      apk update && \
      apk --no-cache --update add \
      git make g++ wget curl inotify-tools imagemagick nodejs yarn tzdata && \
      cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
      echo "Asia/Tokyo" > /etc/timezone && \
      update-ca-certificates --fresh && \
      rm -rf /var/cache/apk/*

ENV MIX_HOME=/opt/mix \
    HEX_HOME=/opt/hex \
    HOME=/opt/app

# Install Phoenix packages
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new 1.4.12 --force

WORKDIR /opt/app
ADD . /opt/app

EXPOSE 4000
EXPOSE 3000
