return {
    {
        'webhooked/kanso.nvim',
        lazy = false,
        priority = 1000,
        -- build = ':KansoCompile',
        config = function()
            require('kanso').setup {
                -- compile = true,
                bold = true,
                italics = false,
                dimInactive = false,
                keywordStyle = { italic = false },
                background = {
                    dark = 'zen',
                    light = 'pearl',
                },
                foreground = {
                    dark = 'saturated',
                    light = 'saturated',
                },
            }
            vim.cmd.colorscheme('kanso')
        end,
    },
    {
        'EdenEast/nightfox.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'bluz71/vim-moonfly-colors',
        enabled = false,
        name = 'moonfly',
        lazy = false,
        priority = 1000,
    },
    {
        'aikhe/fleur.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
    },
}
