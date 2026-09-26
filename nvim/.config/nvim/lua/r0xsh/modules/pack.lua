-- Helpers around the builtin plugin manager
-- @see https://neovim.io/doc/user/pack/
-- @module Pack
-- @alias M
local M = {}

-- Return the GitHub url of a `user/repo`
-- @treturn string
function M.gh(repo)
    return 'https://github.com/' .. repo
end

-- Run `fn` right after startup (what was `VeryLazy` with lazy.nvim),
-- an error is reported instead of breaking the other deferred plugins.
function M.later(fn)
    vim.schedule(function()
        local ok, err = pcall(fn)
        if not ok then
            vim.notify(err, vim.log.levels.ERROR)
        end
    end)
end

-- Source every `lua/r0xsh/plugins/*.lua` in alphabetical order,
-- a broken file is reported instead of stopping the others.
function M.load_plugins()
    if not vim.pack then
        vim.notify('vim.pack needs Neovim 0.12+, plugins are not loaded', vim.log.levels.WARN)
        return
    end

    local names = {}
    for file in vim.fs.dir(vim.fn.stdpath('config') .. '/lua/r0xsh/plugins') do
        names[#names + 1] = file:match('^(.+)%.lua$')
    end
    table.sort(names)

    for _, name in ipairs(names) do
        local ok, err = pcall(require, 'r0xsh.plugins.' .. name)
        if not ok then
            vim.notify(('Failed to load plugins/%s.lua: %s'):format(name, err), vim.log.levels.ERROR)
        end
    end
end

return M
