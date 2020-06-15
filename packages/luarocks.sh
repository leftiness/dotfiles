#!/bin/sh

xargs -a <(sed 's/#.*//g' luarocks.txt) \
  luarocks install --tree $HOME/.local/
