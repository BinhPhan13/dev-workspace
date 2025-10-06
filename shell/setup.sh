#!/bin/sh
self="${0%/*}"
[ "$self" = "$0" ] && self="."
cp -iv $self/.[!.]* $HOME

