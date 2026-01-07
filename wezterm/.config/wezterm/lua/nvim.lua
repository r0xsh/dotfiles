local wezterm = require('wezterm')
local act = wezterm.action
local M = {}

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

local function fingerprint(pane)
    local cursor = pane:get_cursor_position()
    return (cursor.x << 16) | cursor.y
end

local function forward_to_vim(win, pane, key)
    win:perform_action(act.SendKey { key = 'w', mods = 'CTRL' }, pane)
    win:perform_action(act.SendKey { key = key }, pane)
end

-- Helper function to handle the logic
function M.cmd_w_action(key, wezterm_action, use_fingerprint)
    return {
        key = key,
        mods = 'LEADER',
        action = wezterm.action_callback(function(win, pane)
            -- 1. Explicit Vim pane -> always forward
            if is_vim(pane) then
                forward_to_vim(win, pane, key)
                return
            end

            if not use_fingerprint then
                win:perform_action(wezterm_action, pane)
                return
            end

            -- 2. Try native action
            local before = fingerprint(pane)
            forward_to_vim(win, pane, key)

            -- 3. Sleep to let the app redraw
            wezterm.sleep_ms(120)

            -- 4. Fallback if cursor didn't move
            if before == fingerprint(pane) then
                win:perform_action(wezterm_action, pane)
            end
        end),
    }
end

return M
