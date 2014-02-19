FROM ubuntu:12.04
MAINTAINER P. Barrett Little <barrett@barrettlittle.com>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

# Update OS apt sources
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" \
    > /etc/apt/sources.list

# Perform package list updates
RUN apt-get update

# Perform system package updates
RUN apt-get -yq upgrade

# Install essential packages
RUN apt-get install -yq \
    build-essential \
    ca-certificates

# Install runit
RUN apt-get install -y runit

# Install OpenSSH server
RUN apt-get install -yq openssh-server

# Create privledge separation directory
RUN mkdir -p /var/run/sshd

# Create runit sshd service
RUN mkdir -p /etc/service/sshd
RUN /bin/echo -e '#!/bin/bash' > /etc/service/sshd/run
RUN /bin/echo -e 'set -e' >> /etc/service/sshd/run
RUN /bin/echo -e 'exec /usr/sbin/sshd -D' >> /etc/service/sshd/run

# Make sshd run script executable
RUN chown root:root /etc/service/sshd/run
RUN chmod 0755 /etc/service/sshd/run

# Install SSH keys for root user
RUN mkdir -p /root/.ssh
RUN chmod 0700 /root/.ssh
RUN chown root:root /root/.ssh

# Copy build files to container root
RUN mkdir /build
ADD . /build

# Configure key-only authentication and disable PAM authentication
RUN sed -i \
    -e 's/^#PasswordAuthentication yes/PasswordAuthentication no/' \
    -e 's/^UsePAM yes/UsePAM no/' \
    /etc/ssh/sshd_config

# Do not use this INSECURE key in production!
RUN cat /build/insecure_key.pub >> \
    /root/.ssh/authorized_keys

# Change permissions for passwordless SSH
RUN chmod 0600 /root/.ssh/authorized_keys

# Open SSH port
EXPOSE 22

# Start runit services
CMD ["/usr/sbin/runsvdir-start"]
