if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

PATH=$PATH:~/.local/share/flatpak/exports/bin:~/.local/bin

export GOPATH=$HOME/.local
