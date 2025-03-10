# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
HOME2='$HOME/dm716r/'

#ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
alias df='df -h' #huuman readable


# hide the find cruft
alias find='find 2>/dev/null'


# cd aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


# some more ls aliases
alias ls='ls  --color=auto'

alias ll='ls -l' # List files in long format
alias lsa='ls -la' # List all files including hidden ones in long format
alias lla='l -lA' # List almost all files in long format (excluding . and ..)
alias la='ls -A' # List almost all files (excluding . and ..)
alias l='ls -CF' # List files in columns, with file type indicators
alias lss='ls -laStr' # List all files including hidden ones, sorted by modification time in reverse order
alias lar='ls -laR' # List all files including hidden ones, recursively
alias ld='ls -d */' # List only directories
alias lda='{ ls -d .*/ ; ls -d */; }' # List hidden and non-hidden directories
alias ldas='{ ls -d .*/ ; ls -d */; } |sort' # List hidden and non-hidden directories, sorted
alias lst='ls -ltr' # List files in long format, sorted by modification time in reverse order
alias ls_='ls -1 | sort -t " " -k1.1,1.1 -k1.2'   # sort with _ at the top



alias dt='date "+%Y-%m-%d %H:%M:%S"'

# per xkcd, if i had to defuse a bomb and the password was tar compress, the thing would blow up, hence these commands
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# history search
alias h='history | grep'
alias hist='history'


# Set environment variables
export S_COLORS=auto
export TMOUT=900


extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

export HISTCONTROL=ignoreboth
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTSIZE=
export HISTFILESIZE=

calc () {
    bc -l <<< "$@"
}


lscat () {
        ls -tr | tail -n $@  | xargs cat
}




# Searches for text in all files in the current folder
function ftext
{
        # -i case-insensitive
        # -I ignore binary files
        # -H causes filename to be printed
        # -r recursive search
        # -n causes line number to be printed
        # optional: -F treat search term as a literal, not a regular expression
        # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
        grep -iIHrn --color=always "$1" . | less -r
}

# take a note
function note {
  if [ -z "$1" ]; then
    echo "No note entered."
  else
    echo "$@" >> "$HOME2/.notes"
  fi
}

# display notes
function notes {
  FN="$HOME2/.notes"
  if [ ! -f "$FN" ]; then
    echo "No notes (file missing)."
    return
  fi

  if [ -z "$1" ]; then
    LINECOUNT="10"
  else
    LINECOUNT="$1"
  fi
  LNUM=$(wc -l "$FN"|cut -d " " -f1)
  echo "Showing max $LINECOUNT of $LNUM notes."
  tail "$FN" -n "$LINECOUNT"
}

# clear all notes
function clearnotes {
  rm "$HOME2/.notes"
  touch "$HOME2/.notes"
}




# Extracts any archive(s) (if unp isn't installed)
extract () {
        for archive in $*; do
                if [ -f $archive ] ; then
                        case $archive in
                                *.tar.bz2)   tar xvjf $archive    ;;
                                *.tar.gz)    tar xvzf $archive    ;;
                                *.bz2)       bunzip2 $archive     ;;
                                *.rar)       rar x $archive       ;;
                                *.gz)        gunzip $archive      ;;
                                *.tar)       tar xvf $archive     ;;
                                *.tbz2)      tar xvjf $archive    ;;
                                *.tgz)       tar xvzf $archive    ;;
                                *.zip)       unzip $archive       ;;
                                *.Z)         uncompress $archive  ;;
                                *.7z)        7z x $archive        ;;
                                *)           echo "don't know how to extract '$archive'..." ;;
                        esac
                else
                        echo "'$archive' is not a valid file!"
                fi
        done
}


# Create and go to the directory
mkdirg ()
{
        mkdir -p $1
        cd $1
}


# Show current network information
netinfo ()
{
        echo "--------------- Network Information ---------------"
        /sbin/ifconfig | awk /'inet addr/ {print $2}'
        echo ""
        /sbin/ifconfig | awk /'Bcast/ {print $3}'
        echo ""
        /sbin/ifconfig | awk /'inet addr/ {print $4}'

        /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
        echo "---------------------------------------------------"
}


# cat the nth last file in a directory by time
lscat () {
        ls -tr | tail -n $@  | xargs cat
}


# Trim leading and trailing spaces (for scripts)
trim()
{
        local var=$@
        var="${var#"${var%%[![:space:]]*}"}"  # remove leading whitespace characters
        var="${var%"${var##*[![:space:]]}"}"  # remove trailing whitespace characters
        echo -n "$var"
}



# Show the current distribution
distribution ()
{
        local dtype
        # Assume unknown
        dtype="unknown"

        # First test against Fedora / RHEL / CentOS / generic Redhat derivative
        if [ -r /etc/rc.d/init.d/functions ]; then
                source /etc/rc.d/init.d/functions
                [ zz`type -t passed 2>/dev/null` == "zzfunction" ] && dtype="redhat"

        # Then test against SUSE (must be after Redhat,
        # I've seen rc.status on Ubuntu I think? TODO: Recheck that)
        elif [ -r /etc/rc.status ]; then
                source /etc/rc.status
                [ zz`type -t rc_reset 2>/dev/null` == "zzfunction" ] && dtype="suse"

        # Then test against Debian, Ubuntu and friends
        elif [ -r /lib/lsb/init-functions ]; then
                source /lib/lsb/init-functions
                [ zz`type -t log_begin_msg 2>/dev/null` == "zzfunction" ] && dtype="debian"

        # Then test against Gentoo
        elif [ -r /etc/init.d/functions.sh ]; then
                source /etc/init.d/functions.sh
                [ zz`type -t ebegin 2>/dev/null` == "zzfunction" ] && dtype="gentoo"

        # For Mandriva we currently just test if /etc/mandriva-release exists
        # and isn't empty (TODO: Find a better way :)
        elif [ -s /etc/mandriva-release ]; then
                dtype="mandriva"

        # For Slackware we currently just test if /etc/slackware-version exists
        elif [ -s /etc/slackware-version ]; then
                dtype="slackware"

        fi
        echo $dtype
}

# Show the current version of the operating system
ver ()
{
        local dtype
        dtype=$(distribution)

        if [ $dtype == "redhat" ]; then
                if [ -s /etc/redhat-release ]; then
                        cat /etc/redhat-release && uname -a
                else
                        cat /etc/issue && uname -a
                fi
        elif [ $dtype == "suse" ]; then
                cat /etc/SuSE-release
        elif [ $dtype == "debian" ]; then
                lsb_release -a
                # sudo cat /etc/issue && sudo cat /etc/issue.net && sudo cat /etc/lsb_release && sudo cat /etc/os-release # Linux Mint option 2
        elif [ $dtype == "gentoo" ]; then
                cat /etc/gentoo-release
        elif [ $dtype == "mandriva" ]; then
                cat /etc/mandriva-release
        elif [ $dtype == "slackware" ]; then
                cat /etc/slackware-version
        else
                if [ -s /etc/issue ]; then
                        cat /etc/issue
                else
                        echo "Error: Unknown distribution"
                        exit 1
                fi
        fi
}




PS1='\[\e[38;5;117m\]\u\[\e[38;5;20m\]@\[\e[38;5;26m\]\H\[\e[0m\] - \[\e[38;5;202m\]\w\[\e[0m\] - \[\e[38;5;202m\]\s\[\e[0m\] \[\e[36m\][\d\[\e[0m\] \[\e[36m\]\@]\[\e[0m\] \n\$ '




alias
