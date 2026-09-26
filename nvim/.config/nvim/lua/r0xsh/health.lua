local M = require('r0xsh.modules.utils')

local health = {}

local function lspmux_healthcheck()
    if not M.is_lspmux() then
        return false, 'lspmux socket not found: ' .. (M.socket or '$XDG_RUNTIME_DIR is not set')
    end

    -- `vim.lsp.rpc.connect()` only builds a factory, so open the socket for real
    local pipe = assert(vim.uv.new_pipe())
    local result ---@type string|false|nil
    pipe:connect(M.socket, function(err)
        result = err or false
    end)
    local done = vim.wait(1000, function()
        return result ~= nil
    end)
    pipe:close()

    if not done or result then
        return false, 'Failed to connect to lspmux socket: ' .. tostring(result or 'timeout')
    end

    return true, 'lspmux is running and healthy'
end

health.check = function()
    vim.health.start('lspmux')

    local ok, msg = lspmux_healthcheck()

    if ok then
        vim.health.ok(msg)
    else
        vim.health.error(msg)
        vim.health.info('Troubleshooting steps:')
        vim.health.info('1. Make sure lspmux is running.')
        vim.health.info('2. Verify that the socket exists at: ' .. (M.socket or 'unknown'))
        vim.health.info('3. Restart lspmux or Neovim if necessary.')
    end
end

return health
