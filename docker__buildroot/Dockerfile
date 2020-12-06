FROM ubuntu:20.04
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER="${USER}"

ARG BRANCH="linux4sam_6.2"


################################################################################
## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge
RUN apt-get install -y  \
        apt-utils

RUN apt-get install -y  \
        build-essential \
        libncurses5-dev \
        zlib1g-dev \
        gawk \
        wget \
        git-core \
        make \
        gcc \
        g++ \
        bison \
        flex \
        binutils \
        unzip \
        python \
        bzip2 \
        libssl-dev \
        locales \
        bc \
        cpio \
        mtools \
        rsync

## (opt) java related packages
#RUN apt-get install -y openjdk-8-jdk

## (opt) documentation related packages
#RUN apt-get install -y asciidoc w3m python-argparse dblatex

## (opt) graph generation
#RUN apt-get install -y graphviz python-matplotlib

## (opt) tools for debugging and working, e.g. X11-apps for testing the xserver via xclock
RUN apt-get install -y   \
        cvs \
        mercurial \
        subversion \
        vim \
        screen \
        minicom \
        x11-apps \
        sudo


################################################################################
## locale settings
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


################################################################################
## setup user and run stuff under user
RUN useradd "$USER" -m --password "$USER"
RUN usermod -a -G sudo "$USER"
RUN sed -i '/%sudo/s/.*/%sudo   ALL=NOPASSWD: ALL/' /etc/sudoers


################################################################################
## sources
USER $USER

## use official sources
RUN cd /home/$USER && git clone --branch ${BRANCH} -j4 https://github.com/linux4sam/buildroot-at91.git
#RUN cd /home/$USER && git clone -j4 https://github.com/linux4sam/buildroot-at91.git
#RUN cd /home/$USER/buildroot-at91/ && git checkout linux4sam_6.2 -b buildroot-at91-linux4sam_6.2

## use official sources
RUN cd /home/$USER && git clone --branch ${BRANCH} https://github.com/linux4sam/buildroot-external-microchip.git
#RUN cd /home/$USER && git clone https://github.com/linux4sam/buildroot-external-microchip.git
#RUN cd /home/$USER/buildroot-external-microchip/ && git checkout linux4sam_6.2 -b buildroot-external-microchip-linux4sam_6.2


################################################################################
## command mode
USER root

COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
