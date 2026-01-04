vim.api.nvim_create_user_command('LspmuxStatus', function()
    vim.cmd('tabnew | term lspmux status')
end, { desc = 'Open lspmux status in a new terminal tab' })

vim.api.nvim_create_user_command('RenameFile', function()
    require('snacks').rename.rename_file()
end, { desc = 'Rename current file with LSP support' })
