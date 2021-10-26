[![CircleCI](https://circleci.com/gh/Rubusch/docker__at91__sama5d3xplained-board.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__at91__sama5d3xplained-board)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

# Docker Container for my SAMA5D3Xplained Board (AT91)


## Resources

https://www.linux4sam.org/bin/view/Linux4SAM/Sama5d3XplainedMainPage  
https://www.linux4sam.org/bin/view/Linux4SAM/BuildRootBuild  


## Tools Needed

```
$ sudo apt-get install -y libffi-dev libssl-dev
$ sudo apt-get install -y python3-dev
$ sudo apt-get install -y python3 python3-pip
$ pip3 install docker-compose
```
Make sure, ``~/.local`` is within ``$PATH`` or re-link e.g. it to ``/usr/local``.


## Build

Preparation  

```
$ cd ./docker
$ echo "UID=$(id -u)" > .env
$ echo "GID=$(id -g)" >> .env
```

Building  

```
$ docker-compose up
```


## Usage

```
$ cd ./docker__buildroot
$ docker-compose -f ./docker-compose.yml run --rm at91_buildroot /bin/bash
docker $> build.sh
```

TODO: explain SAM-BA tool  
TODO: explain network boot  
