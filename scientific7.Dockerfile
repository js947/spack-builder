FROM scientificlinux/sl:7

RUN yum install -y epel-release \
 && yum --enablerepo epel groupinstall -y "Development Tools" \
 && yum --enablerepo epel install -y                          \
        curl           findutils gcc-c++    gcc               \
        gcc-gfortran   git       gnupg2     hostname          \
        iproute        Lmod      make       patch             \
        openssh-server python    python-pip tcl               \
        unzip          which                                  \
 && rm -rf /var/cache/yum                                     \
 && yum clean all
RUN pip install boto3

ENV SPACK_ROOT=/opt/spack

RUN git clone https://github.com/spack/spack $SPACK_ROOT
ADD compilers.yaml ${SPACK_ROOT}/etc/spack
ADD public.key ${SPACK_ROOT}/var/spack/gpg/

ENV PATH=$SPACK_ROOT/bin:$PATH

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

RUN spack gpg init
CMD ["bash", "-l"]
