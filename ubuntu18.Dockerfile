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
        python3-setuptools python3-wheel          \
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
ADD public.key ${SPACK_ROOT}/var/spack/gpg/

ENV PATH=$SPACK_ROOT/bin:$PATH

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

RUN spack gpg init
CMD ["bash", "-l"]

RUN spack mirror add --scope=site js947 http://js947-spack-mirror.s3-website-eu-west-1.amazonaws.com
RUN spack mirror list

RUN spack install gcc@5.5.0 target=x86_64
RUN spack install gcc@6.5.0 target=x86_64
RUN spack install gcc@7.4.0 target=x86_64
RUN spack install gcc@8.4.0 target=x86_64
RUN spack install gcc@9.3.0 target=x86_64
RUN spack install gcc@10.1.0 target=x86_64

RUN eval `spack load --sh gcc@5` && spack compiler add --scope site
RUN eval `spack load --sh gcc@6` && spack compiler add --scope site
RUN eval `spack load --sh gcc@7` && spack compiler add --scope site
RUN eval `spack load --sh gcc@8` && spack compiler add --scope site
RUN eval `spack load --sh gcc@9` && spack compiler add --scope site
RUN eval `spack load --sh gcc@10` && spack compiler add --scope site
