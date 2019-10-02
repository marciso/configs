#!/bin/bash

DIR_SRC=${1:-${RS_SRC:-.}}

# leave blank if enabled
DISABLE_ETAGS=yes
DISABLE_GLOBAL=yes
DISABLE_CSCOPE=
DISABLE_CTAGS=

SPLIT=no

CSCOPE_FILES=${CSCOPE_FILES:-"$DIR_SRC/cscope.files"}
TAGS_FILE=${TAGS_FILE:-"$DIR_SRC/tags"}
ETAGS_FILE=${ETAGS_FILE:-"$DIR_SRC/etags"}

test -f "${CSCOPE_FILES}" && rm "$CSCOPE_FILES"
test -f "${CSCOPE_FILES}.quoted" && rm "${CSCOPE_FILES}.quoted"

echo " --> Generating $CSCOPE_FILES ${CSCOPE_FILES}.quoted files:"
echo " ---> Scanning $DIR_SRC..."
test -n "$DIR_SRC" && find "$DIR_SRC" -type f | grep -i -E "((\.(h|c)(xx|pp)?)|(\.i(xx|pp))|\.cc|\.hh|\.C|\.H|\.c++|\.cs)$" > "$CSCOPE_FILES"
cat "$CSCOPE_FILES" | sed -e 's/"/\\"/' -e 's/^.*$/"\0"/' > "${CSCOPE_FILES}.quoted"
echo "done (bytes: `wc -c \"$CSCOPE_FILES\" | cut -d' ' -f1`, lines: `wc -l \"$CSCOPE_FILES\" | cut -d' ' -f1`)"

if [ -z "$DISABLE_CSCOPE" ] ; then
    echo " --> Generating cscope DB"
    pushd "$DIR_SRC"
    cscope -R -v -b -q -i "${CSCOPE_FILES}.quoted"
    popd
    echo "done"
fi

if [ -z "$DISABLE_CTAGS" ] ; then
  echo " --> Generating ctags, $TAGS_FILE..."
  ctags --sort=yes -L "$CSCOPE_FILES" -f "$TAGS_FILE"
  echo "done"
fi

if [ -z "$DISABLE_ETAGS" ] ; then
  echo " --> Generating emacs ctags, $ETAGS_FILE... "
  ctags --sort=yes -e -L "$CSCOPE_FILES" -f "$ETAGS_FILE"
  echo "done"
fi

if [ -z "$DISABLE_GLOBAL" ] ; then
    echo " --> Generating GTAGS, $DIR_SRC/GTAGS..."
    gtags --file "$CSCOPE_FILES"
    echo "done"
fi

