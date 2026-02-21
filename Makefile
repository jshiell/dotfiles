DOTFILES := $(shell pwd)

HOME_LINKS := \
	$(HOME)/.curlrc \
	$(HOME)/.vim \
	$(HOME)/.vimrc \
	$(HOME)/.zshrc

CONFIG_LINKS := \
	$(HOME)/.config/ghostty \
	$(HOME)/.config/starship.toml \
	$(HOME)/.config/zed

.PHONY: install
install: $(HOME_LINKS) $(CONFIG_LINKS) ## Symlink all dotfiles into place
	@echo "Done."

.PHONY: uninstall
uninstall: ## Remove all managed symlinks
	@for link in $(HOME_LINKS) $(CONFIG_LINKS); do \
		if [ -L "$$link" ]; then \
			echo "Removing $$link"; \
			rm "$$link"; \
		fi \
	done
	@echo "Done."

.PHONY: status
status: ## Show the state of each managed symlink
	@for link in $(HOME_LINKS) $(CONFIG_LINKS); do \
		if [ -L "$$link" ]; then \
			echo "  ok  $$link -> $$(readlink $$link)"; \
		elif [ -e "$$link" ]; then \
			echo " err  $$link (exists but is not a symlink)"; \
		else \
			echo "miss  $$link"; \
		fi \
	done

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-12s %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

# --- Home directory links ---

$(HOME)/.curlrc:
	ln -s $(DOTFILES)/curlrc $@

$(HOME)/.vim:
	ln -s $(DOTFILES)/vim $@

$(HOME)/.vimrc:
	ln -s $(DOTFILES)/vim/vimrc $@

$(HOME)/.zshrc:
	ln -s $(DOTFILES)/zsh/zshrc $@

# --- ~/.config links ---

$(HOME)/.config:
	mkdir -p $@

$(HOME)/.config/ghostty: | $(HOME)/.config
	ln -s $(DOTFILES)/ghostty $@

$(HOME)/.config/starship.toml: | $(HOME)/.config
	ln -s $(DOTFILES)/starship.toml $@

$(HOME)/.config/zed: | $(HOME)/.config
	ln -s $(DOTFILES)/zed $@
