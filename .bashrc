# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias config='git --git-dir=/home/user/.cfg/ --work-tree=/home/user'
export QT_QPA_PLATFORMTHEME=qt5ct


eval "$(starship init bash)"

alias l="eza --icons=auto"
export TZ='America/Los_Angeles'

grep NAME=NixOS /etc/os-release > /dev/null
if [ $? != 0 ]; then
    # User specific environment
    if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
        PATH="$HOME/.local/bin:$HOME/bin:$PATH"
    fi
    export PATH

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

    export ANDROID_HOME=/home/user/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/build-tools/36.1.0:$ANDROID_HOME/cmdline-tools/latest/bin


    export PATH=$PATH:/usr/local/jdt/bin

    . "$HOME/.cargo/env"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/user/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/user/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/home/user/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="/home/user/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<


    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba shell init' !!
    export MAMBA_EXE='/home/user/miniforge3/bin/mamba';
    export MAMBA_ROOT_PREFIX='/home/user/miniforge3';
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
    fi
    unset __mamba_setup
    # <<< mamba initialize <<<

    export PATH="$PATH:/home/user/.risc0/bin"
fi
