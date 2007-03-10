#!/bin/bash

files=(\
byumsphd-example.tex \
byumsphd.cls \
)

version=`sed \
  -e 's/^%[[:space:]]*Version:[[:space:]]*\\(.*\\)[[:space:]]*$/\\1/p' \
  -e 'd' \
  byumsphd.cls`

outputfile=latex-byu-thesis-$version.tar.gz

echo Creating $outputfile

tar czf $outputfile ${files[@]}
