#!/bin/sh

xargs -a <(sed 's/#.*//g' gem.txt) gem install --bindir=$HOME/.local/bin
