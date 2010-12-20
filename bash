export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000

export PS1="\! \w: "

shopt -s cdspell

set -o vi

alias ls="ls --color"

shopt -s checkwinsize

stty -ixon

TERM=xterm-256color
