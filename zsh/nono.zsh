opencode() {
    NONO_OPENCODE_PROFILE=${NONO_OPENCODE_PROFILE:-always-further/opencode}

    if ! command opencode --version &>/dev/null; then
        echo "opencode is not installed" >&2
        return 1
    fi

    # start in a sandbox, if nono is available
    if nono --version &>/dev/null; then
        nono run --profile "$NONO_OPENCODE_PROFILE" \
            --allow-cwd \
            --allow "$HOME/.local/share/mise" \
            --allow "$HOME/.agents/skills" \
            -- opencode "$@"
    else
        echo "WARNING: nono is not available, running opencode without sandbox"
        command opencode "$@"
    fi
}

claude() {
    NONO_CLAUDE_PROFILE=${NONO_CLAUDE_PROFILE:-claude-code-local}

    if ! command claude --version &>/dev/null; then
        echo "claude is not installed" >&2
        return 1
    fi

    # start in a sandbox, if nono is available
    if nono --version &>/dev/null; then
        nono run --profile "$NONO_CLAUDE_PROFILE" \
            --allow-cwd \
            --allow "$HOME/.local/share/mise" \
            --allow "$HOME/.agents/skills" \
            -- claude "$@"
    else
        echo "WARNING: nono is not available, running claude without sandbox"
        command claude "$@"
    fi
}
