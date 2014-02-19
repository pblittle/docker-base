FROM phusion/baseimage:0.9.6
MAINTAINER P. Barrett Little <barrett@barrettlittle.com>

# This base image is built on the Phushion Baseimage.
# https://github.com/phusion/baseimage-docker

# Set the root user's HOME env var
ENV HOME /root

# Create SSH keys if they don't exist
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Run the Phusion Baseimage init process
CMD ["/sbin/my_init"]

# Remove unused package files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
