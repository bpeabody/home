export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000

export PS1='\! $(hostname):$ '

shopt -s cdspell

set -o vi

shopt -s checkwinsize
shopt -s histappend

stty -ixon

alias gitkcl="git log --pretty=format:\"%h : %s\" --topo-order --graph"
alias ssh="ssh -X"
