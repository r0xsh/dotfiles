local map = vim.keymap.set

map('n', '<c-z>', '<nop>', { desc = 'Disable suspend' })

map('n', '<C-w>z', function()
    vim.cmd('wincmd _ | wincmd |')
end, { desc = 'Maximize current window' })

-- NOTE: Disabled thoses binds since i'm using a mux
map('t', '<C-w>h', [[<C-\><C-n><C-w>h]], { desc = 'Move to left window' })
map('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { desc = 'Move to bottom window' })
map('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { desc = 'Move to top window' })
map('t', '<C-w>l', [[<C-\><C-n><C-w>l]], { desc = 'Move to right window' })
map('t', '<C-w>q', [[<C-\><C-n>:q!<CR>]], { desc = 'Force quit terminal' })
