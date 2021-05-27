# .bashrc

_man() {
	man -O width=$COLUMNS $*;
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/home/jared/.local/bin
export PATH=$PATH:/home/jared/.local/bin/Discord
export PATH=$PATH:/home/jared/.dotnet
export BROWSER=brave-browser-stable

export DOTNET_ROOT=/home/jared/.dotnet

alias sudo="sudo "
alias ls='ls --color=auto'
alias fixtime='/etc/cron.daily/sntp-update'
alias shutdown='sudo shutdown now'
alias pclear='clear; pfetch'

alias man="_man"

#PS1='[\u@\h \W]\$ '
export PS1="[\u@\h \W]\\$\[$(tput sgr0)\] "

export EDITOR=nvim;

# User modifications here

clear
pfetch
