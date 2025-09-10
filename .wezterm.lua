local wezterm = require 'wezterm'
local act = wezterm.action
-- This table will hold the configuration.
local config = {}
local wezterm = require 'wezterm'
 default_prog = {"/bin/bash"}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end
config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 1
}


-- Custom event to handle splitting with Neovim's working directory
wezterm.on('split_with_nvim_cwd', function(window, pane)
    -- Perform an action to get the working directory from Neovim
    window:perform_action(act.SendString('echo getcwd()\n'), pane)

    -- Split horizontally using the obtained cwd (simply adding the action for split)
    window:perform_action(act.SplitHorizontal { cwd = pane:get_current_working_dir() }, pane)
end)


config.window_background_opacity = 1
config.enable_tab_bar = false;
config.enable_wayland = true;
--
-- This is where you actually apply your config choices
config.use_fancy_tab_bar=false
config.tab_bar_at_bottom = true
---- For example, changing the color scheme:
config.color_scheme = 'Edge Dark (base16)'

warn_about_missing_glyphs=false
config.font = wezterm.font_with_fallback {
    'Liberation Mono',
    'JetBrainsMonoNL Nerd Font',
     'Noto Color Emoji',
}

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size=10.5
config.tab_max_width = 0
config.show_new_tab_button_in_tab_bar = false


config.window_frame = {
    font_size = 0.5,

}


config.colors = {
    --split = '#',

    cursor_bg = "#83a598",
    background="#945857",

    foreground = '#e0ac9d',



    tab_bar = {
        -- The color of the strip that goes along the top of the window
        -- (does not apply when fancy tab bar is in use)
        --

        background="#2e282a",
        active_tab = {
            -- The color of the background area for the tab
            bg_color = "#291f1e",
            -- The color of the text for the tab
            fg_color = '#e0ac9d',
        },
        inactive_tab = {
            bg_color = "#291f1e",
            fg_color = '#808080',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
        },



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

        key = 'w',

        mods = 'CTRL|SHIFT',

        action = wezterm.action.CloseCurrentPane { confirm = true },

    },

    {
        key = 'F5',
        action = wezterm.action_callback(function(window, pane)
            -- Read the path from /tmp/nvim_cwd
            local f = io.open("/tmp/nvim_cwd", "r")
            if f then
                local nvim_cwd = f:read("*all"):gsub("\n", "") -- Read and strip the newline
                f:close()

                -- Spawn a new window using the read path as the working directory
                window:perform_action(wezterm.action.SpawnCommandInNewWindow {
                    cwd = nvim_cwd,  -- Set the working directory
                    args = { './r.sh' },  -- Run the script
                }, pane)
            else
                -- Handle the case where the file doesn't exist or can't be read
                window:toast_notification("Error", "Could not read /tmp/nvim_cwd", nil, 5000)
            end
        end),
    },

    {
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection('Left'),
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection('Down'),
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection('Up'),
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivatePaneDirection('Right'),
    },

    {
        key = 'm',
        mods = 'ALT',
        action = wezterm.action_callback(function(window, pane)
            -- Read the path from /tmp/nvim_cwd
            local f = io.open("/tmp/nvim_cwd", "r")
            if f then
                local nvim_cwd = f:read("*all"):gsub("\n", "") -- Read and strip the newline
                f:close()

                -- Spawn a new window using the read path as the working directory
                window:perform_action(wezterm.action.SpawnCommandInNewWindow {
                    cwd = nvim_cwd,  -- Set the working directory
                    args = { './b.sh' },  -- Run the script
                }, pane)
            else
                -- Handle the case where the file doesn't exist or can't be read
                window:toast_notification("Error", "Could not read /tmp/nvim_cwd", nil, 5000)
            end
        end),
    },

    {
        key = 'm',
        mods = 'CTRL',
        action = wezterm.action.SpawnCommandInNewWindow {
            args = { 
                --          '/bin/bash',        -- The shell program
                --         '-c',               -- Option to run a command string
                './b.sh', -- exec /bin/bash'  -- Command string: run the script and start a new shell
            },
        },
    },

    {
        key = 'F5',
        mods = 'CTRL',
        action = wezterm.action.SpawnCommandInNewWindow {
            args = { 
                --          '/bin/bash',        -- The shell program
                --         '-c',               -- Option to run a command string
                './r.sh', -- exec /bin/bash'  -- Command string: run the script and start a new shell
            },
        },
    },

    {
        key = '%',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(function(window, pane)
            -- Read the path from /tmp/nvim_cwd
            local f = io.open("/tmp/nvim_cwd", "r")
            if f then
                local nvim_cwd = f:read("*all"):gsub("\n", "") -- Read and strip newline
                f:close()

                -- Split pane vertically using the read path as the working directory
                window:perform_action(wezterm.action.SplitPane {
                    direction = "Right",  -- Vertical split
                    command = {
                        args = { '/bin/bash' },  -- Open the shell in the new pane
                        cwd = nvim_cwd,  -- Set the working directory
                    },
                    top_level = false, -- Create a new top-level window for the command
                }, pane)
            else
                window:toast_notification("Error", "Could not read /tmp/nvim_cwd", nil, 5000)
            end
        end),
    },

    {
        key = '"',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(function(window, pane)
            -- Read the path from /tmp/nvim_cwd
            local f = io.open("/tmp/nvim_cwd", "r")
            if f then
                local nvim_cwd = f:read("*all"):gsub("\n", "") -- Read and strip newline
                f:close()

                -- Split pane horizontally using the read path as the working directory
                window:perform_action(wezterm.action.SplitPane {
                    direction = "Down",  -- Horizontal split
                    command = {
                        args = { '/bin/bash' },  -- Open the shell in the new pane
                        cwd = nvim_cwd,  -- Set the working directory
                    },
                    top_level = false, -- Create a new top-level window for the command
                }, pane)
            else
                window:toast_notification("Error", "Could not read /tmp/nvim_cwd", nil, 5000)
            end
        end),
    },


   -- Move tab left
    {
      key = "PageUp",
      mods = "CTRL|SHIFT",
      action = wezterm.action.MoveTabRelative(-1),
    },
    -- Move tab right
    {
      key = "PageDown",
      mods = "CTRL|SHIFT",
      action = wezterm.action.MoveTabRelative(1),
    },




}

-- and finally, return the configuration to wezterm
return config












