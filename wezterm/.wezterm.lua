local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- font
config.font = wezterm.font("Monofur Nerd Font Mono", { weight = "Regular" })
config.font_size = 16.0

-- color scheme (One Dark に合わせる)
config.color_scheme = "One Dark (Gogh)"

-- window
config.window_background_opacity = 1.0
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.initial_cols = 220
config.initial_rows = 50

-- tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true

-- scrollback
config.scrollback_lines = 10000

-- shell
config.default_prog = { "powershell.exe", "-NoLogo" }

config.keys = {
  -- ペイン分割
  { key = "\\", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-",  mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "w",  mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

  -- ペイン移動 (WezTerm ペイン間のみ、nvim 内は nvim 側で処理)
  { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },

  -- タブ
  { key = "t",   mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "Tab", mods = "CTRL",       action = wezterm.action.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
}

return config
