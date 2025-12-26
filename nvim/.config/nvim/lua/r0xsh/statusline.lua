vim.opt.statusline = table.concat {
    -- Left side
    ' ',
    '%f',
    ' ',
    '%m',

    -- Spacer
    '%=',

    -- Right side
    "%{get(b:,'gitsigns_head','')}",
    ' ',
    '%y',
    ' ',
    '%p%%',
    ' ',
}
