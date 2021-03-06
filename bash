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
alias more=less

powerline-daemon -q

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. ~/repos/powerline/powerline/bindings/bash/powerline.sh
