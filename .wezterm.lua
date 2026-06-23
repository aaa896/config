-- Pull in the wezterm API
local wezterm = require 'wezterm'

local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()
config.term = 'wezterm'

config.enable_wayland = false


-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.colors = {
  -- The default text color
  foreground = '#111111',
  -- The default background color
  background = '#f2f2f2',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block

    cursor_bg = "#a99999",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = 'black',
    split = '#1c150b',

  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#f2f2f2',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#a1c4d0',
      -- The color of the text for the tab
      fg_color = '#444444',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

        new_tab = {
      bg_color = '#f2f2f2',
      fg_color = '#444444',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#f2f2f2',
      fg_color = '#444444',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },
},


  }
config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 1
}

config.font_size = 10
config.color_scheme = 'Papercolor Light (Gogh)'
config.tab_bar_at_bottom  = true
config.use_fancy_tab_bar  = false
config.font = wezterm.font 'Liberation Mono'
config.keys = {
  { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = true }, },

  { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
  { key = '@', mods = 'SHIFT|ALT', action = act.PaneSelect{mode ='MoveToNewTab',},},
  { key = '!', mods = 'SHIFT|ALT', action = act.PaneSelect{mode ='MoveToNewWindow',},},
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection('Left'), },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection('Down'), },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection('Up'), }, 
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection('Right'), },
  { key = 'H', mods = 'SHIFT|CTRL', action = act.Search { CaseInSensitiveString = 'hash' }, },

}
-- Finally, return the configuration to wezterm:

return config
