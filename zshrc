if [[ "$(uname -a)" =~ "Microsoft" ]]; then # see https://github.com/Microsoft/WSL/issues/1838
    unsetopt BG_NICE
fi

SOURCE="${(%):-%N}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

ZSHRC_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"

autoload zmv

export PATH="$HOME/bin:$PATH"

. $ZSHRC_DIR/zsh/brew
. $ZSHRC_DIR/zsh/cloudfoundry
. $ZSHRC_DIR/zsh/nix
. $ZSHRC_DIR/zsh/editor
. $ZSHRC_DIR/zsh/gpg
. $ZSHRC_DIR/zsh/golang
. $ZSHRC_DIR/zsh/iterm
. $ZSHRC_DIR/zsh/java
. $ZSHRC_DIR/zsh/nvm
. $ZSHRC_DIR/zsh/python
. $ZSHRC_DIR/zsh/ruby

. "$ZSHRC_DIR/zsh/antigen"

# Fix slow Git completion
__git_files () {
    _wanted files expl 'local files' _files
}

# Specific environments
. $ZSHRC_DIR/zsh/springernature

. $ZSHRC_DIR/zsh/autoenv # must be last as it arses about with cd
