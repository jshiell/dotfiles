ZNAP_RELEASE='main'
ZNAP_HOME="$HOME/.znap"
mkdir -p "$ZNAP_HOME"

zstyle ':znap:*' repos-dir "$ZNAP_HOME"
zstyle ':znap:*:*' git-maintenance off
zstyle ':znap:clone:*' default-server "git@github.com:"

if [[ ! -d "$ZNAP_HOME/zsh-snap" ]]; then
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git --branch "$ZNAP_RELEASE" "$ZNAP_HOME/zsh-snap"
fi

source "$ZNAP_HOME/zsh-snap/znap.zsh"

znap source ohmyzsh/ohmyzsh lib/theme-and-appearance lib/functions lib/termsupport

if ! starship --version >/dev/null 2>&1; then
    znap source jshiell/infernus-zsh-theme
fi

znap source ohmyzsh/ohmyzsh plugins/{common-aliases,colored-man-pages,git}

znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-completions

if profiles help >/dev/null 2>&1 && profiles show | grep SpringerNature >/dev/null 2>&1; then
    znap source springernature/sn-zsh-extensions
fi
