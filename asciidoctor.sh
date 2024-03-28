#!/bin/sh

ad="/usr/local/bin/asciidoctor-real"

$ad -a icons=font \
    -r asciidoctor-html5s \
    -r asciidoctor-diagram \
    "$@" | sed -E -e "s/img src=\"([^/]+)\"/img src=\"\/diagram\/\1\"/"

#$ad -v -B . -r asciidoctor-diagram -b html5s -r asciidoctor-html5s \
#    -a icons=font -a docinfo=shared -a nofooter -a sectanchors -a experimental=true -a figure-caption! \
#    -a source-highlighter=highlightjs -a toc-title! -a stem=mathjax - | sed -E -e "s/img src=\"([^/]+)\"/img src=\"\/diagram\/\1\"/"

#    --attribute sectlinks \
#    --attribute sectanchors \
#    --attribute figure-caption! \
#    --attribute toc-title! \
#    --attribute nofooter \
#    --attribute docinfo=shared \

mkdir -p static/diagram

if ls *.svg >/dev/null 2>&1; then
  mv -f *.svg static/diagram
fi

if ls *.png >/dev/null 2>&1; then
  mv -f *.png static/diagram
fi
