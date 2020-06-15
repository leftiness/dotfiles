#!/bin/sh

flatpak --user remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

xargs -a <(sed 's/#.*//g' flatpak.flathub.txt) flatpak install flathub
