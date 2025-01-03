#######################################################
####### Anarchy ZSH configuration file    #######
#######################################################

. $HOME/.profile

### Set/unset ZSH options
#########################
# setopt NOHUP
# setopt NOTIFY
# setopt NO_FLOW_CONTROL
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME
unsetopt BG_NICE
setopt CORRECT
setopt EXTENDED_HISTORY
# setopt HASH_CMDS
setopt MENUCOMPLETE
setopt ALL_EXPORT

### Set/unset  shell options
############################
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

### Autoload zsh modules when they are referenced
#################################################
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

### Set variables
#################
HISTFILE="$HOME/.zhistory"
HISTSIZE=20000
SAVEHIST=20000
HOSTNAME="$(hostname)"
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

### Load colors
###############
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done

### Set Colors to use in in the script
#############
# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

### Set prompt
##############
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="[%(!.${PR_RED}%n.$PR_LIGHT_YELLOW%n)%(!.${PR_LIGHT_YELLOW}@.$PR_RED@)$PR_NO_COLOR%(!.${PR_LIGHT_RED}%U%m%u.${PR_LIGHT_GREEN}%U%m%u)$PR_NO_COLOR:%(!.${PR_RED}%2c.${PR_BLUE}%2c)$PR_NO_COLOR]%(?..[${PR_LIGHT_RED}%?$PR_NO_COLOR])%(!.${PR_LIGHT_RED}#.${PR_LIGHT_GREEN}$) "
RPS1="$PR_LIGHT_YELLOW(%D{%d-%m %H:%M})$PR_NO_COLOR"
unsetopt ALL_EXPORT

### set common functions
#############

function my_ip() # Get IP adress.
{
   curl ifconfig.co
}

# Find a file with a pattern in name:
function ff()
{
    find . -type f -iname '*'"$*"'*' -ls ;
}



function sysinfo()   # Get current host related info.
{
    echo -e "\n${BRed}System Informations:$NC " ; uname -a
    echo -e "\n${BRed}Online User:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Date :$NC " ; date
    echo -e "\n${BRed}Server stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Public IP Address :$NC " ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo -e "\n${BRed}CPU info :$NC "; cat /proc/cpuinfo ;
    echo -e "\n"
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function prof(){
	psrecord "$1" --interval $2 --plot $1.png
}

# C++ valgrind
function cval {
	file="${1}"
	shift
	"${CC:-g++}" -o "${file%.*}" "${file}" && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all "${file%.*}" ${@}
}
function cvval {
	file="${1}"
	shift
	"${CC:-g++}" -o "${file%.*}" "${file}" && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -v "${file%.*}" ${@}
}

mcd () {
	mkdir -p $1
	cd $1
}

### Set alias
#############
alias cls="clear"
alias ..="cd .."
alias cd..="cd .."
alias ll="ls -lisa --color=auto"
alias home="cd ~"
alias df="df -ahT --total"
alias mkdir="mkdir -pv"
alias mkfile="touch"
alias rm="rm -rfi"
alias userlist="cut -d: -f1 /etc/passwd"
alias ls="ls -CF --color=auto"
alias lsl="ls -lhFA | less"
alias free="free -mt"
alias du="du -ach | sort -h"
alias ps="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias wget="wget -c"
alias histg="history | grep"
alias myip="curl http://ipecho.net/plain; echo"
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias grep='grep --color=auto'
alias dexit='disown && exit'
alias pdb='python -m pdb'
alias usbovi='cd /run/media/$USER/'
alias pcmanfm='devour pcmanfm'
alias vlc='devour vlc'
alias mpv='devour mpv --hwdec=auto'
alias gparted='devour gparted'
alias zathura='devour zathura'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias ffpw='firefox --private-window'
alias ffpwd='devour firefox --private-window'
alias oni2='devour Onivim2-x86_64.AppImage -f'
alias lutris='WINEPREFIX="/home/nikola/Data/wine" lutris'

fpath+=($HOME/.local/share/zsh/functions/Completion)

### Bind keys
#############
autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
	'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
	'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
	'*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
	named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
	rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
	avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
	firebird gnats haldaemon hplip irc klog list man cupsys postfix\
	proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
	files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
	files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
	users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
	hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

### Source plugins
##################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $HOME/.cargo/env
# korona
set -o vi
source ~/.dotbare/dotbare.plugin.zsh
# alias config='/usr/bin/git --git-dir=$HOME/wm/tackice/ --work-tree=$HOME'

export GPG_TTY="$(tty)"
export EDITOR="vim"
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"

export CARP_DIR="/home/nikola/Documents/test2/Carp"

export NO_AT_BRIDGE=1
export _JAVA_AWT_WM_NONREPARENTING=1
# export LC_ALL="en_US.UTF-8"

# Dok ne popravim
# export LANGUAGE="sr_RS:en_US"

alias config=dotbare
alias reboot="sudo loginctl reboot"
alias shutdown="sudo loginctl poweroff"
alias vcb="xclip -i -selection clipboard -o | vim -c 'setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile' -"
alias srbija="echo \"\033[41m      \033[44m      \033[47m      \033[0m\""
alias ed="ed -vp:"
alias cnping="cnping -t Test"
alias packettracer="devour packettracer"
alias anmenu="anbox launch --package=org.anbox.appmgr --component=org.anbox.appmgr.AppViewActivity"
alias anrootless="anbox session-manager --rootless"
alias anspotify="anbox launch --action=android.intent.action.MAIN --package=com.spotify.music --component=com.spotify.music.MainActivity"
alias ansettings="anbox launch --action=android.intent.action.MAIN --package=com.android.settings --component=com.android.settings.Settings"
alias xterm="xterm -fa 'Monospace' -fs 14"
alias emacscl="emacsclient -c -a emacs"
alias emacscld="devour emacsclient -c -a emacs"
alias emacsclt="emacsclient -t -a ''"
alias freqs="cat ~/.zhistory | cut -c16- | sort | uniq -c | sort -rn | head -n30"
alias redshift-bgd="redshift-gtk -l44.7807:20.5003"
alias sudofail='faillock --reset --user $USER'
alias sudo="doas"
alias vimgit="vim -c Ghere"
alias vimwiki='vim -c VimwikiIndex'
alias sshartix="ssh nikolar@iso.artixlinux.org -p 65432"
alias urlencode="jq -sRr @uri"
alias ip='ip --color=auto'
alias pacman-ignore='pacman -Syu --ignore linux,linux-headers,linux-firmware,linux-firmware-whence,firefox'
alias github-otp='oathtool -b --totp "$(pass show totp/github.com/Minnerlas)"'
alias clangfmt='clang-format --style="{BasedOnStyle: LLVM, TabWidth: 4, IndentWidth: 4, UseTab: true, ColumnLimit: 80, BreakBeforeBinaryOperators: true}"'
alias figletrs='figlet -f banner.flf -C utf8.flc'
alias tmuxsz='tmux list-panes -F "#{pane_width}x#{pane_height}"'
alias prognoza='curl -H "Accept-Language: sr" wttr.in'
alias prognozav2='curl -H "Accept-Language: sr" v2.wttr.in'
alias 0x0st='xclip -sel c -o | curl -F"file=@-" 0x0.st'
alias formatc='indent -ut -linux -brf -o -'
alias skylead-vpn='sudo openvpn --config /etc/openvpn/client/client.conf'

alias victoria2="env WINEPREFIX=\"/home/nikola/Data/wine32\" WINEARCH=win32 wine explorer /desktop=vic2 ~/Data/wine32/drive_c/users/nikola/Documents/Victoria.II.v3.04.Inclu.ALL.DLC/victoria2.exe"

rcopy()  { xclip -sel c -out | ssh "$1" DISPLAY=:0 xsel -i -b }
rpaste() { ssh "$1" DISPLAY=:0 xclip -sel -c -out | xclip -sel c }

# xdg-ninja homedir scan

# export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"


# NOTE: WINEPREFIX="/home/nikola/Data/wine"
# NOTE: WINEPREFIX="/home/nikola/Data/wine32" WINEARCH=win32
# NOTE sfm file manager
# NOTE за ограничавање броја језгара доступних процесу
#      $ taskset --cpu-list 0-4 ninja
# NOTE za conda ↓
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# NOTE: Test
export DEBUGINFOD_URLS=https://debuginfod.elfutils.org
export VAGRANT_HOME=/home/nikola/.local/share/vagrant

# opam configuration
# [ ! -r /home/nikola/.local/share/opam/opam-init/init.zsh ] || source /home/nikola/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# distcc сервер
# distccd --listen 0.0.0.0 --log-stderr --verbose --no-detach -a 0.0.0.0/0 -j12
# distcc клијент
# DISTCC_HOSTS=pin-server/6 127.0.0.1/12 PATH="/usr/lib/distcc:$PATH" make -j20 all
