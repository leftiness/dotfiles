#!/bin/sh

xargs -a <(sed 's/#.*//g' npm.txt) npm ig -g --prefix /home/brandon/.local
