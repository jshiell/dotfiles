ZNAP_RELEASE='22.06.22'
ZNAP_HOME="$HOME/.znap"
mkdir -p "$ZNAP_HOME"

zstyle ':znap:*' repos-dir "$ZNAP_HOME"

if [[ ! -d "$ZNAP_HOME/zsh-snap" ]]; then
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git --branch "$ZNAP_RELEASE" "$ZNAP_HOME/zsh-snap"
fi

source "$ZNAP_HOME/zsh-snap/znap.zsh"

znap source ohmyzsh/ohmyzsh lib/theme-and-appearance
znap source jshiell/infernus-zsh-theme

znap source ohmyzsh/ohmyzsh plugins/{common-aliases,colored-man-pages,git}

znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-history-substring-search

znap source git@github.com:springernature/sn-zsh-extensions
