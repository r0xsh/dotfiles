local pack = require('r0xsh.modules.pack')

-- Notifications, in the bottom right corner above the statusline and command line
vim.pack.add { pack.gh('nvim-mini/mini.notify') }
require('mini.notify').setup {
    window = {
        config = function()
            local statusline = vim.o.laststatus > 0 and 1 or 0
            return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - vim.o.cmdheight - statusline }
        end,
    },
}

-- Highlight FIXME, HACK, TODO, NOTE and hex colors
vim.pack.add { pack.gh('nvim-mini/mini.hipatterns') }
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

-- More `a` / `i` textobjects
vim.pack.add { pack.gh('nvim-mini/mini.ai') }
require('mini.ai').setup()

-- Key hints, loaded right after startup
pack.later(function()
    vim.pack.add { pack.gh('nvim-mini/mini.clue') }
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
