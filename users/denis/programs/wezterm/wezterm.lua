local wezterm = require('wezterm')

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right'
}

local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' }
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 1 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end)
  }
end

-- local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

local config = wezterm.config_builder()
-- smart_splits.apply_to_config(config)

config.color_scheme = 'One Half Black (Gogh)'
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.window_background_opacity = 0.9
config.initial_cols = 120
config.initial_rows = 24
config.font_size = 11.0
config.check_for_updates = false
config.exit_behavior = 'Close'
config.audible_bell = 'Disabled'

--TODO: Remove this temporary fix for square font in wezterm
-- config.front_end = 'WebGpu'

-- config.unix_domains = {
--   {
--     name = 'unix',
--   },
-- }
--
-- config.default_gui_startup_args = { 'connect', 'unix' }

config.window_padding = {
  left   = '0',
  right  = '0',
  top    = '0',
  bottom = '0'
}

config.use_resize_increments = true

config.tab_bar_at_bottom = true
-- config.window_close_confirmation = 'NeverPrompt'

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

-- config.key_map_preference = 'Physical'

config.use_fancy_tab_bar = false

config.keys = {
  -- move between split panes
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),

  { key = 'o', mods = 'LEADER', action = wezterm.action.RotatePanes 'Clockwise' },
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab('DefaultDomain') },
  {
    key = '\"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } }
  },
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } }
  },
  { key = 'L', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment },
  { key = 'K', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment }
}

return config

