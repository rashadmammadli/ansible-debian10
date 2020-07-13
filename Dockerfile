# Pulling base image
FROM debian:buster
MAINTAINER Rashad Mammadli <mammadli.reshad@gmail.com>

RUN echo "++++ Adding reqiured repos ++++"  && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -  && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list  && \
    
    echo "++++ Installing required tools ++++"  && \
    apt-get update -y                         && \
    DEBIAN_FRONTEND=noninteractive               \
    sudo apt-get install -y apt-transport-https gnupg2 kubectl\
                            sudo python python-yaml openssh-client \
                            curl gcc python-pip python-dev libffi-dev libssl-dev openssh-client && \
    apt-get -y --purge remove python-cffi          && \
    echo "++++ Installing Ansible ++++"   && \
    pip install ansible                 && \
    echo "++++ Installing required pip packages ++++"   && \
    pip install --upgrade pycrypto cffi pywinrm    && \
    echo "++++ Removing unused resources ++++"                  && \
    apt-get -f -y --auto-remove remove \
                 gcc python-dev libffi-dev libssl-dev  && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           
