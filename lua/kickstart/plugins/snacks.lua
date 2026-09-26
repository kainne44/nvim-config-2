return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true }, -- replaces mini.indentscope
      input = { enabled = true },
      notifier = { enabled = false }, -- noice + nvim-notify handle notifications
      quickfile = { enabled = true },
      scroll = { enabled = false }, -- conflicts with the <C-d>zz / nzzzv remaps in keymaps.lua
      statuscolumn = { enabled = true },
      words = { enabled = false }, -- LSP reference highlighting is done in lspconfig.lua
    },
  },
}
