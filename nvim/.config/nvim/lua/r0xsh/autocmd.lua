-- FIXME: Should get rid of `opt_local`
-- See: https://github.com/neovim/neovim/issues/20451

local autocmd = vim.api.nvim_create_autocmd
local augroup = function(group)
    return vim.api.nvim_create_augroup(group, { clear = true })
end

autocmd('TextYankPost', {
    group = augroup('r0xshTextYankPost'),
    desc = 'Highlight when yanking text',
    callback = function()
        vim.hl.on_yank()
    end,
})

autocmd({ 'BufRead', 'BufNewFile' }, {
    group = augroup('r0xshEdifactSyntax'),
    desc = 'Set EDIFACT syntax for .edi files',
    pattern = '*.edi',
    callback = function(args)
        vim.bo[args.buf].syntax = 'edifact'
    end,
})

autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter', 'WinLeave' }, {
    group = augroup('r0xshCursorLine'),
    desc = 'Show cursorline only in the current focused buffer',
    pattern = '*',
    callback = function(args)
        vim.wo.cursorline = args.event ~= 'WinLeave'
    end,
})

autocmd('TermOpen', {
    group = augroup('r0xshTermConfig'),
    desc = 'Clean the window decorations for terminal buffers',
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = 'no'
        vim.wo.foldcolumn = '0'
        vim.bo.buflisted = false
        vim.wo.signcolumn = 'no'
    end,
})

autocmd('FileType', {
    group = augroup('r0xshCleanCalciumScratchpad'),
    desc = 'Bind <C-l> to clean the buffer like regular shells',
    pattern = 'calcium',
    callback = function(args)
        vim.keymap.set('n', '<C-l>', function()
            vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, {})
        end, { buffer = args.buf })
    end,
})

-- @see https://vi.stackexchange.com/questions/43428/how-to-disable-lsp-server-syntax-highlighting
autocmd('LspAttach', {
    group = augroup('r0xshDisableLspHightlight'),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

-- NOTE: Considering using `BufReadPost` event instead.
autocmd('VimEnter', {
    group = augroup('r0xshFindWorkdir'),
    desc = 'Automatically find working directory and cd to it',
    callback = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == '' then
            return
        end

        local root_hint = {
            '.git',
            'README.md',
            'Makefile',
            'LICENSE',
            'compose.yml',
            'docker-compose.yml',
            'package.json',
            'composer.json',
            'mix.exs',
        }

        -- TODO: Maybe accessing .[1] will cause trouble
        local root = vim.fs.find(root_hint, {
            path = path,
            upward = true,
            stop = vim.uv.os_homedir(),
        })[1]

        if root then
            local root_dir = vim.fs.dirname(root)
            vim.fn.chdir(root_dir)
        end
    end,
})

autocmd({ 'FocusGained', 'BufEnter' }, {
    group = augroup('r0xshCheckForExternalChange'),
    pattern = { '*' },
    command = 'checktime',
})
