#!/bin/sh

xargs -a <(sed 's/#.*//g' cargo.txt) CARGO_HOME=$HOME/.local cargo install
