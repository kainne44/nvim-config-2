-- Leader keys must be set before plugins load
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\' -- vimtex mappings (\ll, \lv, ...) live under localleader

vim.g.have_nerd_font = true

require 'options'

-- Local colorscheme, see lua/summer-night (`:colorscheme summer-night` for the darker original)
vim.cmd.colorscheme 'summer-dusk'

require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'

-- vim: ts=2 sts=2 sw=2 et
