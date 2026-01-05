local p = require('r0xsh.modules.profile').config

-- Prepend Mason bin to Neovim's PATH
local mason_bin = require('r0xsh.modules.utils').get_mason_bin_path()
vim.env.PATH = mason_bin .. ':' .. vim.env.PATH

-- Use my custom root markers for lsp
vim.lsp.config('*', { root_markers = p.root_markers })

-- List all lsp config files then **enable** them.
vim.schedule(function()
    local lsp_dir = vim.fn.stdpath('config') .. '/lsp'
    for file in vim.fs.dir(lsp_dir) do
        if file:sub(-4) == '.lua' then
            local server = vim.fn.fnamemodify(file, ':r')
            pcall(vim.lsp.enable, server)
        end
    end
end)

-- Neovim diagnostic config.
-- @see https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.Opts
vim.diagnostic.config {
    severity_sort = true,
    virtual_lines = {
        current_line = true,
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = false,
}
