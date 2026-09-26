-- Follow the markdown link under the cursor.
-- markdown-oxide resolves links by name/vault root and gives up on relative paths like
-- `../../frameworks/x.md#section`, so resolve those ourselves and fall back to the LSP.
local M = {}

local link_types = { inline_link = true, image = true, uri_autolink = true }

---@return string? destination of the inline link under the cursor
local function destination_under_cursor()
  local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
  while ok and node do
    if link_types[node:type()] then
      if node:type() == 'uri_autolink' then
        return (vim.treesitter.get_node_text(node, 0):gsub('^<', ''):gsub('>$', ''))
      end
      for child in node:iter_children() do
        if child:type() == 'link_destination' then
          return vim.treesitter.get_node_text(child, 0)
        end
      end
      return nil
    end
    node = node:parent()
  end
  -- Bare URL under the cursor
  local url = vim.fn.expand '<cWORD>':match '%a[%w+.-]*://[^%s<>()]+'
  return url
end

---GitHub-style heading slug: lowercase, drop punctuation, spaces -> '-'
local function slug(text)
  return (text:lower():gsub('[^%w%s%-_]', ''):gsub('%s', '-'))
end

local function jump_to_anchor(anchor)
  anchor = vim.uri_decode(anchor):lower()
  for lnum, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local heading = line:match '^#+%s+(.-)%s*#*$'
    if heading and slug(heading) == anchor then
      vim.api.nvim_win_set_cursor(0, { lnum, 0 })
      vim.cmd 'normal! zz'
      return
    end
  end
  vim.notify('No heading for #' .. anchor, vim.log.levels.WARN)
end

function M.follow()
  local dest = destination_under_cursor()
  if not dest or dest == '' then
    return vim.lsp.buf.definition() -- wiki links, headings, etc.
  end
  if dest:match '^%a[%w+.-]*:' then
    return vim.ui.open(dest) -- http(s), mailto, ...
  end

  local path, anchor = dest:match '^([^#]*)#?(.*)$'
  if path ~= '' then
    path = vim.fs.normalize(vim.fs.joinpath(vim.fn.expand '%:p:h', vim.uri_decode(path)))
    if vim.fn.filereadable(path) == 0 and vim.fn.isdirectory(path) == 0 then
      return vim.notify('Link target not found: ' .. path, vim.log.levels.WARN)
    end
    vim.cmd.edit(vim.fn.fnameescape(path))
  end
  if anchor ~= '' then
    jump_to_anchor(anchor)
  end
end

return M
