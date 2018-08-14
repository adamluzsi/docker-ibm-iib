# IBM Integration Bus

in the iib subfolder, you find the Dockerfile that allows you to install any version of IIB.
All you have to do is pass the version number as a build arg.

```sh
docker build -t ibm/iib --build-arg PRODUCT_VERSION="10.0.0.8" ./iib
```

or alternatively you can use the env file and the build script.

```sh
cd iib
source .envrc
./bin/build
```

## IIB toolkit

if you are on linux, you can execute the following command to start IIB toolkit GUI

```sh
docker run --env DISPLAY --volume $HOME/.Xauthority:/home/iibuser/.Xauthority ibm/iib toolkit
```

## docker-compose

> .envrc

```sh
#!/usr/bin/env bash

export localXauthPath="$XAUTHORITY"
if [[ -z "$localXauthPath" ]]; then
	export localXauthPath="$HOME/.Xauthority"
fi

```

> docker-compose.yaml

```yaml
---
services:
  iib:
    build:
      context: https://github.com/adamluzsi/docker-ibm-iib.git
      args:
        VERSION: 10.0.0.8
    network_mode: host
    environment:
      - DISPLAY
    volumes:
      - "${localXauthPath}:/home/iibuser/.Xauthority:ro"
    ports:
      - 4414:4414
      - 7800:7800

```

## Caveat

By using this Dockerbuild you accept the terms of the IBM Integration Bus for Developers license.
i hold no responsibility for any consequences of missuse of this image other than development.
