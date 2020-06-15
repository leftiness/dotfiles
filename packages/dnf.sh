#!/bin/sh

xargs -a <(sed 's/#.*//g' dnf.txt) sudo dnf install
