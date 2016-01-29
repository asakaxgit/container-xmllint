#!/bin/sh

if [ -z $CONTAINER_XMLLINT_IMAGE ]; then
    echo "Please set and export environment variable CONTAINER_XMLLINT_IMAGE to the name or id of the base image."
    exit 1
fi

if [ -z $CONTAINER_XMLLINT_PATH ]; then
    echo "Please set and export environment variable CONTAINER_XMLLINT_PATH to the absolute directory containing your XML files."
    exit 1
fi

docker run --rm -v ${CONTAINER_XMLLINT_PATH}:/xml:ro ${CONTAINER_XMLLINT_IMAGE} xmllint $@
