local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'Gruvbox dark, medium (base16)'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0

-- Tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"


-- Leader key
config.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 1000
}

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '_',
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
        key = 'a',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = 'n',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendKey { key = 'n', mods = 'CTRL' },
    },
    {
        key = 'p',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
    },
}

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)



return config
