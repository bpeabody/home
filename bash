export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000
export GIT_SSL_NO_VERIFY=1

export PS1='\W$ '

# Set the title to the current working directory, using '~' for $HOME
setBashTitle() {
    tildePWD=$(PWD)
    [[ "$tildePWD" =~ ^"$HOME"(/|$) ]] && tildePWD="~${tildePWD#$HOME}"
    printf "\033k$tildePWD\033\\"
}

# When we're about to show the prompt, use 'setBashTitle' to set the title.
PROMPT_COMMAND=setBashTitle

# This function sets the title to the value of '$BASH_COMMAND', the currently
# running command.
setCommandTitle() {
    tildePWD=$(PWD)
    [[ "$tildePWD" =~ ^"$HOME"(/|$) ]] && tildePWD="~${tildePWD#$HOME}"
    echo -ne "\033k$BASH_COMMAND $tildePWD\033\\"
}

# Use the trap to set the title to the currently running command at the time
# when it's available.
trap setCommandTitle DEBUG

shopt -s cdspell

set -o vi

shopt -s checkwinsize
shopt -s histappend

stty -ixon

alias gitkcl="git log --pretty=format:\"%h : %s\" --topo-order --graph"
alias ssh="ssh -X"
alias more=less
alias tmux="tmux -2"
