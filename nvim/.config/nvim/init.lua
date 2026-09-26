-- Byte-compile and cache Lua modules (lazy.nvim used to enable it)
vim.loader.enable()

-- Disable unused builtin plugins
vim.g.loaded_remote_plugins = 1 -- rplugin
vim.g.loaded_2html_plugin = 1 -- tohtml
vim.g.loaded_tutor_mode_plugin = 1 -- tutor
vim.g.loaded_spellfile_plugin = 1 -- spellfile
vim.g.loaded_nvim_net_plugin = 1 -- net

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

-- Plugins are managed by the builtin `vim.pack` (`:packupdate`, `:packdel`)
require('r0xsh.modules.pack').load_plugins()
