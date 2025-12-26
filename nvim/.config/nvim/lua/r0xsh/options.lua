local p = require('r0xsh.modules.profile')

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
vim.opt.title = true
-- vim.opt.cmdheight = 0
vim.opt.winborder = 'single'

-- Mouse & Clipboard
vim.opt.mouse = 'a'

vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Indentation & Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.wrap = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Splits & Windows
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.diffopt:append { 'vertical', 'iwhite' }

-- Timing
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

-- Files & Undo
vim.opt.undofile = true
vim.opt.confirm = true

-- Misc
vim.opt.belloff = 'all'
vim.opt.shell = p.config.shell
