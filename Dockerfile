# © Alban Kraus 2016
# École nationale des sciences géographiques
# 6-8 avenue Blaise Pascal – Cité Descartes – Champs-sur-Marne
# 77455 MARNE-LA-VALLÉE CEDEX 2
# FRANCE

# Base distribution
FROM alpine:latest

ARG REPO_BASE=http://nl.alpinelinux.org/alpine/v3.7/main/x86_64/

# Not maintained anymore

# Description
LABEL description="Latest Alpine base image with libxml2 utilities."

# Add libxml2 using apk.
RUN apk add libxml2-utils

# Default working directory
WORKDIR /xml

# Default command
CMD ["/usr/bin/xmllint", "--valid" , "/xml/target.xml"]
