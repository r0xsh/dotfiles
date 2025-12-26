local p = require('r0xsh.modules.profile').config

-- Utils
-- @module Utils
-- @alias M
local M = {}

M.socket = vim.env.XDG_RUNTIME_DIR .. '/lspmux.sock'

-- Return the path where Mason store the lsp binaries
-- @treturn string
function M.get_mason_bin_path()
    return vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin')
end

-- Check if the lspmux socket is present
-- @treturn boolean
function M.is_lspmux()
    local stat = vim.uv.fs_stat(M.socket)
    return stat and stat.type == 'socket'
end

-- Set the lsp `cmd` field with lspmux rpc if present,
-- if not fallback to default config
-- @treturn function|table
function M.lspmux_cmd_fallback(cmd)
    if p.lsp.use_lspmux and M.is_lspmux() then
        return vim.lsp.rpc.connect(M.socket)
    else
        if p.lsp.use_lspmux then
            vim.notify_once('lspmux socket not detected; falling back to direct LSP command', vim.log.levels.WARN)
        end
        return cmd
    end
end

return M
