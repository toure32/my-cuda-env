# Utiliser la dernière version de l'image CUDA
FROM tensorflow/tensorflow:latest-gpu
# nvidia/cuda:12.3.1-runtime-ubuntu22.04


RUN apt update && apt upgrade -y && \
    apt install \
        vim \
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
        git -y
    # ln -s /usr/bin/python3 /usr/bin/python
RUN pip install torch torchvision torchaudio
RUN pip install notebook

COPY ./check_gpu.py ./
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# CMD ["/entrypoint.sh"]
# EXPOSE 80
CMD ["sleep", "infinity"]
# ENTRYPOINT ["/entrypoint.sh"]
