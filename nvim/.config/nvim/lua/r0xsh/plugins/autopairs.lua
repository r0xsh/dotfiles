local pack = require('r0xsh.modules.pack')

pack.later(function()
    vim.pack.add { pack.gh('windwp/nvim-autopairs') }

    local npairs = require('nvim-autopairs')
    local endwise = require('nvim-autopairs.ts-rule').endwise
    npairs.setup()

    -- Insert the closing `end` of Lua blocks and Elixir `do` blocks
    npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    npairs.add_rules { endwise(' do$', 'end', 'elixir', nil) }
end)
