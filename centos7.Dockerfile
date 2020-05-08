FROM centos:7

RUN yum install -y epel-release centos-release-scl \
 && yum --enablerepo epel groupinstall -y "Development Tools" \
 && yum --enablerepo epel install -y                          \
        curl           findutils gcc-c++    gcc               \
        gcc-gfortran   git       gnupg2     hostname          \
        iproute        Lmod      make       patch             \
        openssh-server python    python-pip tcl               \
        unzip          which                                  \
        devtoolset-\?-gcc{,-c++,-gfortran} \
 && rm -rf /var/cache/yum                                     \
 && yum clean all
RUN pip install boto3

ENV SPACK_ROOT=/opt/spack

RUN git clone https://github.com/spack/spack $SPACK_ROOT
ADD compilers.yaml ${SPACK_ROOT}/etc/spack

ENV PATH=$SPACK_ROOT/bin:$PATH

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

CMD ["bash", "-l"]