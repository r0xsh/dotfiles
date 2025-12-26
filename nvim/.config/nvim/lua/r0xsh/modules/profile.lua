local default_config = {
    enable_treesitter = true,
    lsp = { enabled = true, use_lspmux = true },
    shell = 'zsh',
}

local profile_configs = {
    ['home_windows'] = {
        enable_treesitter = false,
        lsp = { enabled = false },
        shell = 'cmd.exe',
    },
    ['thinkpad'] = {
        lsp = { use_lspmux = false },
    },
}

local M = {}

M.profile = vim.env.NVIM_PROFILE
M.config = {}

function M.setup()
    local profile_config = profile_configs[M.profile] or {}
    M.config = vim.tbl_deep_extend('force', default_config, profile_config)
end

return M
