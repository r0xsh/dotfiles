local p = require('r0xsh.modules.profile').config
local pack = require('r0xsh.modules.pack')
local gh = pack.gh

-- Loaded at startup

vim.pack.add { gh('folke/snacks.nvim') }
require('snacks').setup {
    quickfile = { enabled = true },
    words = { enabled = p.lsp.enabled },
}

vim.pack.add { gh('nvim-mini/mini.notify') }
local win_config = function()
    local has_statusline = vim.o.laststatus > 0
    local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
    return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
end
require('mini.notify').setup { window = { config = win_config } }

if vim.env.WEZTERM_UNIX_SOCKET then
    vim.pack.add { gh('mrjones2014/smart-splits.nvim') }
    local splits = require('smart-splits')
    vim.keymap.set('n', '<C-w>h', splits.move_cursor_left)
    vim.keymap.set('n', '<C-w>j', splits.move_cursor_down)
    vim.keymap.set('n', '<C-w>k', splits.move_cursor_up)
    vim.keymap.set('n', '<C-w>l', splits.move_cursor_right)
    vim.keymap.set('n', '<C-w><Left>', splits.move_cursor_left)
    vim.keymap.set('n', '<C-w><Down>', splits.move_cursor_down)
    vim.keymap.set('n', '<C-w><Up>', splits.move_cursor_up)
    vim.keymap.set('n', '<C-w><Right>', splits.move_cursor_right)
end

vim.pack.add { gh('folke/ts-comments.nvim') }
require('ts-comments').setup()

vim.pack.add { gh('nvim-mini/mini.hipatterns') }
local hipatterns = require('mini.hipatterns')
hipatterns.setup {
    highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
}

vim.pack.add { gh('nvim-mini/mini.ai') }
require('mini.ai').setup()

-- Deferred right after startup

pack.later(function()
    vim.pack.add { gh('windwp/nvim-autopairs') }
    local npairs = require('nvim-autopairs')
    local r = require('nvim-autopairs.ts-rule')
    npairs.setup()

    npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    npairs.add_rules {
        r.endwise(' do$', 'end', 'elixir', nil),
    }
end)

pack.later(function()
    vim.pack.add { gh('nvim-mini/mini.clue') }
    local miniclue = require('mini.clue')
    miniclue.setup {
        triggers = {
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },
            { mode = 'n', keys = '<C-w>' },
            -- Needed by `builtin_completion()` and `registers()` below
            { mode = 'i', keys = '<C-x>' },
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },
        },
        clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            -- miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            -- miniclue.gen_clues.z(),
        },
        window = {
            config = { width = 50 },
        },
    }
end)

if p.lsp.enabled then
    pack.later(function()
        vim.pack.add { gh('mason-org/mason.nvim') }
        require('mason').setup {
            install_root_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason'),
            PATH = 'skip',
            ui = { backdrop = 90 },
        }
    end)
end

-- TODO: Rewrite this plugin or get rid of it.
if p.lsp.enabled and not p.lsp.use_lspmux then
    pack.later(function()
        vim.pack.add { gh('r0xsh/garbage-day.nvim') }
        require('garbage-day').setup()
    end)
end
