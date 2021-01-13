# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f "$HOME/.config/scripts/aliasrc" ] && source "$HOME/.config/scripts/aliasrc

export PS1="\[\033[38;5;26m\][\[$(tput sgr0)\]\[\033[38;5;32m\]\u\[$(tput sgr0)\]\[\033[38;5;26m\]@\[$(tput sgr0)\]\[\033[38;5;32m\]\h\[$(tput sgr0)\]\[\033[38;5;38m\] \W\[$(tput sgr0)\]\[\033[38;5;26m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"


neofetch
