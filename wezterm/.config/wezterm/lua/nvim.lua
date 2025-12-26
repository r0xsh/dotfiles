local wezterm = require('wezterm')
local act = wezterm.action
local M = {}

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

-- Helper function to handle the logic
function M.cmd_w_action(key, wezterm_action, always_forward)
    return {
        key = key,
        mods = 'LEADER',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) or always_forward then
                -- Pass <C-w> followed by the key to Vim
                win:perform_action(act.SendKey { key = 'w', mods = 'CTRL' }, pane)
                win:perform_action(act.SendKey { key = key }, pane)
            else
                -- Perform the native WezTerm action
                win:perform_action(wezterm_action, pane)
            end
        end),
    }
end

return M
