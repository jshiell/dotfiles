ANTIBODY=/usr/local/bin/antibody
if ! "$ANTIBODY" -v >/dev/null 2>&1; then
    if antibody -v  >/dev/null 2>&1; then
        ANTIBODY=antibody
    fi

    if ! "$ANTIBODY" -v >/dev/null 2>&1; then
        if brew -v >/dev/null 2>&1; then
            echo "Antibody not installed; installing from Brew..."
            brew install getantibody/tap/Antibody
        else
            echo "Antibody not installed; installing from GitHub..."
            curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
        fi
    fi
fi

ANTIBODY_PLUGINS_TEXT="$_ZSH_CONFIG_DIR/antibody_plugins.txt"
ANTIBODY_PLUGINS_SH="$_ZSH_CONFIG_DIR/antibody_plugins.sh"

if "$ANTIBODY" -v >/dev/null 2>&1; then
    if [[ -f "$ANTIBODY_PLUGINS_SH" && "$ANTIBODY_PLUGINS_SH" -nt "$ANTIBODY_PLUGINS_TEXT" ]]; then
        source "$ANTIBODY_PLUGINS_SH"
    elif [[ -f "$ANTIBODY_PLUGINS_TEXT" ]]; then
        "$ANTIBODY" bundle <"$ANTIBODY_PLUGINS_TEXT" >"$ANTIBODY_PLUGINS_SH"
        source "$ANTIBODY_PLUGINS_SH"
    else
        echo "No $ANTIBODY_PLUGINS_TEXT found; antibody will not be loaded"
    fi
else
    echo 'Antibody not found; please install manually'
fi
