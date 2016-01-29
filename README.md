# xmllint in a container

This image is based on the minimalist Alpine Linux latest
distribution, to which have been added libxml2 utilities.


Install Docker
--------------

See
[the corresponding documentation.](https://docs.docker.com/linux/step_one/)


Install requirements
--------------------

First, `git clone` this repository and `cd` into it. If you type:

    $ ls

you should see a `Dockerfile`.

Then, create a directory named *context*:

    $ mkdir context

And a subdirectory *context/x86_64/* where the packages are to be
found:

    $ mkdir context/x86_64

You can change the names, but you will have to update the corresponding
*COPY* line of the Dockerfile.

You finally need to download the relevant packages from
[the latest Alpine packages repository](http://dl-2.alpinelinux.org/alpine/latest-stable/main/x86_64/):

* [APKINDEX.tar.gz](http://dl-2.alpinelinux.org/alpine/latest-stable/main/x86_64/APKINDEX.tar.gz)

* libxml2-*.apk

* libxml2-utils-*.apk

where * is the current version of the library. Put the downloaded
packages in *context/x86_64/*



Build the image
---------------

You can give a name to the image by adding `--tag user/name`
option. In all the following, replace ${image} by the image id or tag
that have just been generated.

    # docker build ./

where ./ is the path to the Dockerfile.

Note that all docker commands require root privileges (or, at least,
to be member of the `docker` group, that is roughly equivalent of
being root).



Execute a container
-------------------

The files that you want to validate must be in the same directory,
that will be mounted as a docker volume in the container on /xml. If
you want to change the mount point in the container, you should also
alter the *WORKDIR* line in the Dockerfile or give the absolute paths
of all your files.

    # docker run -v /absolute/host/path/to/xml/folder/:/xml/:ro ${image} xmllint file1.xml

The validator is `xmllint`. Note that for security reason, the volume
should be mounted read-only, so that noone could alter it from the
container. The command calls `xmllint` on `file1.xml` located in
`/absolute/host/path/to/xml/folder/`.

Add the `--rm` option to the docker command to remove the container
after usage.

Note:

Inside the container, the xmllint program is executed with root
privileges. If you think the container is altered, just remove it and
generate a new one.



Use the helper script
---------------------

I wrote `container-xmllint.sh` script to help writing the validation
command. Any argument of this script will be passed to xmllint.

To use this script, two environment variables must be set (and exported
to the script's process):

* `CONTAINER_XMLLINT_IMAGE` is the name or id of the image that
  contains libxml2 tools

* `CONTAINER_XMLLINT_PATH` is the **absolute** path to the folder
  containing the files to validate.

Be careful of xmllint's messages: a file not found can mean an
incorrect `CONTAINER_XMLLINT_PATH`. Run a `sh` command to debug.




Copyright and license
---------------------

© 2016 Alban Kraus.  
Permission is given to use this work under the same license as the
Alpine Linux base image. This work is distributed without any
warranties.
