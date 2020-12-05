[![CircleCI](https://circleci.com/gh/Rubusch/docker__at91__sama5d3xplained-board.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__at91__sama5d3xplained-board)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

# Docker Container for my SAMA5D3Xplained Board (AT91)


## Resources

https://www.linux4sam.org/bin/view/Linux4SAM/Sama5d3XplainedMainPage  
https://www.linux4sam.org/bin/view/Linux4SAM/BuildRootBuild  


## Build

```
$ cd ./docker__buildroot/
$ time docker build --build-arg USER=$USER -t rubuschl/at91-sama5d3-buildroot:$(date +%Y%m%d%H%M%S) .
```


## Usage

```
$ docker images
    REPOSITORY                      TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/at91-sama5d3-buildroot 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ...

$ docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/dl:/home/$USER/buildroot/dl -v $PWD/output:/home/$USER/buildroot/output rubuschl/at91-sama5d3-buildroot:20191104161353 /bin/bash

docker $> build.sh
```

TODO: explain SAM-BA tool  
TODO: explain network boot  
