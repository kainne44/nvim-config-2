return {
  {
    'stevearc/oil.nvim',
    lazy = false, -- oil recommends against lazy-loading so it can take over directory buffers
    opts = {
      default_file_explorer = true,
      columns = { 'icon' },
      view_options = {
        show_hidden = true,
      },
      buf_options = {
        buflisted = true,
      },
      float = {
        padding = 4,
        max_width = 0.4,
        max_height = 0.5,
        border = 'rounded',
        win_options = {
          winblend = 1,
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
