return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        enabled = require('r0xsh.modules.profile').config.enable_treesitter,
        lazy = false,
        build = function()
            local ok, ts = pcall(require, 'nvim-treesitter')
            if not ok then
                return
            end

            ts.install {
                'bash',
                'c',
                'diff',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
                'elixir',
                'erlang',
                'heex',
                'surface',
                'javascript',
                'gitcommit',
            }
            ts.update()
        end,
        config = function()
            local ok, ts = pcall(require, 'nvim-treesitter')
            if not ok then
                return
            end

            local installed_parsers = ts.get_installed()
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('r0xshTreeSitterSpawn', { clear = true }),
                desc = 'Auto enable treesitter for supported filetype',
                pattern = installed_parsers,
                callback = function(args)
                    vim.treesitter.start(args.buf, args.match)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
