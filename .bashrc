#
# ~/.bashrc
#
# Edited from helmuthdu's version - https://github.com/helmuthdu/dotfiles



# -------------------------------------------------------------
#  General
# -------------------------------------------------------------
_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && _islinux=true

_isarch=false
[[ -f /etc/arch-release ]] && _isarch=true

_isdebian=false
[[ -f /usr/bin/lsb_release ]] && _isdebian=true

_isxrunning=false
[[ -n "$DISPLAY" ]] && _isxrunning=true

_isroot=false
[[ $UID -eq 0 ]] && _isroot=true

export XDG_USER_CONFIG_DIR='$HOME/.config'


# -------------------------------------------------------------
#  Terminal Colors (WIP)
# -------------------------------------------------------------
  if $_isxrunning; then
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    if $_isroot; then
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
    fi
  fi


# -------------------------------------------------------------
#  Bash options
# -------------------------------------------------------------
  shopt -s cdspell                 # Correct cd typos
  shopt -s checkwinsize            # Update windows size on command
  shopt -s histappend              # Append History instead of overwriting file
  shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
  shopt -s extglob                 # Extended pattern
  shopt -s no_empty_cmd_completion # No empty completion

  complete -cf sudo

  if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi

  if [[ -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
  fi

  if [[ -d "/usr/lib/jvm/java-8-openjdk-amd64/" ]]; then
    export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
  fi

  if [[ -d "/opt/maven" ]]; then
    export MAVEN_HOME="/opt/maven"
  fi
  
  if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    PATH="$PATH:$GOPATH/bin"
  fi

# BASH COMPLETION 
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
   fi
  fi

# ANDROID SDK
  if [[ -d "/opt/android-sdk" ]]; then
    export ANDROID_HOME=/opt/android-sdk
    export ANDROID_SDK_ROOT=$ANDROID_HOME
    export ANDROID_AVD_HOME=$HOME/.android/avd
  fi

# EDITOR
  if command -v "vim" > /dev/null 2>&1; then
    export EDITOR="vim"
  else
    export EDITOR="nano"
  fi

# TERMINAL
  if command -v "i3" > /dev/null 2>&1; then
    export TERMINAL=$(which st)
  fi


# BASH HISTORY
# make multiple shells share the same history file
  export HISTSIZE=100000          # bash history will save N commands
  export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
  export HISTCONTROL='erasedups:ignoreboth'   # ingore duplicates and spaces
  export HISTIGNORE='&:[ ]*:ls:ll:la:cd:exit:clear:history'

#COLORED MANUAL PAGES
# @see http://www.tuxarena.com/?p=508
# For colourful man pages (CLUG-Wiki style)
  if $_isxrunning; then
    export PAGER=less
    export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinkingponytai
    export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'           # end mode
    export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
    export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
    export LESS_TERMCAP_ue=$'\E[0m'           # end underline
    export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
  fi


# -------------------------------------------------------------
#  Aliases
# -------------------------------------------------------------
  alias freemem='sudo /sbin/sysctl -w vm.drop_caches=3'

# AUTOCOLOR
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

# MODIFIED COMMANDS
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias df='df -h'
  alias diff='colordiff'              # requires colordiff package
  alias du='du -c -h'
  alias free='free -m'                # show sizes in MB
  alias grep='grep --color=auto'
  alias grep='grep --color=tty -d skip'
  alias mkdir='mkdir -p -v'
  alias more='less'
  alias nano='nano -w'
  alias ping='ping -c 5'

  alias l='ls -ahl'
  alias ls='ls -hF --color=auto'
  alias lr='ls -R'                    # recursive ls
  alias ll='ls -alh'
  alias la='ll -A'
  alias lm='la | less'

  alias 000='chmod -R 000'
  alias 644='chmod -R 644'
  alias 666='chmod -R 666'
  alias 755='chmod -R 755'
  alias 777='chmod -R 777'

# TOOLS
# https://github.com/junegunn/fzf-bin/releases
  if command -v "bat" > /dev/null 2>&1; then
    alias cat='bat'
  fi

  if command -v "ranger" > /dev/null 2>&1; then
    alias r='ranger'
  fi

  if command -v "stterm" > /dev/null 2>&1; then
    alias st='stterm'
  fi

  if command -v "prettyping" > /dev/null 2>&1; then
    alias ping='prettyping --nolegend'
  fi
  
  if command -v "ncdu" > /dev/null 2>&1; then
    alias du='ncdu'
  fi

  if command -v "get_flash_videos" > /dev/null 2>&1; then
      alias gfv='get_flash_videos -r 720p --subtitles'
  fi

  if command -v "docker" > /dev/null 2>&1; then
    alias d='docker'
  fi

  if command -v "kubectl" > /dev/null 2>&1; then
    source <(kubectl completion bash)
  fi

  if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
  fi

# PACKAGE MANAGER-
  if ! $_isroot; then
    alias reboot='sudo reboot'
  fi

  if $_isarch; then
    if ! $_isroot; then
      alias pacman='sudo pacman'
    fi
    alias pacupg='pacman -Syu'            # Synchronize with repositories and then upgrade packages that are out of date on the local system.
    alias pacupd='pacman -Sy'             # Refresh of all package lists after updating /etc/pacman.d/mirrorlist
    alias pacin='pacman -S'               # Install specific package(s) from the repositories
    alias pacinu='pacman -U'              # Install specific local package(s)
    alias pacre='pacman -R'               # Remove the specified package(s), retaining its configuration(s) and required dependencies
    alias pacun='pacman -Rcsn'            # Remove the specified package(s), its configuration(s) and unneeded dependencies
    alias pacinfo='pacman -Si'            # Display information about a given package in the repositories
    alias pacse='pacman -Ss'              # Search for package(s) in the repositories

    alias pacupa='pacman -Sy && sudo abs' # Update and refresh the local package and ABS databases against repositories
    alias pacind='pacman -S --asdeps'     # Install given package(s) as dependencies of another package
    alias pacclean="pacman -Sc"           # Delete all not currently installed package files
    alias pacmake="makepkg -fcsi"         # Make package from PKGBUILD file in current directory
  fi
  if $_isdebian; then
    if ! $_isroot; then
      alias apt='sudo apt'
      alias apt-get='sudo apt-get'
      alias upnclean='apt update && apt upgrade && apt autoremove && apt autoclean'
    fi
  fi


# -------------------------------------------------------------
#  Functions
# -------------------------------------------------------------
# TOP 10 COMMANDS
# copyright 2007 - 2010 Christopher Bratusek
  top10() { history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}' | sort -rn | head; }

# ARCHIVE EXTRACTOR
  extract() {
    clrstart="\033[1;34m"  #color codes
    clrend="\033[0m"

    if [[ "$#" -lt 1 ]]; then
      echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
      exit 1 #not enough args
    fi

    if [[ ! -e "$1" ]]; then
      echo -e "${clrstart}File does not exist!${clrend}"
      exit 2 #file not found
    fi

    if [[ -z "$2" ]]; then
      DESTDIR="." #set destdir to current dir
    elif [[ ! -d "$2" ]]; then
      echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
      read response
      #echo -e "\n"
      if [[ $response == y || $response == Y ]]; then
        mkdir -p "$2"
        if [ $? -eq 0 ]; then
          DESTDIR="$2"
        else
          exit 6 #Write perms error
        fi
      else
        echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
      fi
    else
      DESTDIR="$2"
    fi

    if [[ ! -z "$3" ]]; then
      if [[ "$3" != "v" ]]; then
        echo -e "${clrstart}Wrong argument $3 !${clrend}"
        exit 4 #wrong arg 3
      fi
    fi

    filename=`basename "$1"`

    #echo "${filename##*.}" debug

    case "${filename##*.}" in
      tar)
        echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
        tar x${3}f "$1" -C "$DESTDIR"
        ;;
      gz)
        echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
        tar x${3}fz "$1" -C "$DESTDIR"
        ;;
      tgz)
        echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
        tar x${3}fz "$1" -C "$DESTDIR"
        ;;
      xz)
        echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
        tar x${3}f -J "$1" -C "$DESTDIR"
        ;;
      bz2)
        echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
        tar x${3}fj "$1" -C "$DESTDIR"
        ;;
      zip)
        echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
        unzip "$1" -d "$DESTDIR"
        ;;
      rar)
        echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
        unrar x "$1" "$DESTDIR"
        ;;
      7z)
        echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
        7za e "$1" -o"$DESTDIR"
        ;;
      *)
        echo -e "${clrstart}Unknown archieve format!"
        exit 5
        ;;
    esac
  }

# ARCHIVE COMPRESS
  compress() {
    if [[ -n "$1" ]]; then
      FILE=$1
      case $FILE in
      *.tar ) shift && tar cf $FILE $* ;;
  *.tar.bz2 ) shift && tar cjf $FILE $* ;;
   *.tar.gz ) shift && tar czf $FILE $* ;;
      *.tgz ) shift && tar czf $FILE $* ;;
      *.zip ) shift && zip $FILE $* ;;
      *.rar ) shift && rar $FILE $* ;;
      esac
    else
      echo "usage: compress <foo.tar.gz> ./foo ./bar"
    fi
  }

# CONVERT TO ISO
  to_iso () {
    if [[ $# == 0 || $1 == "--help" || $1 == "-h" ]]; then
      echo -e "Converts raw, bin, cue, ccd, img, mdf, nrg cd/dvd image files to ISO image file.\nUsage: to_iso file1 file2..."
    fi
    for i in $*; do
      if [[ ! -f "$i" ]]; then
        echo "'$i' is not a valid file; jumping it"
      else
        echo -n "converting $i..."
        OUT=`echo $i | cut -d '.' -f 1`
        case $i in
              *.raw ) bchunk -v $i $OUT.iso;; #raw=bin #*.cue #*.bin
        *.bin|*.cue ) bin2iso $i $OUT.iso;;
        *.ccd|*.img ) ccd2iso $i $OUT.iso;; #Clone CD images
              *.mdf ) mdf2iso $i $OUT.iso;; #Alcohol images
              *.nrg ) nrg2iso $i $OUT.iso;; #nero images
                  * ) echo "to_iso don't know de extension of '$i'";;
        esac
        if [[ $? != 0 ]]; then
          echo -e "${R}ERROR!${W}"
        else
          echo -e "${G}done!${W}"
        fi
      fi
    done
  }

# REMIND ME, ITS IMPORTANT!
# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
  remindme() { sleep $1 && zenity --info --text "$2" & }

# SIMPLE CALCULATOR 
  # usage: calc <equation>
  calc() {
    if which bc &>/dev/null; then
      echo "scale=3; $*" | bc -l
    else
      awk "BEGIN { print $* }"
    fi
  }

# SYSTEMD SUPPORT
  if which systemctl &>/dev/null; then
    start() {
      sudo systemctl start $1.service
    }
    restart() {
      sudo systemctl restart $1.service
    }
    stop() {
      sudo systemctl stop $1.service
    }
    enable() {
      sudo systemctl enable $1.service
    }
    status() {
      sudo systemctl status $1.service
    }
    disable() {
      sudo systemctl disable $1.service
    }
  fi


# FILE & STRINGS RELATED FUNCTIONS
## FIND A FILE WITH A PATTERN IN NAME
  ff() { find . -type f -iname '*'$*'*' -ls ; }
    
## FIND A FILE WITH PATTERN $1 IN NAME AND EXECUTE $2 ON IT
  fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

## SWAP 2 FILENAMES AROUND, IF THEY EXIST
#(from Uzi's bashrc).
  swap() {
    local TMPFILE=tmp.$$

    [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
    [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
    [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
  }

## FINDS DIRECTORY SIZES AND LISTS THEM FOR THE CURRENT DIRECTORY
  dirsize () {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
  }

## FIND AND REMOVED EMPTY DIRECTORIES
  fared() {
    read -p "Delete all empty folders recursively [y/N]: " OPT
    [[ $OPT == y ]] && find . -type d -empty -exec rm -fr {} \; &> /dev/null
  }

## FIND AND REMOVED ALL DOTFILES
  farad () {
    read -p "Delete all dotfiles recursively [y/N]: " OPT
    [[ $OPT == y ]] && find . -name '.*' -type f -exec rm -rf {} \;
  }
