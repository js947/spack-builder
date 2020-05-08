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

RUN ln -s /usr/share/lmod/lmod/init/bash /etc/profile.d/98-lmod.sh
RUN ln -s $SPACK_ROOT/share/spack/setup-env.sh /etc/profile.d/99-spack.sh

RUN git clone https://github.com/spack/spack $SPACK_ROOT
#ADD compilers.yaml ${SPACK_ROOT}/etc/spack

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

CMD ["bash"]