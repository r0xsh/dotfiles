-- Prepend Mason bin to Neovim's PATH
local mason_bin = require('r0xsh.modules.utils').get_mason_bin_path()
vim.env.PATH = mason_bin .. ':' .. vim.env.PATH

-- List all lsp config files then **enable** them.
-- `vim.lsp.enable()` loads the config right away: report a broken file (e.g. leftover
-- merge markers from `manage_lsp update`) instead of silently skipping that server.
for file in vim.fs.dir(vim.fn.stdpath('config') .. '/lsp') do
    local server = file:match('^(.+)%.lua$')
    if server then
        local ok, err = pcall(vim.lsp.enable, server)
        if not ok then
            vim.notify(('Failed to enable %s: %s'):format(server, err), vim.log.levels.ERROR)
        end
    end
end

-- Leave highlighting to treesitter
vim.lsp.semantic_tokens.enable(false)

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
