#!/bin/sh

sudo dnf install \
  http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-31.noarch.rpm \
  http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-31.noarch.rpm

sudo dnf config-manager --disable 'rpmfusion*'

xargs -a <(sed 's/#.*//g' rpmfusion.txt) \
  sudo dnf
    --enablerepo='rpmfusion-free' \
    --enablerepo='rpmfusion-free-updates' \
    --enablerepo='rpmfusion-nonfree' \
    --enablerepo='rpmfusion-nonfree-updates' \
    install
