if [[ -f /usr/local/opt/nvm/nvm.sh ]]; then
    NVM_HOME_DIR="/usr/local/opt/nvm"
elif [[ -f $HOME/.nvm/nvm.sh ]]; then
    NVM_HOME_DIR="$HOME/.nvm"
fi

if [[ -n "$NVM_HOME_DIR" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [[ ! -d "$NVM_DIR" ]] && mkdir "$NVM_DIR"

    # all credit to https://www.growingwiththeweb.com/2018/01/slow-nvm-init.html
    declare -a __NODE_COMMANDS=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
    function __init_nvm() {
        for i in "${__NODE_COMMANDS[@]}"; do unalias $i; done
        . "$NVM_HOME_DIR/nvm.sh"
        unset __NODE_COMMANDS
        unset -f __init_nvm
    }
    for i in "${__NODE_COMMANDS[@]}"; do alias $i='__init_nvm && '$i; done
fi
