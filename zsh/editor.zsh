if which hx &>/dev/null; then
    export EDITOR='hx'
elif which vim &>/dev/null; then
	export EDITOR='vim'
elif which vi &>/dev/null; then
	echo "Warning: no vim, falling back to vi"
	export EDITOR='vi'
else
	echo "Warning: can't find hx, vim, or vi: where on earth are you?"
fi
