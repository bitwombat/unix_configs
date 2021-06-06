# Shell settings
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
shopt -s histappend
shopt -s histverify
shopt -s histreedit
shopt -s no_empty_cmd_completion
shopt -s autocd
ulimit -c 0
umask 027

# Turn on line editing, even though .inputrc does this, so later binds work
set -o vi

# Key bindings
# Ctrl-g s will open a new terminal window in the same dir
bind -x '"\C-gs":"term same"'

if [ -n "$PS1" ]; then
    stty -ixon
fi

# Tell non-interactive shells where to go
export BASH_ENV=$HOME/.bashrc

# Functions

# "makedir and cd to it"
function mcd() {
  mkdir $1;
  cd $1;
}

function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
		ls -Boh --color=yes --group-directories-first
}

# "cd there"
function cdt() {
    path=$_
    dirname=$(dirname $path)
    if [ -d $path ]; then
        cd $path
    elif [ -d $dirname ]; then
        cd $dirname
    else
        echo "Can't see directory to cd to in that command."
    fi
}

# find file
function ff() {
  find . -iname \*$1\* ;
}

# find in files
function fif() {
  find . -iname \*$1\* -exec grep -Hi $2 {} \; ;
}

# cat which
function catw() {
  cat `which $1`;
}

# vim which
function viw() {
  vim `which $1`;
}

# gvim which
function gviw() {
  gvim `which $1`;
}

# vi a new executable
function vix() {
  if [ $1 ]; then
    fn=$1
  else
   fn=tmp.$$
  fi
  if [ ! -e $fn ]; then
    echo "#!/" > $fn
  fi
  chmod +x $fn
  vim $fn
}

# cd down
function cdd() {
    cd "$(find . -name $1 -type d)"
}

# Aliases
alias ..="cd .. ; ls -Boh --color=yes --group-directories-first"
alias cg='cd `git rev-parse --show-toplevel`'
alias cp='cp -i'
alias cpv='rsync -ah --info=progress2'
alias df="pydf"
alias gst='git status'
alias gv="gvim -geometry 98x24"
alias gvi="gvim -geometry 98x24"
alias mkdir="mkdir -vp"
alias mv="mv -i"
alias o="open"
alias vi="vim"
alias wget="wget --progress=dot:mega"

alias cdr='cd "$(cat ~/.pwdremember)"'
alias pwdr='pwd > ~/.pwdremember'

# (la)test
alias la='ls -ltrh --color=yes --group-directories-first'
# (r)ecently modified
alias lr='find . -mtime -1'
# sort by (e)xtension
alias le='ls -XBoh --color=yes --group-directories-first'
# (l)ong list
alias ll='ls -Boh --color=yes --group-directories-first'
# sort by si(z)e
alias lz='ls -Boh --reverse --sort=size --color=yes --group-directories-first'

# For many apps
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox

# App-specific
export ACK_PAGER=less
export SVN_MERGE=meld
export LESS="-g -I -F -X -R"
export PAGER="less -Xi"

alias mountt="mount | column -t | sort | egrep '^/dev'"
alias ports='netstat -tulanp'
alias rsync="rsync -a --no-inc-recursive --info=progress2 "
alias o="xdg-open"
alias dig="dig +nostat +nocmd +nocomments"

function ol () {
    latest_file="$(ls -atr $1 | egrep -v '^\.' | tail -1)"
    xdg-open "$latest_file"
}

# Run/enable bash completion
[ -e /etc/profile.d/bash_completion.sh ] && . /etc/profile.d/bash_completion.sh

