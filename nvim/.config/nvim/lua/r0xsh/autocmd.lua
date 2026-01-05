-- FIXME: Should get rid of `opt_local`
-- See: https://github.com/neovim/neovim/issues/20451

local p = require('r0xsh.modules.profile').config

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
        local enter_in_buffer = args.event ~= 'WinLeave'
        vim.wo.cursorline = enter_in_buffer
        vim.wo.relativenumber = enter_in_buffer
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

autocmd('VimEnter', {
    group = augroup('r0xshFindWorkdir'),
    desc = 'Automatically find working directory and cd to it',
    callback = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == '' then
            return
        end

        -- TODO: Maybe accessing .[1] will cause trouble
        local root = vim.fs.find(p.root_markers, {
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

-- @see https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#netrw-builtin-file-explorer
autocmd({ 'FileType' }, {
    pattern = { 'netrw' },
    group = augroup('r0xshNetrwOnRename'),
    callback = function()
        vim.keymap.set('n', 'R', function()
            local original_file_path = vim.b.netrw_curdir .. '/' .. vim.fn['netrw#Call']('NetrwGetWord')

            vim.ui.input({ prompt = 'Move/rename to:', default = original_file_path }, function(target_file_path)
                if target_file_path and target_file_path ~= '' then
                    local file_exists = vim.uv.fs_access(target_file_path, 'W')

                    if not file_exists then
                        vim.uv.fs_rename(original_file_path, target_file_path)

                        Snacks.rename.on_rename_file(original_file_path, target_file_path)
                    else
                        vim.notify(
                            "File '" .. target_file_path .. "' already exists! Skipping...",
                            vim.log.levels.ERROR
                        )
                    end

                    -- Refresh netrw
                    vim.cmd(':Ex ' .. vim.b.netrw_curdir)
                end
            end)
        end, { remap = true, buffer = true })
    end,
})
