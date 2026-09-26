return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require('lualine').setup {
      options = {
        globalstatus = true,
        section_separators = '',
        component_separators = '│',
      },
      sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 2 } },
        lualine_x = { 'filetype' },
      },
    }
  end,
}
