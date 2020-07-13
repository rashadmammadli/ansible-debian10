# Pulling base image
FROM debian:buster
MAINTAINER Rashad Mammadli <mammadli.reshad@gmail.com>

RUN echo "===> Installing required tools "  && \
    apt-get update -y                         && \
    DEBIAN_FRONTEND=noninteractive               \
    apt-get install -y sudo python python-yaml openssh-client \
                        curl gcc python-pip python-dev libffi-dev libssl-dev openssh-client && \
    apt-get -y --purge remove python-cffi          && \
    pip install --upgrade pycrypto cffi pywinrm    && \
    echo "===> Installing Ansible "   && \
    pip install ansible                 && \
    echo "===> Removing unused resources "                  && \
    apt-get -f -y --auto-remove remove \
                 gcc python-pip python-dev libffi-dev libssl-dev  && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           
