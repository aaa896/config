local wezterm = require 'wezterm'
local act = wezterm.action
-- This table will hold the configuration.
local config = {}
local wezterm = require 'wezterm'

local config = {}


-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1
}
config.window_background_opacity = 1
config.enable_wayland = false;
--
-- This is where you actually apply your config choices
config.use_fancy_tab_bar=false
config.tab_bar_at_bottom = true
-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox dark, hard (base16)'
--
config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Noto Color Emoji',
}
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size=10.9
config.tab_max_width = 2
config.show_new_tab_button_in_tab_bar = false

config.colors = {

    cursor_bg = "#719b92",
    background="rgba(40,40,40,0.96)",
    foreground = '#ebdbb2',



  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
	--
    
    background="rgba(40,40,40,0.03)",
	active_tab = {
      	-- The color of the background area for the tab
      	bg_color = "rgba(40,40,40,0.03)",
      	-- The color of the text for the tab
      	fg_color = '#ebdbb2',
  	},
inactive_tab = {
  	bg_color = "rgba(40,40,40,0.03)",
  	fg_color = '#808080',

  	-- The same options that were listed under the `active_tab` section above
  	-- can also be used for `inactive_tab`.
	},


    
    },
ansi = {
	"1d2021",  -- base00
	"fb4934",  -- red
	"b8bb26",  -- green
	"fabd2f",  -- yellow
	"83a598",  -- blue
	"d3869b",  -- purple
	"8ec07c",  -- aqua/cyan
	"ebdbb2",  -- base06
},

brights = {
	"504945",  -- base02
	"fb4934",  -- red
	"89cc04",  -- string "color"
	"fabd2f",  -- yellow   linenumber and struct static
	"83a598",  -- blue
	"d3869b",  -- purple string
	"ebdbb2",  -- brackets
	"fbf1c7",  -- base07
},


    
  }


  --end colors
  config.keys = {
  -- activate pane selection mode with the default alphabet (labels are "a", "s", "d", "f" and so on)
  {
  	key = '2', mods = 'CTRL',
  	action = act.PaneSelect {
    	mode="MoveToNewTab",
  	},
  },
  -- activate pane selection mode with numeric labels
  {
	key = '1',
	mods = 'CTRL',
	action = act.PaneSelect {
  	--alphabet = '1234567890',
	mode = 'MoveToNewWindow',
	},
  },
  -- show the pane selection mode, but have it swap the active and selected panes
  {
	key = '3',
	mods = 'CTRL',
	action = act.PaneSelect {
  	mode="Activate",
	},
  },
  {
	key = '0',
	mods = 'CTRL',
	action = act.PaneSelect {
  	mode = 'SwapWithActiveKeepFocus',
	},
  },
  {

	key = 'x',

	mods = 'CTRL',

	action = wezterm.action.CloseCurrentPane { confirm = true },

  },

  {
      key = 'F5',
      action = wezterm.action.SpawnCommandInNewWindow {
          args = { 
--          '/bin/bash',        -- The shell program
 --         '-c',               -- Option to run a command string
          './r.sh', -- exec /bin/bash'  -- Command string: run the script and start a new shell
          },
      },
  },
}

-- and finally, return the configuration to wezterm
return config




