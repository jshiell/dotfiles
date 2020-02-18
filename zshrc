#!/bin/zsh

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

typeset -U ZSH_CONFIG_FILES
ZSH_CONFIG_FILES=($ZSHRC_DIR/zsh/*.zsh)

for ZSH_CONFIG_FILE in ${ZSH_CONFIG_FILES:#*/autoenv.zsh}; do
  source "$ZSH_CONFIG_FILE"
done

# Fix slow Git completion
__git_files () {
    _wanted files expl 'local files' _files
}

source "$ZSHRC_DIR/zsh/autoenv.zsh" # must be last as it arses about with cd
