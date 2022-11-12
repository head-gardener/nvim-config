vim.cmd('set termguicolors')
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme oxocarbon')
-- vim.g.sierra_Sunset = 1
vim.g.sierra_Twilight = 1
-- vim.g.sierra_Midnight = 1
-- vim.g.sierra_Pitch = 1
vim.cmd('colorscheme sierra')
vim.o.background = 'dark'

-- hide statusline
-- vim.cmd("set noshowmode")
-- vim.cmd("set noruler")
-- vim.cmd("set laststatus=0")
-- vim.cmd("set noshowcmd")

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.copyindent = true

vim.o.signcolumn = "yes"
vim.o.hidden = true
vim.o.number = false
vim.o.cursorline = true
vim.o.showmatch = true

vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
