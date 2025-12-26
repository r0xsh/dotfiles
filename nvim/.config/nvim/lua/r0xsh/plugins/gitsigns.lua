return {
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            preview_config = { border = 'single' },
            current_line_blame = true,
        },
    },
}
