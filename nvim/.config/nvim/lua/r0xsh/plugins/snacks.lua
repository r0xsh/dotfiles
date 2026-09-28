local p = require('r0xsh.modules.profile').config
local gh = require('r0xsh.modules.pack').gh

vim.pack.add { gh('folke/snacks.nvim') }

require('snacks').setup {
    quickfile = { enabled = true },
    -- Highlight LSP references, jump between them with `<leader>n` / `<leader>p`
    words = { enabled = p.lsp.enabled },
}
