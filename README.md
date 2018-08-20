# P030-MLDockerEnv
A Docker Machine Learning Python enviroment.

## Module list
Module | Version
--- | ---
python | 3.6 (apt)
torch | latest (git)
chainer | latest (pip)
cntk | latest (pip)
jupyter | latest (pip)
jupyterlab | latest (pip)
mxnet | latest (pip)
pytorch | 0.4.0 (pip)
tensorflow | latest (pip)
theano | 1.0.1 (git)
keras | latest (pip)
lasagne | latest (git)
opencv | 3.4.1 (git)
sonnet | latest (pip)
caffe | latest (git)
caffe2 | latest (git)

## Setup
Pull image from dockerhub. Either the CPU only version or the GPU version.
The GPU version requires a CUDA compatible Nvidia GPU and is *only supported on
Linux computers*. The CPU version can be runned on everything that has Docker
installed (Linux, macOS and Windows).
```bash
docker pull 181192/ml:cpu

# or for the GPU version
docker pull 181192/ml:gpu
```

## How to run
First you will need to have [Docker](https://docs.docker.com/install/) installed
on you computer.

There is three options for running the docker container.

### First option - `docker run`
The first one is to run it by the `docker run` command. This is the best way if
you want to run something specific other than the Jupyter Notebook or Jupyter Lab.
This docker image does not start any services for you, but will have everything
available if you want to.

For example if you want to run `bash` in a interactive shell you can run:
```bash
docker run --rm -it 181192/ml:cpu
```
Where the `--rm` specify to delete the image after you stop the container. This
is very useful so you don't end up with a lot of stopped, but not removed containers.

To list all you container you can run `docker container ls -a` and to remove all
stopped container you can run `docker rm $(docker ps -a -q)`.

The `-it` specify two things first the `-i` flag is specifying to be interactive,
and will keep the STDIN open in the terminal even if it's not attached. The `-t`
will allocate a pseudo-TTY for us to have a terminal into to the container.

To stop the container and exit the containers bash press `CTRL+C`.

### Second option - `docker-compose up`
The second option is to use [Docker Compose](https://docs.docker.com/compose/install/). Docker Compose uses a simple editable
YAML-file called `docker-compose.yml`. In this repository I have created a simple
docker-compose file that will create a `ml:cpu` container and then start Jupyter
Lab that would be available on your own computer at `localhost:8888`.
To start Docker Compose run `docker-compose up` to start and to stop the services
press `CTRL+C`. This will stop the containers, but not remove them. To fully remove
use the `docker-compose down` command.

### Third option - `./start.sh`
The third option is to run the `start.sh` script that I have provided. The script
will run either with two defined parameters or use some default.
```bash
#!/bin/bash

jupyter="$(jupyter lab --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root')"
volume=${1:-"$(pwd)/notebook"}
start=${2:-$jupyer}

docker run --rm -it -p 8888:8888 --ipc=host -v $volume:/root 181192/ml:cpu $start
```
If the parameters is not set the mounted volume will be a folder named `notebook`
located in the folder you start the script from. And then it would lauch Jupyter
Lab. If you want to provide a custom path to save your containers notebooks on
the host machine you can run for example:
```bash
./start.sh ../../my-other-notebooks
```
To run it with default values just run:
```bash
./start.sh
```

### Running Jupyter Notebook or Jupyter Lab
You now have a lot of options to do with our amazing container that contains
everything you need to be a real *scientific machine learning programmer*, etc.
to start a Jupyter Notebook or a Jupyter Lab you can run the following command:
Replace notebook with `lab` to start jupyterlab.

```bash
docker run --rm -it -p 8888:8888 --ipc=host 181192/ml:cpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'
```

Or if you want to share a volume so your work can be saved.

```bash
docker run --rm -it -p 8888:8888 --ipc=host -v /your-dir:/root/your-dir 181192/ml:cpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'
```

For running GPU version you will need `nvidia-docker` installed, installation guide [here](https://github.com/NVIDIA/nvidia-docker):
```bash
nvidia-docker run --rm -it -p 8888:8888 --ipc=host -v /your-dir:/root/your-dir 181192/ml:gpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'
```
