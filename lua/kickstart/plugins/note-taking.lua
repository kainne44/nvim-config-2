return {
  'obsidian-nvim/obsidian.nvim', -- maintained community fork of epwalsh/obsidian.nvim
  version = '*',
  ft = 'markdown',
  cmd = 'Obsidian',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    legacy_commands = false, -- `:Obsidian new` instead of `:ObsidianNew`
    workspaces = vim.list_slice(require 'vaults', 1), -- see lua/vaults.lua
    ui = { enable = false }, -- render-markdown.nvim handles rendering
    -- Zettelkasten-style IDs: 'My new note' -> '1657296016-my-new-note'
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,
  },
}
