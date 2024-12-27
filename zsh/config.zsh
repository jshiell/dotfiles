## History file configuration
[[ -z "$HISTFILE" ]] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

[[ "$(uname)" == "Darwin" ]] && setopt no_case_glob

WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
autoload -U edit-command-line
zle -N edit-command-line
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

setopt extended_history # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups # ignore duplicated commands history list
setopt hist_ignore_space # ignore commands that start with space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify # show command with history expansion to user before running it
setopt share_history # share command history data

bindkey '^R' history-incremental-search-backward

if [[ "$TERM_PROGRAM" != "WarpTerminal" && "$TERM_PROGRAM" != "ghostty" ]]; then
    # fuzzy find: start to type
    [[ -n "$terminfo[kcuu1]" ]] && bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
    [[ -n "$terminfo[kcud1]" ]] && bindkey "$terminfo[kcud1]" down-line-or-beginning-search
    [[ -n "$terminfo[cuu1]" ]] && bindkey "$terminfo[cuu1]" up-line-or-beginning-search
    [[ -n "$terminfo[cud1]" ]] && bindkey "$terminfo[cud1]" down-line-or-beginning-search
fi

# backward and forward word with option+left/right
bindkey '^[^[[D' backward-word
bindkey '^[b' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[f' forward-word

# to to the beggining/end of line with fn+left/right or home/end
[[ -n "$terminfo[khome]" ]] && bindkey "${terminfo[khome]}" beginning-of-line
bindkey '^[[H' beginning-of-line
[[ -n "$terminfo[kend]" ]] && bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[F' end-of-line

# delete char with backspaces and delete
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# edit current line in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
