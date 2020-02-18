if [[ -f /usr/local/opt/nvm/nvm.sh ]]; then
    export NVM_DIR="$HOME/.nvm"

    if [[ ! -d "$NVM_DIR" ]]; then
        mkdir "$NVM_DIR"
    fi

    . "/usr/local/opt/nvm/nvm.sh"
elif [[ -f $HOME/.nvm/nvm.sh ]]; then
    export NVM_DIR="$HOME/.nvm"
    . "$HOME/.nvm/nvm.sh"
fi
