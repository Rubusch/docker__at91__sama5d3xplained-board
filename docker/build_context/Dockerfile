################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to
## use --build-arg USER=$USER
ARG USER="${USER}"
ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20211028"


################################################################################
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS at91
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive



################################################################################
## set up apt fully functional
USER root

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
## command mode
USER ${USER}
WORKDIR /home/$USER

## setup default script
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
