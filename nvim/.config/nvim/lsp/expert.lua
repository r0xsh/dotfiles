local utils = require('r0xsh.modules.utils')
---@type vim.lsp.Config
return {
    cmd = utils.lspmux_cmd_fallback { 'expert', '--stdio' },
    filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
    init_options = {
        lspMux = {
            version = '1',
            method = 'connect',
            server = 'expert',
            args = { '--stdio' },
            env = {
                PATH = vim.env.PATH,
            },
        },
    },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        --- Elixir workspaces may have multiple `mix.exs` files, for an "umbrella" layout or monorepo.
        --- So we specify `limit=2` and treat the highest one (if any) as the root of an umbrella app.
        local matches = vim.fs.find({ 'mix.exs' }, { upward = true, limit = 2, path = fname })
        local child_or_root_path, maybe_umbrella_path = unpack(matches)
        local root_dir = vim.fs.dirname(maybe_umbrella_path or child_or_root_path)

        on_dir(root_dir)
    end,
}
