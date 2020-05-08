FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -yqq update                           \
 && apt-get -yqq install --no-install-recommends  \
        build-essential                           \
        ca-certificates                           \
        curl                                      \
        file                                      \
        g++                                       \
        gcc                                       \
        gfortran                                  \
        git                                       \
        gnupg2                                    \
        iproute2                                  \
        lmod                                      \
        locales                                   \
        lua-posix                                 \
        make                                      \
        openssh-server                            \
        python3                                   \
        python3-pip                               \
        tcl                                       \
        unzip                                     \
 && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8
RUN pip3 install boto3
RUN ln -s posix_c.so /usr/lib/x86_64-linux-gnu/lua/5.2/posix.so

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV SPACK_ROOT=/opt/spack

RUN git clone https://github.com/spack/spack $SPACK_ROOT
ADD compilers.yaml ${SPACK_ROOT}/etc/spack

ENV PATH=$SPACK_ROOT/bin:$PATH

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

CMD ["bash", "-l"]