return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = true,
      heading = {
        width = 'block',
        min_width = 20,
        border = true,
        border_virtual = true,
      },
      code = {
        enabled = true,
        style = 'full',
        width = 'block',
        left_pad = 2,
        right_pad = 4,
      },
      bullet = {
        left_pad = 4,
      },
      pipe_table = {
        preset = 'round',
        min_width = 12,
      },
    },
  },
}
