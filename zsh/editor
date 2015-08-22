if which vim >/dev/null 2>&1; then
	export EDITOR='vim'
elif which vi >/dev/null 2>&1; then
	echo "Warning: no vim, falling back to vi"
	export EDITOR='vi'
else
	echo "Warning: can't find vim or vi, where on earth are you?"
fi
