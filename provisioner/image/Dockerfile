FROM centos:centos7

# OSG RPMs
RUN yum -y install https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el7-release-latest.rpm && \
    yum -y install epel-release \
                   yum-plugin-priorities && \
    yum -y install less which \
                   redhat-lsb-core && \
    yum -y install python3-pip git && \
    yum -y install condor python3-condor && \
    yum clean all


RUN pip3 install kubernetes


# add condor config
ADD condor.d/*.config /etc/condor/config.d/


# configure python packages
RUN mkdir -p /opt/provisioner && cd /opt/provisioner && git clone https://github.com/sfiligoi/prp-htcondor-portal.git && cd prp-htcondor-portal && git checkout ucsdt2_pool_base
RUN mkdir -p /opt/provisioner && cd /opt/provisioner && git clone https://github.com/sfiligoi/prp-ucsdt2-pool.git && cd prp-ucsdt2-pool && git checkout main

ADD setup_k8s_creds.sh /opt/provisioner/setup_k8s_creds.sh
ADD provisioner_main.py /opt/provisioner/provisioner_main.py

RUN useradd provisioner && chown -R provisioner /opt/provisioner

RUN su provisioner -c '/usr/bin/ln -s /opt/provisioner/prp-ucsdt2-pool/provisioner/python/t2_provisioner /home/provisioner/t2_provisioner'
RUN su provisioner -c '/usr/bin/ln -s /opt/provisioner/prp-htcondor-portal/provisioner/python/prp_provisioner /home/provisioner/prp_provisioner'

ADD provisioner_main.py /home/provisioner/provisioner_main.py
RUN chown provisioner /home/provisioner/provisioner_main.py

ADD setup_k8s_creds.sh /opt/provisioner/setup_k8s_creds.sh
ADD provisioner_startup.sh /opt/provisioner/provisioner_startup.sh

#
# Requires env variables
# K8S_NAMESPACE
# CVMFS_MOUNTS
#

CMD ["/opt/provisioner/provisioner_startup.sh"]

