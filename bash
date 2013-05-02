export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000
export GIT_SSL_NO_VERIFY=1

export PS1='\!:\W$ '
export PROMPT_COMMAND='history -a'

shopt -s cdspell

set -o vi

shopt -s checkwinsize
shopt -s histappend

stty -ixon

alias gitkcl="git log --pretty=format:\"%h : %s\" --topo-order --graph"
alias ssh="ssh -X"
alias more=less
