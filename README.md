# DotFiles

Dot files. Oh, the dot files.

For a new Mac, try [the bootstrap](https://github.com/jshiell/mac-bootstrap).

## Architecture

### Bootstrap

Symlinking is handled either by the `Makefile` in this repo or by the separate [mac-bootstrap](https://github.com/jshiell/mac-bootstrap) Ansible project.

```
git clone git@github.com:jshiell/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

`make status` shows the current state of all managed symlinks. `make uninstall` removes them.

### Shell (Zsh)

`~/.zshrc` symlinks to `zsh/zshrc`, which resolves its own location through symlinks and then sources every `*.zsh` file in the same directory alphabetically. Each file is responsible for a single tool or concern:

| File | Purpose |
|---|---|
| `brew.zsh` | Homebrew path setup (Linux/Intel/ARM), `bat` and `prettyping` aliases |
| `config.zsh` | History, keybindings, completions |
| `editor.zsh` | Sets `$EDITOR` |
| `gpg.zsh` | Sets `GPG_TTY` for pinentry |
| `mise.zsh` | [mise](https://mise.jdx.dev/) polyglot version manager |
| `rustup.zsh` | Cargo `bin` path |
| `starship.zsh` | [Starship](https://starship.rs/) prompt init |
| `znap.zsh` | [Znap](https://github.com/marlonrichert/zsh-snap) plugin manager; loads ohmyzsh plugins and zsh-syntax-highlighting |
| `zoxide.zsh` | [zoxide](https://github.com/ajeetdsouza/zoxide) smart `cd` init |

### Prompt

Configured via `starship.toml` using the `gruvbox_dark` preset. Starship is initialised last, after the Znap/ohmyzsh stack, so it takes precedence over any ohmyzsh theme.

### Vim

`~/.vimrc` symlinks to `vim/vimrc` and `~/.vim` symlinks to `vim/`. Plugin management uses [Pathogen](https://github.com/tpope/vim-pathogen) (vendored in `vim/autoload/`) with plugins stored as git submodules in `vim/bundle/`:

- `vim-colors-solarized` — colour scheme
- `vim-airline` + `vim-airline-themes` — status bar
- `command-t` — fuzzy file finder

### Zed

`~/.config/zed` symlinks to `zed/`. Settings use the NeoSolarized theme (system-adaptive light/dark) with Monaspace Neon NF as the buffer font.

### Terminal

`~/.config/ghostty` symlinks to `ghostty/`. Font is Monaspace Neon NF.
