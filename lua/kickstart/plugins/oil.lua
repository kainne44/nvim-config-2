return {
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      columns = {
        default_file = ...,
        directory = ...,
        'icon',
      },
      view_options = {
        show_hidden = true,
      },
      buf_options = {
        buflisted = true,
      },
      lazy = false,
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
