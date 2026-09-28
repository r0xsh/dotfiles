-- Move between Neovim splits and WezTerm panes with the same keys
if not vim.env.WEZTERM_UNIX_SOCKET then
    return
end

local gh = require('r0xsh.modules.pack').gh

vim.pack.add { gh('mrjones2014/smart-splits.nvim') }

local splits = require('smart-splits')
vim.keymap.set('n', '<C-w>h', splits.move_cursor_left)
vim.keymap.set('n', '<C-w>j', splits.move_cursor_down)
vim.keymap.set('n', '<C-w>k', splits.move_cursor_up)
vim.keymap.set('n', '<C-w>l', splits.move_cursor_right)
vim.keymap.set('n', '<C-w><Left>', splits.move_cursor_left)
vim.keymap.set('n', '<C-w><Down>', splits.move_cursor_down)
vim.keymap.set('n', '<C-w><Up>', splits.move_cursor_up)
vim.keymap.set('n', '<C-w><Right>', splits.move_cursor_right)
