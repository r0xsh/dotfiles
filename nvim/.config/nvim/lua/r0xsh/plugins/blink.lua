local p = require('r0xsh.modules.profile').config

return {
    {
        'saghen/blink.cmp',
        build = p.lsp.enabled and 'cargo build --release' or false,
        event = 'InsertEnter',
        opts = function()
            local config = {
                appearance = { use_nvim_cmp_as_default = true },
                keymap = { preset = 'default' },
                completion = {
                    documentation = {
                        auto_show = true,
                        window = { border = 'single' },
                    },
                    list = {
                        max_items = 50,
                        selection = { preselect = false, auto_insert = false },
                    },
                    menu = {
                        scrollbar = false,
                        auto_show = true,
                        draw = {
                            columns = {
                                { 'kind_icon', 'label', 'label_description', gap = 1 },
                                { 'kind' },
                            },
                        },
                    },
                    ghost_text = { enabled = false },
                },
                sources = {
                    default = { 'path', 'buffer' },
                },
                fuzzy = { implementation = 'lua' },
                cmdline = { enabled = false },
            }

            if p.lsp.enabled then
                table.insert(config.sources.default, 1, 'lsp')
                config.signature = { enabled = true, trigger = { show_on_insert = true } }
                config.fuzzy.implementation = 'prefer_rust'
            end

            if p.enable_treesitter and p.lsp.enabled then
                config.completion.menu.draw.treesitter = { 'lsp' }
            end

            return config
        end,
    },
}
