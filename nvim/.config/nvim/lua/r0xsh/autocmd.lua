vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('r0xshTextYankPost', { clear = true }),
    desc = 'Highlight when yanking text',
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('r0xshEdifactSyntax', { clear = true }),
    desc = 'Set EDIFACT syntax for .edi files',
    pattern = '*.edi',
    callback = function(args)
        vim.bo[args.buf].syntax = 'edifact'
    end,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter', 'WinLeave' }, {
    group = vim.api.nvim_create_augroup('r0xshCursorLine', { clear = true }),
    desc = 'Show cursorline only in the current focused buffer',
    pattern = '*',
    callback = function(args)
        vim.opt_local.cursorline = args.event ~= 'WinLeave'
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('r0xshTermConfig', { clear = true }),
    desc = 'Clean the window decorations for terminal buffers',
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.foldcolumn = '0'
        vim.bo.buflisted = false
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('r0xshCleanCalciumScratchpad', { clear = true }),
    desc = 'Bind <C-l> to clean the buffer like regular shells',
    pattern = 'calcium',
    callback = function(args)
        vim.keymap.set('n', '<C-l>', function()
            vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, {})
        end, { buffer = args.buf })
    end,
})
