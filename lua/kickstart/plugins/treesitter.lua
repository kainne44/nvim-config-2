-- nvim-treesitter `main` branch (Neovim 0.12+). The plugin now only installs parsers and
-- queries; highlighting/indent are switched on per buffer via the FileType autocmd below.
-- Requires the `tree-sitter` CLI (brew install tree-sitter-cli) and a C compiler.
local parsers = {
  'bash',
  'c',
  'diff',
  'html',
  'json',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'toml',
  'vim',
  'vimdoc',
  'yaml',
}

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'
      ts.install(parsers)

      local available = nil
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          -- Auto-install parsers for languages we open but haven't listed above
          if not vim.treesitter.language.add(lang) then
            available = available or ts.get_available()
            if vim.tbl_contains(available, lang) then
              ts.install(lang):await(vim.schedule_wrap(function()
                if vim.api.nvim_buf_is_valid(args.buf) then
                  pcall(vim.treesitter.start, args.buf, lang)
                end
              end))
            end
            return
          end

          vim.treesitter.start(args.buf, lang)
          if lang ~= 'ruby' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
