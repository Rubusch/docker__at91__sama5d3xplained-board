[![CircleCI](https://circleci.com/gh/Rubusch/docker__at91__sama5d3xplained-board.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__at91__sama5d3xplained-board)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)

# Docker Container for my SAMA5D3Xplained Board (AT91)


## Resources

https://www.linux4sam.org/bin/view/Linux4SAM/Sama5d3XplainedMainPage  
https://www.linux4sam.org/bin/view/Linux4SAM/BuildRootBuild  


## Tools Needed

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-comp\
\
ose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod a+x /usr/local/bin/docker-compose
```

NB: Where 1.28.6 is the latest version (currently not supported by devian/ubuntu packa\
ge management)


## Build

```
$ cd ./docker__buildroot/
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
