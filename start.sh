#!/bin/bash

jupyter="$(jupyter lab --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root')"
volume=${1:-${pwd}/notebook}
start=${2:-$jupyer}

docker run --rm -it -p 8888:8888 --ipc=host -v $volume:/root 181192/ml:cpu $start
