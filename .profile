source /etc/profile

export PATH="$HOME/.local/bin:$HOME/wm/skripte:$PATH"
# export PATH="$HOME/Documents/test2/go/goroot/bin:$PATH:$HOME/x86_64-gcc/bin/:$HOME/.emacs.d/bin:$HOME/arm-gcc/bin"
export PATH="$PATH:$HOME/x86_64-gcc/bin/:$HOME/.emacs.d/bin:$HOME/arm-gcc/bin"
# export PATH="$PATH:$HOME/.local/node_modules/bin"
# echo "PATH : $PATH"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export CALCHISTFILE="$XDG_CACHE_HOME/calc_history"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GDBHISTFILE="$XDG_DATA_HOME/gdb/history"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export _JAVA_OPTIONS=-Djavafx.cachedir="$XDG_CACHE_HOME/openjfx"
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
