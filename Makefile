DOTFILES := $(shell pwd)

LINKS := \
	$(HOME)/.curlrc \
	$(HOME)/.gitconfig \
	$(HOME)/.vim \
	$(HOME)/.vimrc \
	$(HOME)/.zshrc \
	$(HOME)/.claude/CLAUDE.md \
	$(HOME)/.config/ghostty \
	$(HOME)/.config/helix \
	$(HOME)/.config/starship.toml \
	$(HOME)/.config/zed \
	$(HOME)/.config/opencode/instructions.md \
	$(HOME)/.config/nono/profiles
	
.PHONY: install
install: $(LINKS) ## Symlink all dotfiles into place
	@echo "Done."

.PHONY: uninstall
uninstall: ## Remove all managed symlinks
	@for link in $(LINKS); do \
		if [ -L "$$link" ]; then \
			echo "Removing $$link"; \
			rm "$$link"; \
		fi \
	done
	@echo "Done."

.PHONY: status
status: ## Show the state of each managed symlink
	@for link in $(LINKS); do \
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

# --- Links ---

$(HOME)/.curlrc:
	ln -sfn $(DOTFILES)/curlrc $@

$(HOME)/.gitconfig:
	ln -sfn $(DOTFILES)/gitconfig $@
	
$(HOME)/.vim:
	ln -sfn $(DOTFILES)/vim $@

$(HOME)/.vimrc:
	ln -sfn $(DOTFILES)/vim/vimrc $@

$(HOME)/.zshrc:
	ln -sfn $(DOTFILES)/zsh/zshrc $@

$(HOME)/.config:
	mkdir -p $@

$(HOME)/.config/ghostty: | $(HOME)/.config
	ln -sfn $(DOTFILES)/ghostty $@

$(HOME)/.config/helix: | $(HOME)/.config
	ln -sfn $(DOTFILES)/helix $@

$(HOME)/.config/starship.toml: | $(HOME)/.config
	ln -sfn $(DOTFILES)/starship.toml $@

$(HOME)/.config/zed: | $(HOME)/.config
	ln -sfn $(DOTFILES)/zed $@

$(HOME)/.config/nono:
	mkdir -p $@

$(HOME)/.config/nono/profiles: | $(HOME)/.config/nono
	ln -sfn $(DOTFILES)/nono/profiles $@

$(HOME)/.config/opencode:
	mkdir -p $@

$(HOME)/.config/opencode/instructions.md: | $(HOME)/.config/opencode
	ln -sfn $(DOTFILES)/agents/instructions.md $@

$(HOME)/.claude:
	mkdir -p $@

$(HOME)/.claude/CLAUDE.md: | $(HOME)/.claude
	ln -sfn $(DOTFILES)/agents/instructions.md $@
