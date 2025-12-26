vim.api.nvim_create_user_command('LspmuxStatus', function()
    vim.cmd('tabnew | term lspmux status')
end, { desc = 'Open lspmux status in a new terminal tab' })
