PATH=$PATH:~/.local/share/flatpak/exports/bin:~/.local/bin

export EDITOR=nvim

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx
