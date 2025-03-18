-- Set filetype for .oml files if not already done
vim.cmd [[
  autocmd BufRead,BufNewFile *.oml set filetype=oml
]]

local lspconfig = require 'lspconfig'

-- Register your custom server "oml_ls" directly with lspconfig.
lspconfig.oml_ls = {
  default_config = {
    -- Replace with the absolute path to your binary.
    cmd = { '~/Documents/hotrod-workspace/oml-lsp/target/debug/oml-lsp' },
    filetypes = { 'oml' },
    -- Use a simple root detection: either find a "catalog.xml" or fall back to current directory.
    root_dir = lspconfig.util.root_pattern 'catalog.xml' or vim.loop.cwd(),
    settings = {},
  },
  docs = {
    description = 'OML LSP server for the Ontological Modeling Language (MVP subset)',
  },
}

-- Set up your custom server
lspconfig.oml_ls.setup {}
