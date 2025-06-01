#!/bin/sh
dir=${0%/*} && [ $dir = $0 ] && dir='.'
cp -iv $dir/.[!.]* $HOME

