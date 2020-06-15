#!/bin/sh

sudo dnf config-manager \
  --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf config-manager --disable 'docker-ce*'

xargs -a <(sed 's/#.*//g' docker.txt) \
  sudo dnf --enablerepo='docker-ce-stable' install

# https://docs.docker.com/engine/install/fedora/
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
