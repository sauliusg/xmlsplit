#! /bin/sh

set -ue

cat tests/inputs/fulltext.xmls \
    | ./xmlxargs -n 1 --header '<!DOCTYPE ' md5sum \
    | sed 's/tmp-xmlxargs-[0-9][0-9]*/tmp-xmlxargs-99999/'
