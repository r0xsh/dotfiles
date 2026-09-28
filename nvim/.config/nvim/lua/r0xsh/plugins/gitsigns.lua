local gh = require('r0xsh.modules.pack').gh

vim.pack.add { gh('lewis6991/gitsigns.nvim') }

require('gitsigns').setup {
    preview_config = { border = 'single' },
    current_line_blame = true,
}
