FROM ubuntu:latest

RUN apt update -y \
    && apt install -y wget libnvrtc12 ocl-icd-libopencl1 opencl-headers clinfo libuv1t64 libssl3t64 libhwloc15 \
    && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb \
    && apt -y update \
    && apt -y install nvidia-open
    
RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
    
ENV NVIDIA_VISIBLE_DEVICES all

ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN mkdir /trexminer \
    && cd /trexminer \
    && wget https://trex-miner.com/download/t-rex-0.26.8-linux.tar.gz \
    && tar -xzf *.gz \
    && rm *.gz
    
RUN chmod +x /trexminer/t-rex