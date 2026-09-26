return {
  {
    'nvim-focus/focus.nvim',
    version = '*',
    config = function()
      require('focus').setup {
        enable = true,
        commands = true,
        autoresize = {
          enable = true,
        },
        ui = {
          signcolumn = false, -- otherwise focus re-enables the sign column in markdown on WinEnter
        },
      }
    end,
  },
}
