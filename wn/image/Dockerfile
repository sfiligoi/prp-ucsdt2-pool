FROM sfiligoi/prp-portal-wn

# since we have CVMFS, use that singularity as it is updated more often
# embedded in the npid script
ADD scripts/singularity_npid.sh /usr/bin/singularity_npid.sh

# some SW way want to directly check for singularity
RUN ln -s  /usr/bin/singularity_npid.sh /usr/bin/singularity

# Some additional CVMFS checks, also use a PRP-specific DNS name
ADD image-config.d/* /etc/constainer_startup/image-config.d/

#
# Reminder: Accepts env variables
# CONDOR_HOST STARTD_NOCLAIM_SHUTDOWN
# NUM_CPUS MEMORY DISK NUM_GPUS
# K8S_NAMESPACE
#

