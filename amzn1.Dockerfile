FROM amazonlinux:1

RUN yum groupinstall -y "Development Tools" \
 && yum install -y                          \
        curl           findutils gcc-c++    gcc               \
        gcc-gfortran   git       gnupg2     hostname          \
        iproute        Lmod      make       patch             \
        openssh-server python    python36-pip tcl               \
        unzip          which                                  \
 && rm -rf /var/cache/yum                                     \
 && yum clean all
RUN pip-3.6 install boto3

ENV SPACK_ROOT=/opt/spack

RUN git clone https://github.com/spack/spack $SPACK_ROOT
ADD compilers.yaml ${SPACK_ROOT}/etc/spack
ADD public.key ${SPACK_ROOT}/var/spack/gpg/

ENV PATH=$SPACK_ROOT/bin:$PATH

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

RUN spack gpg init
CMD ["bash"]

RUN spack mirror add js947 s3://js947-spack-mirror
