#! /bin/sh

set -ue

TMP_DIR=tmp-$(basename $0 .sh)-$$
mkdir ${TMP_DIR}

./xmlsplit --header '<!DOCTYPE ' tests/inputs/fulltext.xmls -o ${TMP_DIR}

(
    cd ${TMP_DIR}
    find . -type f | sort | xargs -n1 md5sum
)

rm -rf ${TMP_DIR}
