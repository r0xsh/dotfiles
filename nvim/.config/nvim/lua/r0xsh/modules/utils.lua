local p = require('r0xsh.modules.profile').config

-- Utils
-- @module Utils
-- @alias M
local M = {}

-- `nil` when $XDG_RUNTIME_DIR is unset (containers, `env -i`, some ssh/su sessions)
M.socket = vim.env.XDG_RUNTIME_DIR and vim.fs.joinpath(vim.env.XDG_RUNTIME_DIR, 'lspmux.sock')

-- Return the path where Mason store the lsp binaries
-- @treturn string
function M.get_mason_bin_path()
    return vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin')
end

-- Check if the lspmux socket is present
-- @treturn boolean
function M.is_lspmux()
    local stat = M.socket and vim.uv.fs_stat(M.socket)
    return stat ~= nil and stat.type == 'socket'
end

-- Build the lsp `cmd` field: go through the lspmux rpc if present,
-- if not fallback to spawning `cmd` directly.
-- The check runs each time a server is spawned, not once when the config is loaded.
-- @treturn function
function M.lspmux_cmd_fallback(cmd)
    return function(dispatchers, config)
        if p.lsp.use_lspmux and M.is_lspmux() then
            return vim.lsp.rpc.connect(M.socket)(dispatchers)
        end

        if p.lsp.use_lspmux then
            vim.notify_once('lspmux socket not detected; falling back to direct LSP command', vim.log.levels.WARN)
        end

        -- Same spawn options Neovim uses for a plain `cmd` list
        return vim.lsp.rpc.start(cmd, dispatchers, {
            cwd = config.cmd_cwd or config.root_dir,
            env = config.cmd_env,
            detached = config.detached,
        })
    end
end

return M
