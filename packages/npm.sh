#!/bin/sh

xargs -a <(sed 's/#.*//g' npm.txt) npm install --global
