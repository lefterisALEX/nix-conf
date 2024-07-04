-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { "/Users/lefteris/.nix-profile/bin/tmux" }

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.colors = {
--   foreground = "#CBE0F0",
--   background = "#011423",
--   cursor_bg = "#47FF9C",
--   cursor_border = "#47FF9C",
--   cursor_fg = "#011423",
--   selection_bg = "#706b4e",
--   selection_fg = "#f3d9c4",
--   ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
--   brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

-- config.font = wezterm.font("Fira Code")
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
-- config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
config.font = wezterm.font("JetBrains Mono")

config.hide_mouse_cursor_when_typing = false

config.font_size = 12
config.initial_rows = 800
config.initial_cols = 800
config.enable_tab_bar = false
config.audible_bell = "Disabled"
config.scrollback_lines = 10000
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 8
config.keys = {
  -- This will create a new split and run your default program inside it
  {
    key = '"',
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
}

config.keys = {
  {
    key = "n",
    mods = "SHIFT|CTRL",
    action = wezterm.action.ToggleFullScreen,
  },
}

config.keys = {
  -- This will create a new split and run your default program inside it
  {
    key = ":",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
}
config.color_scheme = "Catppuccin Mocha"
-- and finally, return the configuration to wezterm
return config
