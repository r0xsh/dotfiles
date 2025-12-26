local M = require('r0xsh.modules.utils')

local health = {}

local function lspmux_healthcheck()
    if not M.is_lspmux() then
        return false, 'lspmux socket not found: ' .. (M.socket or 'nil')
    end

    local ok, err = pcall(vim.lsp.rpc.connect, M.socket)
    if not ok then
        return false, 'Failed to connect to lspmux socket: ' .. tostring(err)
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
