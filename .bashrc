# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Aliases
alias p='python3'
alias .='cd ~'
alias ..='cd ..'
alias hscp='history | grep scp'

function code() {
	gnome-terminal --geometry 130x300+0+300 -- gvim "$1"

}

# go up n directories
up()
{
    local str=""
    local count=0
    while [[ "$count" -lt "$1" ]] ;
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Notify when a command is completed, with a visual warning.
function notify() {
    cmd=$(echo "$1" | sed 's/&/&amp;/g')
    if [[ "$1" != "" ]] ; then
        $@
    fi
    if [[ $? ]] ; then
        msg="Your \"$cmd\" command is completed"
    else
        msg="There was an error in your \"$cmd\" command"
    fi
    zenity --info --text "$msg\nin $((e-s)) s\n$(date)" &
}

# Notify when a command is completed, with an audio and visual warning.
function notice() {
    s=$SECONDS

    cmd=$(echo "$1" | sed 's/&/&amp;/g')
    if [[ "$1" != "" ]] ; then
        $@
    fi
    if [[ $? ]] ; then
        msg="Your \"$cmd\" command is completed"
    else
        msg="There was an error in your \"$cmd\" command"
    fi
    zenity --info --text "$msg\nin $((e-s)) s\n$(date)" &

    # if the command has run more than a minute
    # then say loudly that it ended
    e=$SECONDS
    if [[ $((e-s)) -ge 1 ]] ; then
        espeak -s 110 "$msg" 2>/dev/null >/dev/null
    fi
}

# colored cmake/gcc output using the colout command
# usage: cm ./build_script
function cm()
{
    set -o pipefail
    $@ 2>&1  | colout -t cmake | colout -t g++ | colout -t ctest
    #| less
}

function run()
{
    set -o pipefail
    cm cmake .. && cm make $@ && ./$@
}

function m()
{
    set -o pipefail
    cm cmake .. && cm make
}

function hgrep()
{
    history | grep $1
}

# go up n directories
up()
{
    local str=""
    local count=0
    while [[ "$count" -lt "$1" ]] ;
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

calc() {
    calc="$@"
    # We can use the unicode signs × and ÷
    calc="${calc//×/*}"
    calc="${calc//÷//}"
    echo -e "$calc\nquit" | gcalccmd | sed 's/^> //g'
}

# Make a directory and move to it
function md() {
    mkdir $1
    cd $1
}
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Take a snapshot of the current git repository and zip it.
# The archive file name has the current date in its name.
function git_archive()
{
    last_commit_date=$(git log -1 --format=%ci | awk '{print $1"_"$2;}' | sed "s/:/-/g")
    project=$(basename $(pwd))
    name=${project}_${last_commit_date}
    git archive --prefix=$name/ --format zip master > $name.zip
    echo $name.zip
}
