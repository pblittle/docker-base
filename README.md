This is a base image that is used for system updates and installation of standard server packages. The image is based on the official Ubuntu 12.04 image.

In addition to system updates, this image will also install and run an SSHd server supervised by runit.

To use this base image in your project, simply add the following to your `Dockerfile`:

    FROM pblittle:base

To build the image locally using Vagrant, perform the following steps from the project root:

    vagrant up
    vagrant ssh
    cd /vagrant
    make build

From there, to create a running container from the newly created image:

    make run

Alternatively, to create an image running a shell session:

    make shell

To ssh into the running container from the host server

    chmod 0600 ./insecure_key
    IP=$(docker inspect --format='{{.NetworkSettings.IPAddress}}' base)
    ssh -i ./insecure_key root@$IP
