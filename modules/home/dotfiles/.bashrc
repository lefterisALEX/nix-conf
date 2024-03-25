# Define colors
RESET='\[\e[0m\]'
BLACK='\[\e[0;30m\]'
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'
BOLD='\[\e[1m\]'

# Custom prompt
PS1="${BOLD}${GREEN}\u${RESET}@${BOLD}${BLUE}\h${RESET}:${BOLD}${YELLOW}\w${RESET}\n\$ "

# Enable colorized ls output
alias ls='ls --color=auto'

# Aliases
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias cls='clear'
alias h='history'

# Functions
# Create a new directory and enter it
mkd() {
  mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xvjf "$1" ;;
      *.tar.gz) tar xvzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xvf "$1" ;;
      *.tbz2) tar xvjf "$1" ;;
      *.tgz) tar xvzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show disk usage for current directory
duf() {
  du -sh ./* | sort -h
}

# Print last modified files
lastmod() {
  ls -lt | head -n "$1"
}

# Print system information
sysinfo() {
  uname -a
  echo "Distribution: $(lsb_release -d | cut -f2)"
  echo "Kernel: $(uname -r)"
  echo "CPU: $(grep -m 1 'model name' /proc/cpuinfo | cut -d : -f2 | tr -s ' ')"
  echo "Memory: $(grep -m 1 'MemTotal' /proc/meminfo | awk '{print $2,$3}')"
  echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3,$5}')"
}

