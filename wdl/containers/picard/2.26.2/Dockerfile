# build image
FROM debian:buster-slim AS builder

RUN apt-get update \
    && apt-get -y install wget

RUN wget https://github.com/broadinstitute/picard/releases/download/2.26.2/picard.jar

# final image
FROM openjdk:18-slim-buster

COPY --from=builder /picard.jar /bin/
