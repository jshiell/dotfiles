DOTFILES := $(shell pwd)

NONO_PROFILE_DIR := $(HOME)/.config/nono/profiles
NONO_PROFILES := $(notdir $(wildcard $(DOTFILES)/nono/profiles/*))

CLAUDE_AGENT_DIR := $(HOME)/.claude/agents
OPENCODE_AGENT_DIR := $(HOME)/.config/opencode/agents
AGENTS := $(notdir $(wildcard $(DOTFILES)/agents/agents/*))

CLAUDE_COMMAND_DIR := $(HOME)/.claude/commands
CLAUDE_COMMANDS := $(notdir $(wildcard $(DOTFILES)/agents/commands/*))

CLAUDE_SKILL_DIR := $(HOME)/.claude/skills
AGENTS_SKILL_DIR := $(HOME)/.agents/skills
SKILLS := $(notdir $(wildcard $(DOTFILES)/agents/skills/*))

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
	$(HOME)/.ssh/allowed_signers \
	$(addprefix $(NONO_PROFILE_DIR)/,$(NONO_PROFILES)) \
	$(addprefix $(CLAUDE_AGENT_DIR)/,$(AGENTS)) \
	$(addprefix $(OPENCODE_AGENT_DIR)/,$(AGENTS)) \
	$(addprefix $(CLAUDE_COMMAND_DIR)/,$(CLAUDE_COMMANDS)) \
	$(addprefix $(CLAUDE_SKILL_DIR)/,$(SKILLS)) \
	$(addprefix $(AGENTS_SKILL_DIR)/,$(SKILLS))

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
		if [ -L "$$link" ] && [ -e "$$link" ]; then \
			echo "  ok  $$link -> $$(readlink $$link)"; \
		elif [ -L "$$link" ]; then \
			echo "dead  $$link -> $$(readlink $$link) (target missing)"; \
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

$(HOME)/.ssh:
	mkdir -p $@

$(HOME)/.ssh/allowed_signers: | $(HOME)/.ssh
	ln -sfn $(DOTFILES)/allowed_signers $@

$(NONO_PROFILE_DIR):
	mkdir -p $@

$(NONO_PROFILE_DIR)/%: | $(NONO_PROFILE_DIR)
	ln -sfn $(DOTFILES)/nono/profiles/$* $@

$(HOME)/.config/opencode:
	mkdir -p $@

$(HOME)/.config/opencode/instructions.md: | $(HOME)/.config/opencode
	ln -sfn $(DOTFILES)/agents/instructions.md $@

$(HOME)/.claude:
	mkdir -p $@

$(HOME)/.claude/CLAUDE.md: | $(HOME)/.claude
	ln -sfn $(DOTFILES)/agents/instructions.md $@

$(CLAUDE_AGENT_DIR):
	mkdir -p $@

$(CLAUDE_AGENT_DIR)/%: | $(CLAUDE_AGENT_DIR)
	ln -sfn $(DOTFILES)/agents/agents/$* $@

$(OPENCODE_AGENT_DIR):
	mkdir -p $@

$(OPENCODE_AGENT_DIR)/%: | $(OPENCODE_AGENT_DIR)
	ln -sfn $(DOTFILES)/agents/agents/$* $@

$(CLAUDE_COMMAND_DIR):
	mkdir -p $@

$(CLAUDE_COMMAND_DIR)/%: | $(CLAUDE_COMMAND_DIR)
	ln -sfn $(DOTFILES)/agents/commands/$* $@

$(CLAUDE_SKILL_DIR):
	mkdir -p $@

$(CLAUDE_SKILL_DIR)/%: | $(CLAUDE_SKILL_DIR)
	ln -sfn $(DOTFILES)/agents/skills/$* $@

$(AGENTS_SKILL_DIR):
	mkdir -p $@

$(AGENTS_SKILL_DIR)/%: | $(AGENTS_SKILL_DIR)
	ln -sfn $(DOTFILES)/agents/skills/$* $@
