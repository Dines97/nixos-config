local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'Afterglow'
config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.window_background_opacity = 0.9
config.initial_cols = 140
config.initial_rows = 30
config.font_size = 15.0
config.check_for_updates = false
config.exit_behavior = 'Close'

config.unix_domains = {
  {
    name = 'unix'
  }
}

config.default_gui_startup_args = { 'connect', 'unix' }

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

config.tab_bar_at_bottom = true
config.window_close_confirmation = 'NeverPrompt'

config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe'
}

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }

config.key_map_preference = 'Physical'

config.use_fancy_tab_bar = false

config.keys = {
  { key = 'd',  mods = 'CTRL',         action = wezterm.action { CloseCurrentPane = { confirm = false } } },
  { key = 'c',  mods = 'LEADER',       action = wezterm.action.SpawnTab('DefaultDomain') },
  { key = '\"', mods = 'LEADER|SHIFT', action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } } },
  { key = '%',  mods = 'LEADER|SHIFT', action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } } }
}

return config
