-- Install Lazy.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

local p = require('r0xsh.modules.profile')
p.setup()
require('r0xsh.options')
require('r0xsh.statusline')
require('r0xsh.commands')
require('r0xsh.autocmd')
require('r0xsh.keymaps')

if p.config.lsp.enabled then
    require('r0xsh.lsp')
end

-- Setup lazy.nvim
require('lazy').setup('r0xsh.plugins', {
    change_detection = { notify = false },
    rocks = { enabled = false },
    performance = {
        rtp = {
            disabled_plugins = {
                'rplugin',
                'tohtml',
                'tutor',
                'spellfile',
                'net',
            },
        },
    },
})
