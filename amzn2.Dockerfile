FROM amazonlinux:2

RUN yum groupinstall -y "Development Tools" \
 && yum install -y                          \
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
