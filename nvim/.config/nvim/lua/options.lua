local o = vim.o
local g = vim.g

o.termguicolors = true -- Enable 24 bit RGB colors

o.number = true         -- Show line numbers
o.relativenumber = true -- Show relative line numbers, enables easy up,down jumping
o.signcolumn = 'yes'    -- Show sign column
o.wrap = false          -- Never wrap
o.autoindent = true     -- Auto indent new lines
o.expandtab = true      -- Use spaces instead of tabs
o.smartindent = true
o.smarttab = true
o.shiftwidth = 2
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.colorcolumn = '80,120'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- Remap common typos
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")

vim.cmd("autocmd BufEnter *.component.ts syntax match htmlTemplate /\vtemplate:s*`.*`/")
vim.cmd("autocmd BufEnter *.component.ts syntax region htmlTemplate start=+\vtemplate:s*`+ end=+`+ containedin=typescript")

vim.diagnostic.config({ virtual_text = false })

vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})

vim.treesitter.language.register('markdown', 'mdx')  -- the someft filetype will use the python parser and queries.

o.mouse = ""
