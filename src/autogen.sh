#!/bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

aclocal && \
automake --add-missing --copy && \
autoconf \
  || exit 1

cd $ORIGDIR

echo "Running $srcdir/configure" "$@"
$srcdir/configure "$@"

echo 
echo "Now type 'make' to create the website."
