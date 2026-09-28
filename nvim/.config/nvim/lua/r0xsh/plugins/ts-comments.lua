local gh = require('r0xsh.modules.pack').gh

-- Treesitter aware `commentstring` (e.g. JSX inside JavaScript)
vim.pack.add { gh('folke/ts-comments.nvim') }
require('ts-comments').setup()
