return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'vale' },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          -- Skip read-only buffers such as LSP hover popups
          if not vim.opt_local.modifiable:get() then
            return
          end
          -- vale errors out without a config file, so only run it when one is found
          if vim.bo.filetype == 'markdown' and #vim.fs.find({ '.vale.ini', '_vale.ini' }, { upward = true, path = vim.fn.expand '%:p:h' }) == 0 then
            return
          end
          lint.try_lint()
        end,
      })
    end,
  },
}
