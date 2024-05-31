FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

ENV TF_PYTHON_VERSION=$python_version
ENV TF_CUDNN_VERSION='8'
ENV TF_CUDA_VERSION='12.5'
ENV TF_NEED_TENSORRT=1
ENV PYTHON_BIN_PATH=/usr/bin/python3
ENV PYTHON_LIB_PATH=/usr/lib/python3/dist-packages
ENV TF_NEED_ROCM=0
ENV TF_NEED_CUDA=1
ENV TF_CUDA_COMPUTE_CAPABILITIES='3.5,7.0,8.9'
ENV TF_CUDA_CLANG=1
ENV CLANG_CUDA_COMPILER_PATH=/usr/bin/clang
ENV CC_OPT_FLAGS="-Wno-sign-compare"
ENV TF_SET_ANDROID_WORKSPACE=0

COPY ./build_tensor/tensorflow-2.16.1-cp312-cp312-linux_x86_64.whl /tmp/
COPY ./start_notebook.sh /

RUN apt update && apt upgrade -y && \
    apt install \
        vim \
        wget \
        python3 \
        python3-pip \
        libxml2-utils \
        libpq-dev \
        curl \
        make \
        ant \
        xsltproc \
        apt-transport-https \
        ca-certificates \
        curl \
        git -y && \
        ln -s /usr/bin/python3 /usr/bin/python && \
        cd /tmp && \
        wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
        dpkg -i cuda-keyring_1.1-1_all.deb && \
        apt-get update && \
        apt-get -y install cuda-toolkit-12-5 && \
        wget https://developer.download.nvidia.com/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-8.9.7.29_cuda12-archive.tar.xz && \
        tar -xvf cudnn-linux-x86_64-8.9.7.29_cuda12-archive.tar.xz && \
        cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda-12.5/include && \
        cp cudnn-*-archive/lib/libcudnn* /usr/local/cuda-12.5/lib64 && \
        wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/secure/8.6.1/tars/TensorRT-8.6.1.6.Ubuntu-20.04.aarch64-gnu.cuda-12.0.tar.gz && \
        tar -xzvf TensorRT-8.6.1.6.Ubuntu-20.04.aarch64-gnu.cuda-12.0.tar.gz && \
        cp -r TensorRT-8.6.1.6/include/* /usr/local/cuda-12.5/include && \
        cp -r TensorRT-8.6.1.6/lib/* /usr/local/cuda-12.5/lib64 && \
        pip install tensorflow-2.16.1-cp312-cp312-linux_x86_64.whl --break-system-packages && \
        pip install torch torchvision torchaudio notebook --break-system-packages

RUN rm -rf /tmp/*

EXPOSE 80
CMD ["sleep", "infinity"]
