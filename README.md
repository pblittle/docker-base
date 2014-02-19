This is a base image that is used for system updates and installation of standard server packages. The image is based on the Phusion Baseimage.

    https://github.com/phusion/baseimage-docker

To use this base image in your project, simply add the following to your `Dockerfile`:

    FROM pblittle/base

To build the image locally using Vagrant, perform the following steps from the project root:

    vagrant up
    vagrant ssh
    cd /vagrant
    make build

From there, to create a running container from the newly created image:

    make run

Alternatively, to create an image running a shell session:

    make shell
