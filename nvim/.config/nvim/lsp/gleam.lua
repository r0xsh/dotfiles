local utils = require('r0xsh.modules.utils')
---@type vim.lsp.Config
return {
    cmd = utils.lspmux_cmd_fallback { 'gleam', 'lsp' },
    filetypes = { 'gleam' },
    root_markers = { 'gleam.toml', '.git' },
    init_options = {
        lspMux = {
            version = '1',
            method = 'connect',
            server = 'gleam',
            args = { 'lsp' },
            env = {
                PATH = vim.env.PATH,
            },
        },
    },
}
