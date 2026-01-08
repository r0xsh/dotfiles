local utils = require('r0xsh.modules.utils')
---@type vim.lsp.Config
return {
    cmd = utils.lspmux_cmd_fallback { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' },
    workspace_required = true,
    init_options = {
        lspMux = {
            version = '1',
            method = 'connect',
            server = 'phpactor',
            args = { 'language-server' },
            env = {
                PATH = vim.env.PATH,
            },
        },
        ['language_server_worse_reflection.inlay_hints.enable'] = false,
        ['language_server_highlight.enabled'] = false,
        ['language_server_psalm.enabled'] = false,
        ['language_server_psalm.bin'] = vim.fn.exepath('psalm'),
    },
}
