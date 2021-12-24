################ Build & Dev ################
# Build stage will be used:
# - for building the application for production
# - as target for development (see devspace.yaml)

ARG  TAG=1.16-alpine
FROM golang:${TAG} as build

# Create project directory (workdir)
WORKDIR /app

# Add source code files to WORKDIR
ADD . .

# Build application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

CMD ["/usr/local/go/bin/go", "run", "/app/main.go"]


################ Production ################
# Creates a minimal image for production using distroless base image
# More info here: https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/base-debian11 as production

WORKDIR /app

# Copy application binary from build/dev stage to the distroless container
COPY --from=build /app/main .

# Application port (optional)
EXPOSE 8080

# Container start command for production
CMD ["/app/main"]
