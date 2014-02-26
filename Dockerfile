FROM phusion/baseimage:0.9.8
MAINTAINER P. Barrett Little <barrett@barrettlittle.com>

# This base image uses the phusion/baseimage base image.
# https://github.com/phusion/baseimage-docker

# Set the root user's HOME env var
ENV HOME /root

# Create SSH keys if they don't exist
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Run the baseimage-docker init process
CMD ["/sbin/my_init"]

# Remove unused package files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
