FROM centos:7

RUN yum install -y centos-release-scl \
 && yum install -y \
        gcc-{c++,gfortran} make bzip2 python3-pip git-core \
        devtoolset-\?-gcc{,-c++,-gfortran} \
 && rm -rf /var/cache/yum \
 && yum clean all
RUN pip3 install boto3

ENV SPACK_ROOT=/opt/spack

RUN git clone https://github.com/spack/spack $SPACK_ROOT
ADD compilers.yaml ${SPACK_ROOT}/etc/spack
ADD public.key ${SPACK_ROOT}/var/spack/gpg/

ENV PATH=$SPACK_ROOT/bin:$PATH

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

RUN spack gpg init
CMD ["bash", "-l"]
