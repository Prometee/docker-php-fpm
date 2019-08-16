#!/usr/bin/env bash

image="fluxaudio/php-fpm:$VERSION"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker tag $image $image
docker push $image