# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

alias ranger='. ranger'
