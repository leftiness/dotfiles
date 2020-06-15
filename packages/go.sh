#!/bin/sh

xargs -a <(sed 's/#.*//g' go.txt) GOPATH=$HOME/.local go get
