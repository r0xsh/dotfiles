if not require('r0xsh.modules.profile').config.enable_treesitter then
    return
end

local pack = require('r0xsh.modules.pack')

vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('r0xshTreeSitterUpdate', { clear = true }),
    desc = 'Update parsers after nvim-treesitter itself is updated',
    callback = function(ev)
        local data = ev.data
        if data.spec.name ~= 'nvim-treesitter' or data.kind ~= 'update' or not data.active then
            return
        end

        -- Drop the modules cached from before the update, so `:TSUpdate` uses the new parser revisions
        for name in pairs(package.loaded) do
            if vim.startswith(name, 'nvim-treesitter') then
                package.loaded[name] = nil
            end
        end
        vim.cmd('TSUpdate')
    end,
})

require('vim.treesitter.query').add_predicate('is-mise?', function(_, _, bufnr, _)
    local filepath = vim.fs.normalize(vim.api.nvim_buf_get_name(tonumber(bufnr) or 0))
    local filename = vim.fn.fnamemodify(filepath, ':t')
    return filename:match('^%.?mise.*%.toml$') ~= nil
        or filepath:match('/%.?mise/config%.toml$') ~= nil
        or filepath:match('/%.?mise/config%.local%.toml$') ~= nil
        or filepath:match('/%.?mise/config%.[^/]+%.toml$') ~= nil
        or filepath:match('/%.config/mise/mise%.toml$') ~= nil
        or filepath:match('/%.config/mise/mise%.local%.toml$') ~= nil
        or filepath:match('/%.?mise/conf%.d/[^/]+%.toml$') ~= nil
end, { force = true, all = false })

vim.pack.add { { src = pack.gh('nvim-treesitter/nvim-treesitter'), version = 'main' } }

-- Async, and a no-op when the parsers are already installed
pack.later(function()
    require('nvim-treesitter').install {
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
        'toml',
        'kdl',
        'php',
        'rust',
        'python',
        'typescript',
        'tsx',
        'json',
        'gleam',
    }
end)

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('r0xshTreeSitterSpawn', { clear = true }),
    desc = 'Auto enable treesitter for supported filetype',
    callback = function(args)
        -- Filetypes and parser names differ (e.g. `sh` uses the `bash` parser)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not (lang and vim.treesitter.language.add(lang)) then
            return
        end

        vim.treesitter.start(args.buf, lang)
        -- Keep the runtime indent script when there is no treesitter indent query
        if vim.treesitter.query.get(lang, 'indents') then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
