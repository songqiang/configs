# .bashrc
# Copyright (C) 2007 SONG QIANG
# Ideas and code here come from a variety of other sources. Thanks.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.


# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.


# For some news readers it makes sense to specify the NEWSSERVER variable here
# export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200


# $PATH
# the default $PATH is set up in /etc/profile
# if you want to add other directories, uncomment the line below
# export PATH="$PATH:other-directories"

# Set our environment variables
export MAILCHECK=0
export EDITOR=vim
export VISUAL=$EDITOR
export PAGER=less
export LESS='-iMn'
export PRINTER=lp
export HISTCONTROL=ignoredups # don't put duplicate lines in history

#Define Color
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color

# Misc settings
# this configuration is set up in /etc/profile
# if you want to modify it, recommend .profile
# umask 022                                       # Default file perm

set -o emacs                                    # Emacs key bindings
bind 'C-u:kill-whole-line'                      # Ctrl-U kills whole line
bind 'set bell-style visible'                   # No beeping
#bind 'set horizontal-scroll-mode on'           # Don't wrap
bind 'set show-all-if-ambiguous on'             # Tab once for complete
bind 'set visible-stats on'                     # Show file info in complete

# Prompt
if [[ `whoami` = 'root' ]]; then
	export PS1="\[\033[00m\033[01;31m\]\h \[\033[01;34m\]$PROMPT_DIRSTRING \\\$ \[\033[00m\]"
else
	export PS1="\[${NC}${LIGHTRED}\]\u\[${YELLOW}\]@\[${LIGHTGREEN}\]\h:\[${LIGHTCYAN}\]\w\n\$ \[${NC}\]"
fi

# Add pushd enhanced cd command to quickly switch between directories
pushd_cd()
{
    if (("$#" > 0)); then
        if [[ "$1" == "-" ]]; then
            popd > /dev/null
            dirs -v
        elif [[ -d "$1" ]]; then
            local idx=
            local dir=
            read idx dir <<< $(dirs -v -l | egrep "^ *[0-9]+ +${1}$")
            if [[ -z "$idx" ]]; then
                pushd "$1" > /dev/null
            else
                pushd +"$idx" > /dev/null
            fi
        elif [[ "${1:0:1}" == "+" || "${1:0:1}" == "-" ]]; then
            pushd "$1" > /dev/null
        else
            pushd +"$1" > /dev/null
        fi
    else
        pushd > /dev/null
    fi
}
complete -d pushd_cd

dirs_or_popd()
{
    if (("$#" == 0)); then
       dirs -v
    else
        popd -n +"$1" > /dev/null
        dirs -v
    fi
}

# Aliases
[[  -s ~/.alias ]] && source ~/.alias || true

