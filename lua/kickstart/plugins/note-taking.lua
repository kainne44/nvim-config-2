-- Plugin folder for trying out different notes plugins
return {
  -- obsidian.nvim
  'obsidian-nvim/obsidian.nvim', -- maintained community fork of epwalsh/obsidian.nvim
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown',
  cmd = 'Obsidian',
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    legacy_commands = false, -- use `:Obsidian new` etc. instead of `:ObsidianNew`
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
        overrides = {
          notes_subdir = 'notes',
        },
      },
    },
    ui = { enable = false }, -- markdown rendering is handled by render-markdown.nvim
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,
  },
}
