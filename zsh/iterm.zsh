if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
	source "$HOME/.iterm2_shell_integration.zsh"
fi

ssh_cleanup() {
    echo -e "\033]50;SetProfile=Default\a"
}

ssh() {
    trap ssh_cleanup EXIT
    echo -e "\033]50;SetProfile=SSH\a"
    /usr/bin/ssh $@
}
