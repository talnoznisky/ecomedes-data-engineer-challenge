#!/bin/bash

port=${1:-9999}
password=${2:-foo}

docker run \
    --rm \
    -p $port:5432 \
    -e POSTGRES_PASSWORD=$password \
    -d \
    brianrowe/data-engineer-challenge
