
# Builder
FROM golang:1.18-alpine as builder
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN CGO_ENABLED=0 go build -o frontEnd ./cmd/web
RUN chmod +x /app/frontEnd

# Runner
FROM alpine:latest
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/cmd/web/templates /app/cmd/web/templates
COPY --from=builder /app/frontEnd /app/frontEnd
CMD ["/app/frontEnd"]
