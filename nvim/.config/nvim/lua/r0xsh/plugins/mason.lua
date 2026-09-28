if not require('r0xsh.modules.profile').config.lsp.enabled then
    return
end

local pack = require('r0xsh.modules.pack')

-- Only installs the LSP binaries, they are found through PATH (see `r0xsh.lsp`)
pack.later(function()
    vim.pack.add { pack.gh('mason-org/mason.nvim') }
    require('mason').setup {
        install_root_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason'),
        PATH = 'skip',
        ui = { backdrop = 90 },
    }
end)
