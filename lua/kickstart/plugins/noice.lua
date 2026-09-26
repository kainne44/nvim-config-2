return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    opts = {
      lsp = {
        -- Render LSP hover/signature markdown with treesitter
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true, -- classic cmdline for / and ?
        command_palette = true, -- cmdline and popupmenu together at the top
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },
}
