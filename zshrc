#!/bin/zsh

if [[ "$(uname -a)" =~ "Microsoft" ]]; then # see https://github.com/Microsoft/WSL/issues/1838
    unsetopt BG_NICE
fi

setopt PROMPT_SUBST # ensure prompt colours are evaluated

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups # ignore duplicated commands history list
setopt hist_ignore_space # ignore commands that start with space
setopt hist_verify # show command with history expansion to user before running it
setopt inc_append_history # add commands to HISTFILE in order of execution
setopt share_history # share command history data

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

for ZSH_CONFIG_FILE in ${ZSH_CONFIG_FILES}; do
  source "$ZSH_CONFIG_FILE"
done

# Fix slow Git completion
__git_files () {
    _wanted files expl 'local files' _files
}
