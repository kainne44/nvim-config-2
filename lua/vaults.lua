-- Obsidian vaults, shared by obsidian.nvim (note-taking.lua) and the LSP setup
-- (markdown-oxide stays out of these so notes don't get two link servers).
local M = {
  { name = 'personal', path = '~/vaults/personal', overrides = { notes_subdir = 'notes' } },
  { name = 'ai-wiki', path = '~/Documents/ai_projects/wiki' },
}

---@param path string
---@return boolean
function M.contains(path)
  for _, vault in ipairs(M) do
    local root = vim.fs.normalize(vault.path)
    if path == root or vim.startswith(path, root .. '/') then
      return true
    end
  end
  return false
end

return M
