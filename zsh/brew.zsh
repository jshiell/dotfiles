if [[ -d /opt/X11/bin ]]; then
    export PATH="/opt/X11/bin:$PATH"
fi

if [[ "$(uname -p)" == 'arm' ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
else
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

if [[ -d "/usr/local/opt/imagemagick@6" ]]; then
    export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/imagemagick@6/lib"
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/imagemagick@6/include"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/imagemagick@6/lib/pkgconfig"
    export MAGICK_HOME="/usr/local/opt/imagemagick@6"
fi

if bat --version >/dev/null 2>&1; then
    alias cat=bat
fi

if prettyping --help >/dev/null 2>&1; then
    alias ping='prettyping --nolegend'
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications --prefpanedir=/Library/PreferencePanes"
