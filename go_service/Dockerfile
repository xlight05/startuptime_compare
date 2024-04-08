# The build stage
FROM golang:1.19.0-alpine  as builder
WORKDIR /app

# Create a new user with UID 10014
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-api /app/api/main.go

# The run stage
FROM scratch
WORKDIR /app
COPY --from=builder /app/go-api .

USER 10014
EXPOSE 8080

CMD ["./go-api"]
