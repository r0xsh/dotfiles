-- Imports
local wezterm = require('wezterm')
local act = wezterm.action

-- load custom nvim integration
local nvim = require('lua.nvim')

local keys = {
    {
        key = 'n',
        mods = 'SHIFT|CTRL',
        action = act.ToggleFullScreen,
    },
    {
        key = 's',
        mods = 'LEADER|CTRL',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'z',
        mods = 'LEADER|CTRL',
        action = act.SetPaneZoomState(true),
    },
    {
        key = '=',
        mods = 'LEADER|CTRL',
        action = act.SetPaneZoomState(false),
    },
    {
        key = 'v',
        mods = 'LEADER|CTRL',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'r',
        mods = 'SHIFT|CTRL',
        action = act.ReloadConfiguration,
    },
    {
        key = 't',
        mods = 'SHIFT|CTRL',
        action = act.SpawnTab('DefaultDomain'),
    },

    -- Copy/Paste
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },

    -- Scroll pane
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-0.75) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(0.75) },

    -- Navigation
    nvim.cmd_w_action('h', act.ActivatePaneDirection('Left')),
    nvim.cmd_w_action('j', act.ActivatePaneDirection('Down')),
    nvim.cmd_w_action('k', act.ActivatePaneDirection('Up')),
    nvim.cmd_w_action('l', act.ActivatePaneDirection('Right')),

    nvim.cmd_w_action('LeftArrow', act.ActivatePaneDirection('Left')),
    nvim.cmd_w_action('DownArrow', act.ActivatePaneDirection('Down')),
    nvim.cmd_w_action('UpArrow', act.ActivatePaneDirection('Up')),
    nvim.cmd_w_action('RightArrow', act.ActivatePaneDirection('Right')),

    -- Splitting
    nvim.cmd_w_action('s', act.SplitVertical { domain = 'CurrentPaneDomain' }),
    nvim.cmd_w_action('v', act.SplitHorizontal { domain = 'CurrentPaneDomain' }),

    -- Closing
    nvim.cmd_w_action('q', act.CloseCurrentPane { confirm = true }),
}

-- These keys don't have a WezTerm equivalent i want to use,
-- but they must be mapped so WezTerm forwards them to nvim.
local vim_window_commands = {
    '=', -- Resizing
    '+',
    '-',
    '_',
    '|',
    '<',
    '>', -- Rotating/Swapping
    'r',
    'R',
    'x', -- Only/Tab/Preview
    'o',
    't',
    'T',
    'p',
    'P',
    'z', -- zoom zoom
}

for _, key in ipairs(vim_window_commands) do
    table.insert(keys, nvim.cmd_w_action(key, act.Nop))
end

return {
    leader = { key = 'w', mods = 'CTRL', timeout_milliseconds = 1250 },
    keys = keys,
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'CTRL',
            action = act.OpenLinkAtMouseCursor,
        },
    },
}
