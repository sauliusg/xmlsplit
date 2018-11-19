#! /bin/sh

set -ue

TMP_DIR=tmp-$(basename $0 .sh)-$$
mkdir ${TMP_DIR}

cat tests/inputs/cml/cube.cml tests/inputs/cml/trefoil-on-a-lattice.cml \
    | ./xmlsplit -o ${TMP_DIR}

(
    cd ${TMP_DIR}
    diff -s xmlsplit_0001.xml ../tests/inputs/cml/cube.cml
    diff -s xmlsplit_0002.xml ../tests/inputs/cml/trefoil-on-a-lattice.cml
    ls xmlsplit_0003.xml 2>&1 || true
)

rm -rf ${TMP_DIR}
