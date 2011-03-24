export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000

export PS1="\! \w: "

shopt -s cdspell

set -o vi

shopt -s checkwinsize

stty -ixon

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

alias gitkcl="git log --pretty=format:\"%h : %s\" --topo-order --graph"
