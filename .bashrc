# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

alias c='git --git-dir=/home/user/.cfg/ --work-tree=/home/user'
export QT_QPA_PLATFORMTHEME=qt5ct

eval "$(starship init bash)"

alias ls="eza --icons=auto"
export TZ='America/Los_Angeles'

export EDITOR=kaks
