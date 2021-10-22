#!/bin/bash

#
# Adapted from https://github.com/htcondor/htcondor/blob/master/build/docker/services/base/start.sh
#

prog=${0##*/}
progdir=${0%/*}

fail () {
    echo "$prog:" "$@" >&2
    exit 1
}

add_values_to () {
    config=$1
    shift
    printf "%s=%s\n" >> "/etc/condor/config.d/$config" "$@"
}

# Create a config file from the environment.
# The config file needs to be on disk instead of referencing the env
# at run time so condor_config_val can work.
echo "# This file was created by $prog" > /etc/condor/config.d/10-site.conf
echo 'STARTD_EXPRS = $(STARTD_EXPRS) GLIDEIN_Site GLIDEIN_CMSSite GLIDEIN_ResourceName' \
  >> /etc/condor/config.d/10-site.conf
add_values_to 10-site.conf \
    GLIDEIN_Site "\"${GLIDEIN_Site:-SDSC-PRP}\"" \
    GLIDEIN_CMSSite "\"${GLIDEIN_CMSSite:-T2_US_UCSD}\"" \
    GLIDEIN_ResourceName "\"${GLIDEIN_ResourceName:-SDSC-PRP-CE1}\"" 

echo "# This file was created by $prog" > /etc/condor/config.d/11-glidein-consts.conf
echo 'STARTD_EXPRS = $(STARTD_EXPRS) IS_GLIDEIN GLIDEIN_SiteWMS GLIDEIN_Name' \
  >> /etc/condor/config.d/11-glidein-consts.conf
add_values_to 11-glidein-consts.conf \
    GLIDEIN_SiteWMS "\"kubernetes\"" \
    IS_GLIDEIN "true" \
    GLIDEIN_Name "\"prp-ucsdt2-pool_wn\""

