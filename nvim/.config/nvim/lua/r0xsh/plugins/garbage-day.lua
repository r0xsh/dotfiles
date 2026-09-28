local p = require('r0xsh.modules.profile').config
if not p.lsp.enabled or p.lsp.use_lspmux then
    return
end

local pack = require('r0xsh.modules.pack')

-- TODO: Rewrite this plugin or get rid of it.
-- Stops inactive LSP clients to free memory
pack.later(function()
    vim.pack.add { pack.gh('r0xsh/garbage-day.nvim') }
    require('garbage-day').setup()
end)
