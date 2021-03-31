FROM golang:1.16-alpine AS build
WORKDIR /src
COPY main.go go.mod ./
RUN go build

FROM alpine:3
WORKDIR /app
RUN apk add gettext
COPY . .
COPY --from=build /src/coming-soon /app
ENTRYPOINT ["/app/entrypoint.sh"]
