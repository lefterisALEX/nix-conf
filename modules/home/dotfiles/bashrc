

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias g='git'
alias lg='lazygit'
alias llll='ls -ltrh'

if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/nix/store/80w98qbaxwyrd0wisi5zd0yqjyrh4pbs-bash-completion-2.11/etc/profile.d/bash_completion.sh"
fi

