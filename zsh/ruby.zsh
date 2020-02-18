if [[ -d "$HOME/.rbenv" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
elif [[ -d "/usr/local/var/rbenv" ]]; then # Homebrew 
	export RBENV_ROOT=/usr/local/var/rbenv
	eval "$(rbenv init -)"
elif [[ -d "$HOME/.rvm" ]]; then
    source $HOME/.rvm/scripts/rvm
    export PATH="$PATH:$HOME/.rvm/bin"
fi