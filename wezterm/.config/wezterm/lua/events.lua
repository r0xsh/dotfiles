local wezterm = require('wezterm')

local S = {}

wezterm.on('update-right-status', function(window, pane)
    ---@diagnostic disable-next-line: unused-local
    local success, stdout, stderr =
        wezterm.run_child_process { 'sh', '-c', '~/.config/wezterm/status.sh' }
    if not success then
        -- TODO: log stderr
        return
    end

    window:set_right_status(wezterm.format {
        { Foreground = { Color = '#5C6066' } },
        { Text = stdout },
        'ResetAttributes',
        { Text = ' ' },
    })
end)

-- wezterm.on('window-resized', function(window)
--     local overrides = window:get_config_overrides() or {}
--     local is_fullscreen = window:get_dimensions().is_full_screen
--
--     if is_fullscreen then
--         overrides.window_decorations = 'NONE'
--     else
--         overrides.window_decorations = 'INTEGRATED_BUTTONS|TITLE'
--     end
--
--     window:set_config_overrides(overrides)
-- end)

-- wezterm.on('window-config-reloaded', function(window, pane)
--   window:toast_notification('wezterm', 'configuration reloaded!', nil, 4000)
-- end)

local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

wezterm.on('format-tab-title', function(tab)
    local title = tab_title(tab)
    local zoomed = ' '
    if tab.active_pane.is_zoomed then
        zoomed = ' ' .. wezterm.nerdfonts.md_fullscreen .. ' '
    end
    return zoomed .. title
end)
