#! /bin/bash

export LD_LIBRARY_PATH=$(dirname $(readlink -f $0))/htslib/lib:${LD_LIBRARY_PATH}

$(dirname $(readlink -f $0))/bamcmpbin/bamcmp $@

