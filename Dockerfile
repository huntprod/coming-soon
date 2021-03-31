FROM golang:1.16-alpine AS build
WORKDIR /src
COPY main.go go.mod ./
RUN go build



FROM alpine:3

ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="James Hunt <images@huntprod.com>" \
      summary="A Coming Soon! Application" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/huntprod/coming-soon.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"

RUN apk add gettext

WORKDIR /app
COPY . .
COPY --from=build /src/coming-soon /app

ENTRYPOINT ["/app/entrypoint.sh"]
