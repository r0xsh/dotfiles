-- enterprise_dark.lua
local vim = vim
local api = vim.api

local palette = {
    bg = '#000000',
    bg_alt = '#0f0f0f',
    fg = '#b3b3b3',
    text = '#aaaaaa',
    comment = '#555555',
    keyword = '#585858',
    func = '#FFFF00',
    method = '#777777',
    variable = '#ffffff',
    string = '#aaaaaa',
    number = '#aaaaaa',
    constant = '#aaaaaa',
    operator = '#B3B3B3',
    punctuation = '#B3B3B3',
    tag = '#cccccc',
    attr = '#777777',
    cursor = '#b3b3b3',
    selection = '#303030',
    info = '#6796E6',
    warning = '#CD9731',
    error = '#F44747',
}

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
end
vim.o.background = 'dark'
vim.g.colors_name = 'enterprise_dark'

local function hi(group, opts)
    local style = {}
    if opts.fg then
        table.insert(style, 'guifg=' .. opts.fg)
    end
    if opts.bg then
        table.insert(style, 'guibg=' .. opts.bg)
    end
    if opts.sp then
        table.insert(style, 'guisp=' .. opts.sp)
    end
    if opts.bold then
        table.insert(style, 'gui=bold')
    end
    if opts.italic then
        table.insert(style, 'gui=italic')
    end
    if opts.underline then
        table.insert(style, 'gui=underline')
    end
    api.nvim_command('hi ' .. group .. ' ' .. table.concat(style, ' '))
end

-- Basic editor
hi('Normal', { fg = palette.fg, bg = palette.bg })
hi('CursorLine', { bg = '#0a0a0a' })
hi('NormalNC', { fg = palette.text, bg = palette.bg })
hi('LineNr', { fg = '#222222', bg = palette.bg })
hi('CursorLineNr', { fg = '#777777', bg = palette.bg })
hi('Visual', { bg = palette.selection })
hi('Pmenu', { fg = palette.fg, bg = palette.bg_alt })
hi('PmenuSel', { fg = palette.bg, bg = palette.selection })
hi('StatusLine', { fg = palette.fg, bg = palette.bg })
hi('StatusLineNC', { fg = '#aaaaaa', bg = palette.bg })
hi('TabLine', { fg = '#ffffff', bg = palette.bg })
hi('TabLineSel', { fg = '#ffffff', bg = '#171717' })
hi('Title', { fg = palette.fg, bold = true })

-- Comments, keywords, operators
hi('Comment', { fg = palette.comment, italic = true })
hi('Todo', { fg = palette.warning, bg = palette.bg })
hi('Constant', { fg = palette.constant })
hi('String', { fg = palette.string })
hi('Character', { fg = palette.string })
hi('Number', { fg = palette.number })
hi('Boolean', { fg = palette.constant })
hi('Float', { fg = palette.number })
hi('Identifier', { fg = palette.variable })
hi('Function', { fg = palette.func })
hi('Method', { fg = palette.method, italic = true })
hi('Statement', { fg = palette.keyword, italic = true })
hi('Conditional', { fg = palette.keyword, italic = true })
hi('Repeat', { fg = palette.keyword })
hi('Label', { fg = palette.tag })
hi('Operator', { fg = palette.operator })
hi('Keyword', { fg = palette.keyword, italic = true })
hi('Exception', { fg = palette.error })

-- Tags / markup
hi('Tag', { fg = palette.tag })
hi('Delimiter', { fg = palette.punctuation })
hi('Special', { fg = palette.operator })
hi('Identifier', { fg = palette.variable })
hi('Attribute', { fg = palette.attr })

-- UI elements
hi('ErrorMsg', { fg = palette.error, bg = palette.bg })
hi('WarningMsg', { fg = palette.warning })
hi('MoreMsg', { fg = palette.info })
hi('Search', { fg = palette.bg, bg = '#FFFFFF66' }) -- from editor.highlighted_line.background
hi('IncSearch', { fg = palette.bg, bg = palette.info })
hi('MatchParen', { fg = palette.info, bg = '#2d2d2d' })
hi('VisualNOS', { fg = palette.fg })

-- Diff / git
hi('DiffAdd', { fg = '#4d4d4d' })
hi('DiffChange', { fg = palette.conflict or '#c0c0c0' })
hi('DiffDelete', { fg = palette.deleted or '#777777' })
hi('DiffText', { fg = palette.modified or '#c0c0c0' })

-- Diagnostics (LSP)
hi('DiagnosticError', { fg = palette.error })
hi('DiagnosticWarn', { fg = palette.warning })
hi('DiagnosticInfo', { fg = palette.info })
hi('DiagnosticHint', { fg = palette.fg })

-- Treesitter (common)
hi('@comment', { fg = palette.comment, italic = true })
hi('@keyword', { fg = palette.keyword, italic = true })
hi('@variable', { fg = palette.variable })
hi('@function', { fg = palette.func })
hi('@method', { fg = palette.method, italic = true })
hi('@string', { fg = palette.string })
hi('@number', { fg = palette.number })
hi('@constant', { fg = palette.constant })
hi('@type', { fg = palette.tag })
hi('@tag', { fg = palette.tag })
hi('@property', { fg = palette.attr })
hi('@operator', { fg = palette.operator })

-- Terminal (for Neovim terminal)
vim.g.terminal_color_0 = '#000000'
vim.g.terminal_color_1 = '#999999' -- red-ish per Zed mapping
vim.g.terminal_color_2 = '#4d4d4d'
vim.g.terminal_color_3 = '#b3b3b3'
vim.g.terminal_color_4 = '#333333'
vim.g.terminal_color_5 = '#999999'
vim.g.terminal_color_6 = '#666666'
vim.g.terminal_color_7 = '#cccccc'
vim.g.terminal_color_8 = '#1a1a1a'
vim.g.terminal_color_9 = '#999999'
vim.g.terminal_color_10 = '#4d4d4d'
vim.g.terminal_color_11 = '#b3b3b3'
vim.g.terminal_color_12 = '#333333'
vim.g.terminal_color_13 = '#999999'
vim.g.terminal_color_14 = '#666666'
vim.g.terminal_color_15 = '#ffffff'

-- Link some common groups
api.nvim_command('hi link HealthError ErrorMsg')
api.nvim_command('hi link FloatNumber Number')
api.nvim_command('hi link CursorLineNr LineNr')
