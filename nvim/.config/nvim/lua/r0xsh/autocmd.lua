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

-- Set EDIFACT filetype for .edi files, it picks up `syntax/edifact.vim`
vim.filetype.add { extension = { edi = 'edifact' } }

-- NOTE: `vim.wo[0][0]` behaves like `:setlocal`. Plain `vim.wo` behaves like `:set` and would
-- also change the window's global value, leaking into the next buffer opened in that window.

autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter', 'WinLeave' }, {
    group = augroup('r0xshCursorLine'),
    desc = 'Show cursorline only in the current focused buffer',
    pattern = '*',
    callback = function(args)
        local enter_in_buffer = args.event ~= 'WinLeave'
        vim.wo[0][0].cursorline = enter_in_buffer
        -- Terminals keep the decorations set on `TermOpen`
        if vim.bo[args.buf].buftype ~= 'terminal' then
            vim.wo[0][0].relativenumber = enter_in_buffer
        end
    end,
})

autocmd('TermOpen', {
    group = augroup('r0xshTermConfig'),
    desc = 'Clean the window decorations for terminal buffers',
    callback = function()
        vim.wo[0][0].number = false
        vim.wo[0][0].relativenumber = false
        vim.wo[0][0].signcolumn = 'no'
        vim.wo[0][0].foldcolumn = '0'
        vim.bo.buflisted = false
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

autocmd('VimEnter', {
    group = augroup('r0xshFindWorkdir'),
    desc = 'Automatically find working directory and cd to it',
    callback = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == '' then
            return
        end

        -- Try the markers in priority order, so `.git` wins over a nested README.md
        for _, marker in ipairs(p.root_markers) do
            local root = vim.fs.find(marker, {
                path = path,
                upward = true,
                stop = vim.uv.os_homedir(),
            })[1]

            if root then
                vim.fn.chdir(vim.fs.dirname(root))
                return
            end
        end
    end,
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
