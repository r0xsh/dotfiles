---@brief
---
--- https://github.com/AJenbo/phpantom_lsp
---
--- Installation: https://github.com/AJenbo/phpantom_lsp/blob/main/docs/SETUP.md

local utils = require('r0xsh.modules.utils')
---@type vim.lsp.Config
return {
    cmd = utils.lspmux_cmd_fallback { 'phpantom_lsp' },
    filetypes = { 'php' },
    root_markers = { '.phpantom.toml', '.git', 'composer.json' },
    init_options = {
        lspMux = {
            version = '1',
            method = 'connect',
            server = 'phpantom_lsp',
            args = {},
            env = {
                PATH = vim.env.PATH,
            },
        },
    },
}