# -*- mode: Dockerfile -*-

FROM ghcr.io/feelpp/feelpp:jammy

RUN mkdir /work
COPY . /work
WORKDIR /work
RUN pip3 install -r requirements.txt


