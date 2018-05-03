SOURCE="${(%):-%N}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

ZSHRC_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"

autoload zmv

. "$ZSHRC_DIR/zsh/antigen"

# Fix slow Git completion
__git_files () {
    _wanted files expl 'local files' _files
}

export PATH="$HOME/bin:$PATH"

# Various bits & pieces
. $ZSHRC_DIR/zsh/brew
. $ZSHRC_DIR/zsh/editor
. $ZSHRC_DIR/zsh/gpg
. $ZSHRC_DIR/zsh/golang
. $ZSHRC_DIR/zsh/iterm
. $ZSHRC_DIR/zsh/java
. $ZSHRC_DIR/zsh/nvm
. $ZSHRC_DIR/zsh/python
. $ZSHRC_DIR/zsh/ruby

# Specific environments
. $ZSHRC_DIR/zsh/springer

. $ZSHRC_DIR/zsh/autoenv # must be last as it arses about with cd

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

