-- Plugin folder for trying out different notes plugins
return {
  -- obsidian.nvim
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('obsidian').setup {

      workspaces = {
        {
          name = 'notes',
          path = '~/vaults/notes',
        },
      },
    }
  end,
}
