return {
    {
        'ibhagwan/fzf-lua',
        event = 'VeryLazy',
        config = function()
            local fzf = require('fzf-lua')
            fzf.setup {
                winopts = {
                    height = 0.92,
                    width = 0.92,
                    border = 'single',
                    preview = { border = 'single' },
                    backdrop = 90,
                },
                fzf_colors = true,
                keymap = {
                    fzf = {
                        ['ctrl-q'] = 'select-all+accept',
                    },
                },
            }

            vim.schedule(function()
                fzf.register_ui_select()
            end)

            vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect fzf' })
            vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
        end,
    },
}
