if [[ "$TERM_PROGRAM" == 'iTerm.app' ]]; then
	if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
		source "$HOME/.iterm2_shell_integration.zsh"
	fi

	ssh() {
		/usr/bin/ssh "$@"
		echo -ne "\033]0;$*\007"
	}
fi
