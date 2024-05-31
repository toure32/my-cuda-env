FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

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
        gnupg \
        lsb-release \
        clang \
        git -y

RUN ln -s /usr/bin/python3 /usr/bin/python
# RUN pip install torch torchvision torchaudio
# RUN pip install notebook

RUN cd /tmp

RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt-get update &&  apt-get install -y bazel


RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb
RUN apt-get update
RUN apt-get -y install cuda-toolkit-12-5

# RUN update-alternatives --set cuda /usr/local/cuda-12

RUN wget https://developer.download.nvidia.com/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-8.9.7.29_cuda12-archive.tar.xz
RUN tar -xvf cudnn-linux-x86_64-8.9.7.29_cuda12-archive.tar.xz
RUN cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda-12.5/include
RUN cp cudnn-*-archive/lib/libcudnn* /usr/local/cuda-12.5/lib64

RUN wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/secure/8.6.1/tars/TensorRT-8.6.1.6.Ubuntu-20.04.aarch64-gnu.cuda-12.0.tar.gz
RUN tar -xzvf TensorRT-8.6.1.6.Ubuntu-20.04.aarch64-gnu.cuda-12.0.tar.gz
RUN cp -r TensorRT-8.6.1.6/include/* /usr/local/cuda-12.5/include
RUN cp -r TensorRT-8.6.1.6/lib/* /usr/local/cuda-12.5/lib64


RUN cd /

RUN python_version=$(python3 --version 2>&1 | awk '{print $2}' | cut -d'.' -f1,2) \
    && echo "export TF_PYTHON_VERSION=$python_version" >> /root/.bashrc

RUN wget https://github.com/tensorflow/tensorflow/archive/refs/tags/v2.16.1.tar.gz && \
    tar -xf v2.16.1.tar.gz && \
    mv tensorflow-2.16.1 tensorflow && \
    rm v2.16.1.tar.gz



RUN apt update && apt install bazel-6.5.0

#Set the environment variables for building tensorflow

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

WORKDIR /tensorflow
# RUN ./configure
# RUN bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package --copt=-mno-avx --copt=-mno-avx2 --copt=-mno-fma --copt=-mno-sse4.1 --copt=-mno-sse4.2
# RUN ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

# RUN pip install /tmp/tensorflow_pkg/tensorflow-*.whl
# pip install patchelf


# COPY ./check_gpu.py ./
# COPY ./entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# CMD ["/entrypoint.sh"]
# EXPOSE 80
CMD ["sleep", "infinity"]
# ENTRYPOINT ["/entrypoint.sh"]
