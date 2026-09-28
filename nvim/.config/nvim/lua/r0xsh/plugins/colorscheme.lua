local gh = require('r0xsh.modules.pack').gh

-- Alternatives:
--   gh('EdenEast/nightfox.nvim')
--   { src = gh('bluz71/vim-moonfly-colors'), name = 'moonfly' }
--   gh('aikhe/fleur.nvim')
vim.pack.add { gh('webhooked/kanso.nvim') }

require('kanso').setup {
    -- compile = true, -- then run `:KansoCompile` after each update
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
