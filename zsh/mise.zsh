if [[ -f '/opt/homebrew/bin/mise' ]]; then
    eval "$(/opt/homebrew/bin/mise activate zsh)"
elif [[ -f "$HOME/.local/bin/mise" ]]; then
    eval "$($HOME/.local/bin/mise activate zsh)"
fi
