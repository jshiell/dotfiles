if ! antibody -v >/dev/null 2>&1 && brew -v >/dev/null 2>&1; then
    brew install getantibody/tap/Antibody
fi

ANTIBODY_PLUGINS_TEXT="$ZSHRC_DIR/antibody_plugins.txt"
ANTIBODY_PLUGINS_SH="$ZSHRC_DIR/antibody_plugins.sh"

if antibody -v >/dev/null 2>&1; then
    if [[ -f "$ANTIBODY_PLUGINS_SH" && "$ANTIBODY_PLUGINS_SH" -nt "$ANTIBODY_PLUGINS_TEXT" ]]; then
        source "$ANTIBODY_PLUGINS_SH"
    elif [[ -f "$ANTIBODY_PLUGINS_TEXT" ]]; then
        antibody bundle <"$ANTIBODY_PLUGINS_TEXT" >"$ANTIBODY_PLUGINS_SH"
        source "$ANTIBODY_PLUGINS_SH"
    else
        echo "No $ANTIBODY_PLUGINS_TEXT found; antibody will not be loaded"
    fi
else
    echo 'Antibody not found; please install manually'
fi
