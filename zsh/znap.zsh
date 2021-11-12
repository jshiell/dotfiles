ZNAP_HOME="$HOME/.znap"

if [[ ! -d "$ZNAP_HOME" ]]; then
    mkdir -p "$ZNAP_HOME"
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git "$ZNAP_HOME"
fi

source "$ZNAP_HOME/znap.zsh"

znap source ohmyzsh/ohmyzsh lib/theme-and-appearance
znap source jshiell/infernus-zsh-theme

znap source ohmyzsh/ohmyzsh plugins/{common-aliases,colored-man-pages,git}

znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-history-substring-search

znap source git@github.com:springernature/sn-zsh-extensions
