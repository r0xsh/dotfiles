local utils = require('r0xsh.modules.utils')
---@type vim.lsp.Config
return {
    cmd = utils.lspmux_cmd_fallback { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.emmyrc.json',
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    init_options = {
        lspMux = {
            version = '1',
            method = 'connect',
            server = 'lua-language-server',
            args = { '--stdio' },
            env = {
                PATH = vim.env.PATH,
            },
        },
    },
    settings = {
        Lua = {
            codeLens = { enable = false },
            format = { enable = false },
            hint = { enable = true, semicolon = 'Disable' },
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                },
            },
        },
    },
}
