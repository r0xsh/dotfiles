local function open_elixir_term(custom_cmd)
    local base_cmd = vim.fn.filereadable('mix.exs') == 1 and 'iex -S mix' or 'iex'
    local final_cmd = custom_cmd or base_cmd

    vim.cmd('botright split')
    vim.cmd('term ' .. final_cmd)
    vim.api.nvim_win_set_height(0, 15)
    vim.cmd('startinsert')
end

vim.keymap.set('n', '<localleader>i', function()
    open_elixir_term()
end, { buffer = true, desc = 'Open IEx' })

vim.keymap.set('n', '<localleader>a', function()
    open_elixir_term('iex --sname nvim_client --remsh dbg')
end, { buffer = true, desc = "Attach to 'dbg' node" })
