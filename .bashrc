# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##### PROMPT #####

HOST='\[\033[1;33m\]@\[\033[1;32m\]\h'
PROMPT_COMMAND='RET=$?; history -a'
RETCOLOR='$(if [ $RET != 0 ]; then echo "\e[1;31m"; else echo "\e[1;36m"; fi)'
export PS1="\[\e[1;31m\]\u$HOST \`if [ \"\w\" != \"~\" ]; then echo -e \
  '\[\e[1;36m\]\w ';fi\`\[\e[1;31m\]>>\[$RETCOLOR\]>\[\e[0m\] "
PS2='> '
PS3='> '
PS4='+ '

HISTCONTROL=ignoreboth:erasedups

export VISUAL=vim EDITOR=vim

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    SCREENTITLEPROGRAM='\[\ek\e\\\]'
    PS1="${SCREENTITLEPROGRAM}${PS1}" 
    ;;
esac

[[ -n "$TMUX" ]] && export TERM=screen-256color

shopt -s histappend
shopt -s checkwinsize
shopt -s autocd
shopt -s cmdhist
shopt -s extglob

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p -v'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias view='vim -R'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias ll='ls -lah'
alias lt='ls -lahtr'
alias gdc='git diff --cached'
