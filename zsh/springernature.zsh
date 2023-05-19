if dockutil --version >/dev/null 2>&1; then
    if dockutil --list | grep "file:///Applications/SpringerNature%20HelpDesk.webloc" >/dev/null 2>&1; then
        dockutil --remove "file:///Applications/SpringerNature%20HelpDesk.webloc"
    fi
fi
