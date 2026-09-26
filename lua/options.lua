-- [[ Options ]] see `:help option-list`
local opt = vim.opt

-- Gutter
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
vim.o.foldcolumn = '1'
vim.o.fillchars = [[eob: ,fold: ,foldopen:>,foldsep: ,foldclose:v]]

-- Editor behaviour
opt.mouse = 'a'
opt.showmode = false -- the mode is in the statusline
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 300 -- which-key pops up sooner
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 10
opt.cursorline = true
opt.isfname:append '@-@'
vim.g.netrw_banner = 0

-- Sync with the system clipboard; scheduled because it can slow startup
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Wrapping
opt.wrap = true
opt.linebreak = true
opt.textwidth = 80
opt.smoothscroll = true -- scroll wrapped lines by screen line

-- Search: case-insensitive unless the pattern has capitals
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = 'split' -- live preview of :s

-- Display
opt.termguicolors = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.conceallevel = 2
opt.pumheight = 12
vim.o.winborder = 'rounded' -- all floating windows

-- Spelling (enabled per filetype, e.g. after/ftplugin/markdown.lua)
vim.fn.mkdir(vim.fn.stdpath 'config' .. '/spell', 'p')
opt.spellfile = vim.fn.stdpath 'config' .. '/spell/en.utf-8.add' -- `zg` words live with the config
opt.spelloptions = { 'camel', 'noplainbuffer' } -- skip camelCase parts; only check prose treesitter marks as @spell
opt.spellcapcheck = '' -- don't flag lowercase sentence starts (bullets, fragments)

-- vim: ts=2 sts=2 sw=2 et
