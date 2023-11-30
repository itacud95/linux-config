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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

PATH="$PATH:/home/jk/linux-config/scripts"

PATH="$PATH:/home/jk/dev/er/target/release"
complete -C /home/jk/.cargo/bin/er er

alias ll="ls -lAhtr --color=auto"
alias l="ls -CF"
alias week="date +%V"
alias open="xdg-open"
alias gits="git status"
alias gitl="git log --all --decorate --oneline --graph"
alias gita="git add -u"
alias gitp="git push"
alias gitpr="git pull --rebase"
alias gitpf="git push --force-with-lease"
alias gitd="git diff"
alias gitm="git checkout master"
alias git-="git checkout -"
alias gith="git rev-parse --short HEAD"
alias gpull="git pull -p"
alias gitb="git for-each-ref --count=15 --sort=-committerdate refs/heads --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gitn="git rev-parse --abbrev-ref HEAD"
alias vim="nvim"
alias clang-format='/opt/clang-format-static/clang-format-8'
# sudo pacman -S github-cli
alias note="GH_EDITOR=nvim gh gist edit 1740ce7dafd0c7987a210eabfff836ee"
alias down="cd ~/Downloads"
# cl = copylast
alias cl="history | tail -2 | head -1 | cut -c8- | xclip -selection clipboard"
alias co="tee /dev/tty | xclip -selection clipboard"

e() {
  echo "${*:?'Missing command!'}"
  exec bash -c "${*:?'Missing command!'}"
}

gitc() {
  git commit -m "${1:?'Missing git commit message!'}"
}
gitg() {
  git fetch --all --prune; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D;
}

finddir() {
  if [ $# -lt 1 ]; then  # Check that the function has one argument
    echo "Usage: finddir <directory> optional: <exclude_dir>"
    return 1
  fi
  
  cmd="find $(pwd) -type d -name \"*$1*\""

  output=$(eval "$cmd")
  if [ -z "$output" ]; then
      echo "Could not find any directories containing '$1'"
      exit 1
  fi

  i=1
  while IFS= read -r line; do
      # echo "$i. $line"
      colored=$(echo "$i. $line" | grep --color=always $1)
      echo "$colored"
      # echo "$i. $line"
      ((i++))
  done <<< "$output"

  read -r -p "Select a number (default is 1): " selection

  if [ -z "$selection" ]; then
      selection=1
  fi

  if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "$i" ]; then
      echo "Invalid selection"
      exit 1
  fi

  selected_directory=$(echo "$output" | sed -n "${selection}p")

  echo "Going to directory: $selected_directory"
  cd "${selected_directory}" || exit 1

}

gitout() {
  git stash || return
  git fetch && git checkout "${1:?'Missing git commit message!'}"
  git stash pop
}
_gitout_complete() {
    branches=$(git branch -r | sed s:origin/::)
    COMPREPLY=($(compgen -W "$branches" -- "$2"))
}
complete -F _gitout_complete gitout

git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
#PS1='\e[00;31m[\w] \e[00;36m$(git_branch)  \n'
PS1='\e[00;31m[\w] \e[00;36m$(git_branch) \e[0m \n'
#PS1=' ✔ [\w] $(git_branch)\n'

eval "$(register-python-argcomplete build.py)"
eval "$(register-python-argcomplete crash_decoder)"
source /usr/share/bash-completion/completions/git
source /usr/share/bash-completion/completions/python-argcomplete

# Android
ANDROID_NDK_ROOT=/opt/android/android-ndk
export ANDROID_NDK_ROOT
PATH="$PATH:$ANDROID_NDK_ROOT"

export PATH=$PATH:$ANDROID_HOME/emulator
# PATH="$PATH:$ANDROID_HOME/tools"

alias dup="kitty . &"

alias strip="/opt/android/android-ndk-r22b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip"
alias objcopy="/opt/android/android-ndk-r22b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-objcopy"
# alias code="vscodium"
alias ghidra="_JAVA_AWT_WM_NONREPARENTING=1 ~/dev/ghidra/ghidraRun"
