# Pulling base image
FROM debian:buster
MAINTAINER Rashad Mammadli <mammadli.reshad@gmail.com>

RUN echo "++++ Installing required tools ++++"  && \
    apt-get update -y                         && \
    DEBIAN_FRONTEND=noninteractive               \
    apt-get install -y apt-transport-https gnupg2 \
                            sudo python python-yaml openssh-client \
                            curl gcc python-pip python-dev libffi-dev libssl-dev openssh-client && \
    echo "++++ Adding additional tools ++++"  && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl  && \
    chmod +x ./kubectl  && \
    mv ./kubectl /usr/local/bin/kubectl && \
    echo "++++ Installing Ansible ++++"   && \
    pip install ansible                 && \
    echo "++++ Installing required pip packages ++++"   && \
    pip install --upgrade pycrypto cffi pywinrm    && \
    echo "++++ Removing unused resources ++++"                  && \
    apt-get -y --purge remove python-cffi          && \
    apt-get -f -y --auto-remove remove \
                 gcc python-dev libffi-dev libssl-dev  && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           
