# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# Ignore case on auto-completion
bind "set completion-ignore-case on"

# Show auto-completion list automatically, without double tab
bind "set show-all-if-ambiguous On"

# Create and go to the directory
mkdirg ()
{
	mkdir -p "$1"
	cd "$1"
}

# Aliases put by user
alias cd..='cd ..'
alias cd..='cd ..'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rm='trash -v'
alias cat='batcat'
alias la='lsd -A --icon never'
alias ls='lsd --icon never'
alias ll='lsd -Al --icon never --date "+%-d/%-m %H:%M" --size short --blocks permission,user,size,date,name'
alias apt='nala'
alias sudo='sudo '
alias grep='grep --color=auto'
alias shellcheck='shellcheck -x'

# Autojump
if test -f "/usr/share/autojump/autojump.sh"; then
    . /usr/share/autojump/autojump.sh
fi
