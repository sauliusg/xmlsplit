#! /bin/sh

set -ue

cat \
    tests/inputs/cml/cube.cml \
    tests/inputs/cml/trefoil-on-a-lattice.cml \
    tests/inputs/cml/hopf-link-minimised.cml \
    | ./xmlxargs -s .cml -i bash -xc 'echo MD5\({}\) = $(md5sum {})' 2>&1 \
    | sort \
    | perl -pe 's/tmp-xmlxargs-\d+/tmp-xmlxargs-99999/g'
