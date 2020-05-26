#!/bin/sh

sudo dnf install \
  http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-31.noarch.rpm \
  http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-31.noarch.rpm
sudo dnf config-manager \
  --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf config-manager --disable 'rpmfusion*'
sudo dnf config-manager --disable 'docker-ce*'

# TODO /bin/sh doesn't do <() files
# TODO repetitive

xargs -a <(sed 's/#.*//g' dnf.txt) sudo dnf install

flatpak --user remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
xargs -a <(sed 's/#.*//g' flatpak.txt) flatpak install flathub

xargs -a <(sed 's/#.*//g' rpmfusion.txt) \
  sudo dnf
    --enablerepo='rpmfusion-free' \
    --enablerepo='rpmfusion-free-updates' \
    --enablerepo='rpmfusion-nonfree' \
    --enablerepo='rpmfusion-nonfree-updates' \
    install
xargs -a <(sed 's/#.*//g' docker.txt) \
  sudo dnf --enablerepo='docker-ce-stable' install
xargs -a <(sed 's/#.*//g' luarocks.txt) \
  luarocks install --tree $HOME/.local/
pip3 install --user -r pip3.txt
pip2 install --user -r pip2.txt
xargs -a <(sed 's/#.*//g' go.txt) GOPATH=$HOME/.local go get
xargs -a <(sed 's/#.*//g' gem.txt) gem install --bindir=$HOME/.local/bin
xargs -a <(sed 's/#.*//g' npm.txt) npm install --global

systemctl start docker

# TODO
# hostnamectl set-hostname foo
