#!/bin/sh

# on changes to this file, it gets run automatically on the online website

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

aclocal && \
automake --foreign --add-missing --copy && \
autoconf \
  || exit 1

cd $ORIGDIR

echo "Running $srcdir/configure" "$@"
$srcdir/configure "$@"

echo 
echo "Now type 'make' to create the website."
