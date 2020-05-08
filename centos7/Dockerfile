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

RUN ( echo ". /usr/share/lmod/lmod/init/bash"                       \
 &&   echo ". \$SPACK_ROOT/share/spack/setup-env.sh"                \
 &&   echo "if [ \"\$CURRENTLY_BUILDING_DOCKER_IMAGE\" '!=' '1' ]"  \
 &&   echo "then"                                                   \
 &&   echo "  . \$SPACK_ROOT/share/spack/spack-completion.bash"     \
 &&   echo "fi"                                                   ) \
       >> /etc/profile.d/spack.sh

RUN git clone https://github.com/spack/spack $SPACK_ROOT
ADD compilers.yaml ${SPACK_ROOT}/etc/spack

WORKDIR /root
SHELL ["/bin/bash", "-l", "-c"]

CMD ["bash"]