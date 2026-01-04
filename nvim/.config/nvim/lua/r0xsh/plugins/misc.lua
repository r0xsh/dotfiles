local p = require('r0xsh.modules.profile').config
return {
    {
        'mason-org/mason.nvim',
        enabled = p.lsp.enabled,
        cmd = { 'Mason', 'MasonUpdate', 'MasonInstall' },
        opts = {
            install_root_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason'),
            PATH = 'skip',
            ui = { backdrop = 90 },
        },
    },
    {
        -- TODO: Rewrite this plugin or get rid of it.
        'r0xsh/garbage-day.nvim',
        enabled = not p.lsp.use_lspmux,
        event = 'VeryLazy',
        opts = {},
    },
    {
        'vimpostor/vim-tpipeline',
        cond = vim.fn.getenv('TMUX') ~= vim.NIL,
    },
    {
        'folke/ts-comments.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        enabled = vim.fn.has('nvim-0.10.0') == 1,
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },
    {
        'nvim-mini/mini.clue',
        event = 'VeryLazy',
        config = function()
            local miniclue = require('mini.clue')
            miniclue.setup {
                triggers = {
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },
                    { mode = 'n', keys = '<C-w>' },
                },
                clues = {
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    -- miniclue.gen_clues.marks(),
                    -- miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    -- miniclue.gen_clues.z(),
                },
                window = {
                    config = { width = 50 },
                },
            }
        end,
    },
    {
        'nvim-mini/mini.notify',
        config = function()
            local win_config = function()
                local has_statusline = vim.o.laststatus > 0
                local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
                return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
            end
            require('mini.notify').setup { window = { config = win_config } }
        end,
    },
    {
        'nvim-mini/mini.hipatterns',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
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
        end,
    },
    {
        'nvim-mini/mini.ai',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },
    {
        'mrjones2014/smart-splits.nvim',
        cond = vim.fn.getenv('WEZTERM_UNIX_SOCKET') ~= vim.NIL,
        lazy = false,
        opts = {},
        config = function()
            vim.keymap.set('n', '<C-w>h', require('smart-splits').move_cursor_left)
            vim.keymap.set('n', '<C-w>j', require('smart-splits').move_cursor_down)
            vim.keymap.set('n', '<C-w>k', require('smart-splits').move_cursor_up)
            vim.keymap.set('n', '<C-w>l', require('smart-splits').move_cursor_right)
            vim.keymap.set('n', '<C-w><Left>', require('smart-splits').move_cursor_left)
            vim.keymap.set('n', '<C-w><Down>', require('smart-splits').move_cursor_down)
            vim.keymap.set('n', '<C-w><Up>', require('smart-splits').move_cursor_up)
            vim.keymap.set('n', '<C-w><Right>', require('smart-splits').move_cursor_right)
        end,
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            quickfile = { enabled = true },
            words = {},
        },
    },
}
