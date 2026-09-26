return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre', 'BufNewFile' },
    cmd = { 'ConformInfo', 'FormatNotes' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    init = function()
      -- Notes written outside nvim (Obsidian app, scripts, agents) skip format-on-save.
      -- :FormatNotes runs prettier over every note in the current vault / repo.
      vim.api.nvim_create_user_command('FormatNotes', function()
        local root = vim.fs.root(0, { '.obsidian', '.git' }) or vim.fn.getcwd()
        local prettier = vim.fn.exepath 'prettier'
        if prettier == '' then
          return vim.notify('prettier not found (install it with :Mason)', vim.log.levels.ERROR)
        end
        vim.notify('Formatting notes in ' .. root)
        vim.system({ prettier, '--write', '--log-level', 'warn', '**/*.md' }, { cwd = root }, vim.schedule_wrap(function(out)
          if out.code ~= 0 then
            return vim.notify('FormatNotes failed:\n' .. out.stderr, vim.log.levels.ERROR)
          end
          vim.cmd 'checktime' -- reload open notes that changed
          vim.notify('Formatted notes in ' .. root)
        end))
      end, { desc = 'Format every markdown note in the current vault with prettier' })
    end,
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- No LSP fallback for languages without a standard style
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        svelte = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        yaml = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
