FROM golang:1.18

RUN go env -w GOBIN=/go/bin
ENV PATH="/usr/src/sh:${PATH}"

WORKDIR /usr/src
RUN git clone --depth 1 https://github.com/garbagemza/argos-test-finder.git
RUN git clone --depth 1 https://github.com/garbagemza/argos-test-builder.git

WORKDIR /usr/src/argos-test-finder
RUN go build
RUN go install

WORKDIR /usr/src/argos-test-builder
RUN go build
RUN go install

WORKDIR /usr/src/sh

COPY script.sh argos-test.sh
RUN chmod +x argos-test.sh
