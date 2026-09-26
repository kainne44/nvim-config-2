return {
  { -- Lua LSP support for the Neovim runtime, config and plugins
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', config = true }, -- must load before dependants
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local builtin = require 'telescope.builtin'

          map('gd', builtin.lsp_definitions, '[G]oto [D]efinition') -- markdown overrides this to follow links
          map('grr', builtin.lsp_references, '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('gW', builtin.lsp_dynamic_workspace_symbols, 'Open [W]orkspace Symbols')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Highlight other references to the word under the cursor while it rests there
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Per-server overrides. Every server installed through :Mason is enabled automatically.
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        -- obsidian.nvim runs its own LSP inside vaults; use markdown-oxide everywhere else
        markdown_oxide = {
          root_dir = function(bufnr, on_dir)
            local path = vim.api.nvim_buf_get_name(bufnr)
            if require('vaults').contains(path) then
              return
            end
            on_dir(vim.fs.root(bufnr, { '.git', '.moxide.toml' }) or vim.fs.dirname(path))
          end,
        },
      }

      local ensure_installed = { 'lua_ls', 'markdown_oxide' }
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        'isort', -- Python import sorter
        'black', -- Python formatter
        'prettier', -- JS/TS/Markdown/JSON/YAML/CSS/HTML formatter
        'vale', -- prose linter (only runs where a .vale.ini exists)
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
      for server_name, server in pairs(servers) do
        vim.lsp.config(server_name, server)
      end

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- handled by mason-tool-installer
        automatic_enable = true,
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
