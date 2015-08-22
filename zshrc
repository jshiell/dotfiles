SOURCE="${(%):-%N}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

ZSHRC_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="norm"
ZSH_THEME="infernus"
DEFAULT_USER="jshiell"

# CASE_SENSITIVE="true" # case-sensitive completion
DISABLE_AUTO_UPDATE="true" # bi-weekly update checks
# export UPDATE_ZSH_DAYS=13 # auto-update delay
# DISABLE_LS_COLORS="true" # disable colours
# DISABLE_AUTO_TITLE="true" # auto updated title
COMPLETION_WAITING_DOTS="true" # display red dots while waiting for completion
ENABLE_CORRECTION="true"

autoload zmv

plugins=(brew bundler colored-man docker docker-compose git github gradle history-substring-search knife mvn osx rbenv ruby sublime sudo terminalapp tmux)

if [ $UID -eq 0 ]; then
    ZSH_ROOT=~jshiell
else
    ZSH_ROOT=$HOME
fi
if [[ -f "$ZSH_ROOT/Dropbox/etc/oh-my-zsh/oh-my-zsh.sh" ]]; then
    ZSH="$ZSH_ROOT/Dropbox/etc/oh-my-zsh"
elif [[ -f "$ZSH_ROOT/.oh-my-zsh/oh-my-zsh.sh" ]]; then
    ZSH="$ZSH_ROOT/.oh-my-zsh"
elif [[ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
    ZSH="$HOME/.oh-my-zsh"
else
    echo "WARNING! Can't find oh-my-zsh (tried $ZSH_ROOT/Dropbox/etc/oh-my-zsh; $ZSH_ROOT/.oh-my-zsh; $HOME/.oh-my-zsh)."
    echo "Please run: git clone git@github.com:jshiell/oh-my-zsh.git ~/.oh-my-zsh"
fi
if [[ -n "$ZSH" ]]; then
    source "$ZSH/oh-my-zsh.sh"
fi

# Override correction thanks to dot directories
alias knife='nocorrect knife'
alias docker='nocorrect docker'

# Fix slow Git completion
__git_files () {
    _wanted files expl 'local files' _files
}

export PATH="$HOME/bin:$PATH"

# Various bits & pieces
. $ZSHRC_DIR/zsh/brew
. $ZSHRC_DIR/zsh/cloudfoundry
. $ZSHRC_DIR/zsh/docker
. $ZSHRC_DIR/zsh/editor
. $ZSHRC_DIR/zsh/go
. $ZSHRC_DIR/zsh/iterm
. $ZSHRC_DIR/zsh/java
. $ZSHRC_DIR/zsh/maven
. $ZSHRC_DIR/zsh/ruby

# Specific environments
. $ZSHRC_DIR/zsh/springer

. $ZSHRC_DIR/zsh/autoenv # must be last as it arses about with cd

