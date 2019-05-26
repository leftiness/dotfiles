# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

for file in $HOME/.config/bash/*; do
   source $file
done
