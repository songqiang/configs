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
export CVS_RSH=ssh
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

# Aliases 
test -s ~/.alias && . ~/.alias || true


# Functions
findgrep () {           # find | grep
        if [ $# -eq 0 ]; then
                echo "findgrep: No arguments entered."; return 1
        else
                # "{.[a-zA-Z],}*" instead of "." makes the output cleaner
                find {.[a-zA-Z],}* -type f | xargs grep -n $* /dev/null \
                                2> /dev/null
        fi
}

swap () {               # swap 2 filenames around
        if [ $# -ne 2 ]; then
                echo "swap: 2 arguments needed"; return 1
        fi

        if [ ! -e $1 ]; then
                echo "swap: $1 does not exist"; return 1
        fi

        if [ ! -e $2 ]; then
                echo "swap: $2 does not exist"; return 1
        fi

        local TMPFILE=tmp.$$ ; mv $1 $TMPFILE ; mv $2 $1 ; mv $TMPFILE $2
}

rot13 () {              # For some reason, rot13 pops up everywhere
        if [ $# -eq 0 ]; then
                tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
        else
                echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
        fi
}


#[HISTORY]

#v0.1.1 [2007-09-19]
#move alias to .alias

#v0.1.0
#.bashrc - Joshua Uziel - Feel free to use any part of this.

#v0.0.0
# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg


test -r /sw/bin/init.sh && . /sw/bin/init.sh
