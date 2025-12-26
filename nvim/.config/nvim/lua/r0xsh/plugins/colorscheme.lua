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
                dimInactive = true,
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
}
