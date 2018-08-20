# P030-MLDockerEnv
A Docker Machine Learning Python enviroment.

### Module list
```
python        3.6    (apt)
torch         latest (git)
chainer       latest (pip)
cntk          latest (pip)
jupyter       latest (pip)
jupyterlab    latest (pip)
mxnet         latest (pip)
pytorch       0.4.0  (pip)
tensorflow    latest (pip)
theano        1.0.1  (git)
keras         latest (pip)
lasagne       latest (git)
opencv        3.4.1  (git)
sonnet        latest (pip)
caffe         latest (git)
caffe2        latest (git)
```

### Setup
Pull image from dockerhub. Either the CPU only version or the GPU version. The GPU version requires a CUDA compatible Nvidia GPU.
```
docker pull 181192/ml:cpu

# or for the GPU version
docker pull 181192/ml:gpu
```

You now have a lot of options to do, etc. to start a Jupyter Notebook or a Jupyter Lab you can run the following command:
Replace notebook with `lab` to start jupyterlab.

```
docker run --rm -it -p 8888:8888 --ipc=host 181192/ml:cpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'
```

Or if you want to share a volume so your work can be saved.

```
docker run --rm -it -p 8888:8888 --ipc=host -v /your-dir:/root/your-dir 181192/ml:cpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'
```

For running GPU version you will need `nvidia-docker` installed:
```
nvidia-docker run --rm -it -p 8888:8888 --ipc=host -v /your-dir:/root/your-dir 181192/ml:gpu jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/root'
```
