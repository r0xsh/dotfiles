local wezterm = require('wezterm')
local act = wezterm.action
local M = {}

-- Clients whose remote side may run a vim that can't set IS_NVIM
local remote_clients = { ssh = true, ['mosh-client'] = true }

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

-- A remote vim is only a guess: a full-screen app under ssh/mosh.
-- A shell prompt is never on the alternate screen, so it never gets the keys.
local function maybe_remote_vim(pane)
    if not pane:is_alt_screen_active() then
        return false
    end
    local process = pane:get_foreground_process_name() or ''
    return remote_clients[process:match('[^/]*$')] == true
end

local function fingerprint(pane)
    local cursor = pane:get_cursor_position()
    return cursor.x .. ':' .. cursor.y
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

            -- 2. Shells, local TUIs, remote prompts -> native action, no keys sent
            if not maybe_remote_vim(pane) then
                win:perform_action(wezterm_action, pane)
                return
            end

            -- 3. Maybe vim over ssh -> forward, like a local vim
            if not use_fingerprint then
                forward_to_vim(win, pane, key)
                return
            end

            -- 4. Navigation: a remote vim can't hand off at its edges, so let it try first
            local before = fingerprint(pane)
            forward_to_vim(win, pane, key)

            -- 5. Sleep to let the app redraw (raise it if your ssh round trip is slower)
            wezterm.sleep_ms(120)

            -- 6. Fallback if cursor didn't move
            if before == fingerprint(pane) then
                win:perform_action(wezterm_action, pane)
            end
        end),
    }
end

return M
