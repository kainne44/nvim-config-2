-- Plugin specs live in lua/kickstart/plugins/<name>.lua. `:Lazy` shows status.
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Editing
  require 'kickstart/plugins/treesitter',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart/plugins/blink',
  require 'kickstart/plugins/conform',
  require 'kickstart/plugins/lint',
  require 'kickstart/plugins/autopairs',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/betterescape',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/trouble',
  require 'kickstart/plugins/gitsigns',

  -- Navigation
  require 'kickstart/plugins/telescope',
  require 'kickstart/plugins/oil',
  require 'kickstart/plugins/workspaces',
  require 'kickstart/plugins/toggleterm',
  require 'kickstart/plugins/which-key',

  -- UI
  require 'kickstart/plugins/snacks',
  require 'kickstart/plugins/lualine',
  require 'kickstart/plugins/bufferline',
  require 'kickstart/plugins/noice',
  require 'kickstart/plugins/focus',
  require 'kickstart/plugins/highlight-colors',

  -- Notes and writing
  require 'kickstart/plugins/note-taking',
  require 'kickstart/plugins/render-markdown',
  require 'kickstart/plugins/wrapping',
  require 'kickstart/plugins/vimtex',
}, {
  ui = {
    -- Nerd Font icons when available, otherwise unicode fallbacks
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
