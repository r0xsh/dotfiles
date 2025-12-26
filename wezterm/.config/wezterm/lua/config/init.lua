local wezterm = require('wezterm')

local M = {}

function M.load(...)
    local config = {}

    for i, options in ipairs { ... } do
        wezterm.log_warn('Config type:', i, type(options), tostring(options))
        for k, v in pairs(options) do
            if config[k] ~= nil then
                wezterm.log_warn(
                    string.format(
                        'Duplicate config option detected: %s. Using old value: %s, ignoring: %s',
                        k,
                        tostring(config[k]),
                        tostring(v)
                    )
                )
                goto continue
            end
            config[k] = v
            ::continue::
        end
    end
    return config
end

return M
