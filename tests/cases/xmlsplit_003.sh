#! /bin/sh

set -ue

TMP_DIR=tmp-$(basename $0 .sh)-$$
mkdir ${TMP_DIR}

cat \
    tests/inputs/cml/cube.cml \
    tests/inputs/cml/trefoil-on-a-lattice.cml \
    tests/inputs/cml/hopf-link-minimised.cml \
    | ./xmlsplit -o ${TMP_DIR}/split/out/

(
    cd ${TMP_DIR}
    find -type f | sort
)

rm -rf ${TMP_DIR}
