if [[ -d /opt/X11/bin ]]; then
    export PATH="/opt/X11/bin:$PATH"
fi

HOMEBREW_BASE_PATH="/usr/local"
if [[ "$(uname -p)" == 'arm' ]]; then
    HOMEBREW_BASE_PATH="/opt/homebrew"
fi
export PATH="$HOMEBREW_BASE_PATH/bin:$HOMEBREW_BASE_PATH/sbin:$PATH"

if [[ -d "$HOMEBREW_BASE_PATH/opt/imagemagick@6" ]]; then
    export PATH="$HOMEBREW_BASE_PATH/opt/imagemagick@6/bin:$PATH"
    export LDFLAGS="$LDFLAGS -L$HOMEBREW_BASE_PATH/opt/imagemagick@6/lib"
    export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_BASE_PATH/opt/imagemagick@6/include"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_BASE_PATH/opt/imagemagick@6/lib/pkgconfig"
    export MAGICK_HOME="$HOMEBREW_BASE_PATH/opt/imagemagick@6"
fi

if bat --version >/dev/null 2>&1; then
    alias cat=bat
fi

if prettyping --help >/dev/null 2>&1; then
    alias ping='prettyping --nolegend'
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications --prefpanedir=/Library/PreferencePanes"
