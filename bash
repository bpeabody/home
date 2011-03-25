export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000

export PS1='\! $(hostname):\w$ '

shopt -s cdspell

set -o vi

shopt -s checkwinsize

stty -ixon

alias gitkcl="git log --pretty=format:\"%h : %s\" --topo-order --graph"
