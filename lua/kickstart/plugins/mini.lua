return {
  { -- Small independent modules
    'echasnovski/mini.nvim',
    config = function()
      -- Around/inside textobjects: va) yinq ci'
      require('mini.ai').setup { n_lines = 500 }
      -- Move lines/selections with <M-hjkl>
      require('mini.move').setup()
      -- Surroundings: saiw) add, sd' delete, sr)' replace
      require('mini.surround').setup()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
