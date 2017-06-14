FROM centos:7
LABEL maintainer Philipp Schmitt <philipp@schmitt.co>

ARG vagrant_version
ARG userid
ARG homedir
ENV userid ${userid:-1000}
ENV vagrant_version ${vagrant_version:-1.9.5}
ENV workdir /data
ENV homedir ${homedir:-/home/user}
ENV VAGRANT_DEFAULT_PROVIDER libvirt

RUN yum makecache ;\
    yum -y update &&\
    yum install -y \
        make gcc gcc-c++ gem ruby-devel libvirt-devel openssh-clients rsync && \
    yum -y install \
      https://releases.hashicorp.com/vagrant/${vagrant_version}/vagrant_${vagrant_version}_x86_64.rpm && \
    yum clean all 

RUN useradd -m -d ${homedir} -u ${userid} user
USER user
RUN  for plugin in landrush vagrant-libvirt vagrant-triggers; do  \
      vagrant plugin install $plugin; done

VOLUME ${homedir}
WORKDIR "${workdir}"

ENTRYPOINT ["/usr/bin/vagrant"]
