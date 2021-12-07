lazy_load_nvm() {
    unset -f node
    unset -f npm
    unset -f nvm
    if [[ -f /usr/local/opt/nvm/nvm.sh ]]; then
        NVM_HOME_DIR="/usr/local/opt/nvm"
    elif [[ -f $HOME/.nvm/nvm.sh ]]; then
        NVM_HOME_DIR="$HOME/.nvm"
    fi

    if [[ -n "$NVM_HOME_DIR" ]]; then
        export NVM_DIR="$HOME/.nvm"
        [[ ! -d "$NVM_DIR" ]] && mkdir "$NVM_DIR"
        setopt no_aliases
        . "$NVM_HOME_DIR/nvm.sh"
        setopt aliases
    fi
}

node() {
    lazy_load_nvm
    node $@
}

npm() {
    lazy_load_nvm
    npm $@
}

nvm() {
    lazy_load_nvm
    nvm $@
}