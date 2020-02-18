if [[ "$(uname -a)" =~ "Microsoft" ]]; then # see https://github.com/Microsoft/WSL/issues/1838
    unsetopt BG_NICE
fi

setopt PROMPT_SUBST # ensure prompt colours are evaluated

SOURCE="${(%):-%N}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

ZSHRC_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"

autoload -U compinit && compinit # completion
autoload zmv # better mv
autoload colors && colors

export PATH="$HOME/bin:$PATH"

source $ZSHRC_DIR/zsh/brew
source $ZSHRC_DIR/zsh/nix
source $ZSHRC_DIR/zsh/editor
source $ZSHRC_DIR/zsh/gpg
source $ZSHRC_DIR/zsh/golang
source $ZSHRC_DIR/zsh/iterm
source $ZSHRC_DIR/zsh/java
source $ZSHRC_DIR/zsh/nvm
source $ZSHRC_DIR/zsh/python
source $ZSHRC_DIR/zsh/ruby

# source "$ZSHRC_DIR/zsh/antigen"
source "$ZSHRC_DIR/zsh/antibody"

# Fix slow Git completion
__git_files () {
    _wanted files expl 'local files' _files
}

# Specific environments
source $ZSHRC_DIR/zsh/springernature

source $ZSHRC_DIR/zsh/autoenv # must be last as it arses about with cd
