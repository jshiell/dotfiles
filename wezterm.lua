-- ln -sf ~/dotfiles/wezterm.lua ~/.wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'iTerm2 Solarized Dark'
config.font = wezterm.font("Inconsolata-g for Powerline")

config.initial_cols = 120
config.initial_rows = 40

config.scrollback_lines = 5000

config.enable_scroll_bar = true

-- borrowed from https://github.com/zapman449/dotfiles/blob/master/wezterm/.wezterm.lua#L22
config.keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key="LeftArrow",
        mods="OPT",
        action=wezterm.action{SendString="\x1bb"}
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key="RightArrow",
        mods="OPT",
        action=wezterm.action{SendString="\x1bf"}
    }
}

return config
