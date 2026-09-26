return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = true,
      completions = { lsp = { enabled = true } }, -- callouts/checkboxes via blink's lsp source
      -- Show raw markdown only on the cursor line, so editing stays readable
      anti_conceal = { enabled = true },
      heading = {
        sign = false,
        position = 'inline',
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        width = 'block',
        left_pad = 1,
        right_pad = 2,
        border = false,
      },
      code = {
        sign = false,
        style = 'full',
        width = 'block',
        min_width = 60,
        left_pad = 2,
        right_pad = 2,
        position = 'right',
        language_pad = 1,
        border = 'thin',
      },
      dash = { icon = '─', width = 'full' },
      bullet = { icons = { '•', '◦', '▸', '▹' } },
      checkbox = {
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰄵 ', scope_highlight = '@markup.strikethrough' },
      },
      quote = { icon = '▎' },
      pipe_table = {
        preset = 'round',
        min_width = 8,
      },
      link = {
        wiki = { icon = '󰌹 ' },
      },
    },
  },
}
