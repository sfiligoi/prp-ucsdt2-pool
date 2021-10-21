#!/bin/bash

if [ 'x${K8S_NAMESPACE}' == 'x' ]; then
  K8S_NAMESPACE='cms-ucsd-t2'
fi

# k8s nodes have no domain, which is annoying
# Add it here
cp /etc/hosts /tmp/hosts && sed "s/\(t2-wn-.*\)/\1\.${K8S_NAMESPACE}.optiputer.net \1/" /tmp/hosts > /etc/hosts && rm -f /tmp/hosts
