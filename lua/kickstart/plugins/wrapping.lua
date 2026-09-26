return {
  {
    'andrewferrier/wrapping.nvim',
    config = function()
      require('wrapping').setup {
        -- Markdown is always soft-wrapped: rendered tables and concealed links need 'wrap'.
        -- Without this, the global textwidth=80 makes wrapping.nvim force hard mode (nowrap).
        softener = { markdown = true },
        notify_on_switch = false,
      }
    end,
  },
}
