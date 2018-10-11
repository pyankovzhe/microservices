# 1. Сборка
FROM ruby:2.3-alpine3.7 AS builder
RUN apk update && apk --update add --virtual .build-dependencies\
  build-base \
  gcc \
  automake \
  ruby-dev \
  libc-dev

WORKDIR /app

# 2. Разработка
FROM builder AS development
COPY Gemfile* /app/
RUN bundle install
COPY . /app

# 3. Релиз
FROM development AS release
RUN apk del .build-dependencies

ENV POST_SERVICE_HOST=post
ENV POST_SERVICE_PORT=5000
ENV COMMENT_SERVICE_HOST=comment
ENV COMMENT_SERVICE_PORT=9292

CMD ["puma"]
