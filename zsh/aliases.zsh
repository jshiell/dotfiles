if bat --version >/dev/null 2>&1; then
    alias cat=bat
elif batcat --version >/dev/null 2>&1; then
    alias cat=batcat
fi

if prettyping --help >/dev/null 2>&1; then
    alias ping='prettyping --nolegend'
fi
