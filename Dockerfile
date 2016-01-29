# © Alban Kraus 2016
# École nationale des sciences géographiques
# 6-8 avenue Blaise Pascal – Cité Descartes – Champs-sur-Marne
# 77455 MARNE-LA-VALLÉE CEDEX 2
# FRANCE

# Base distribution
FROM alpine

# Not maintained anymore

# Description
LABEL description="Latest Alpine base image with libxml2 utilities."

# Copy the relevant packages into the container
COPY context/x86_64/APKINDEX.tar.gz \
     context/x86_64/libxml2-*.apk \
     /apk/x86_64/

# Change the repository
RUN echo "/apk" > /etc/apk/repositories

# Install packages
RUN ["/sbin/apk", "update"]
RUN ["/sbin/apk", "add", "libxml2", "libxml2-utils"]

# Default working directory
WORKDIR /xml

# Default command
CMD ["/usr/bin/xmllint"]