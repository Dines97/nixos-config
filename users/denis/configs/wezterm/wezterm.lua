return {
  color_scheme = 'Afterglow',
  font = wezterm.font('JetBrainsMono Nerd Font Mono'),
  window_background_opacity = 0.9,
  initial_cols = 140,
  initial_rows = 30,
  font_size = 15.0,
  check_for_updates = false,
  exit_behavior = 'Close',

  unix_domains = {
    {
      name = 'unix'
    }
  },

  default_gui_startup_args = { 'connect', 'unix' },

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },

  tab_bar_at_bottom = true,
  window_close_confirmation = 'NeverPrompt',

  skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
    'nu',
    'cmd.exe',
    'pwsh.exe',
    'powershell.exe'
  },

  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },

  key_map_preference = 'Physical',

  use_fancy_tab_bar = false,

  keys = {
    { key = 'd',  mods = 'CTRL',         action = wezterm.action { CloseCurrentPane = { confirm = false } } },
    { key = 'c',  mods = 'LEADER',       action = wezterm.action.SpawnTab('DefaultDomain') },
    { key = '\"', mods = 'LEADER|SHIFT', action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } } },
    { key = '%',  mods = 'LEADER|SHIFT', action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } } }
  }
}
