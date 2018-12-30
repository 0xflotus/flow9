#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: lint.sh <filename>"
    exit 1
fi

# Find absolute paths and change directory

if [ `uname` == Darwin ]; then
    READLINK=greadlink
    BINDIR=mac
else
    READLINK=readlink
    BINDIR=linux
fi

SCRIPT_DIR=`dirname "$0"`
FLOWDIR=`$READLINK -e "$SCRIPT_DIR/.."`
FILENAME=`$READLINK -f "$1"`

cd "$FLOWDIR"

# Select the linter executable and call it

LINTER=flowtools/src/flow

[ -x "$LINTER" ] || LINTER=flowtools/bin/$BINDIR/flow

exec $LINTER --root "$FLOWDIR" -I lib --sublime "$FILENAME"
