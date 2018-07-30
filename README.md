# docker IBM images

## IBM Integration Bus

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

