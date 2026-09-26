-- Skip spell checking for tokens that are never words (URLs, IDs, numbers, handles, tags).
-- Neovim has no pattern-based spell ignore when treesitter highlights a buffer, so matches
-- are covered with `spell = false` extmarks. Acronyms, file names and identifiers are
-- deliberately still checked so typos in them show up: add real ones with `zg`
-- (spell/en.utf-8.add). Code in backticks / fenced blocks is never spell-checked.
local M = {}

-- Each entry is checked against every whitespace-separated token (surrounding punctuation
-- trimmed). A token that matches any of them is not spell-checked.
M.patterns = {
  '^%a[%w+.-]*://', -- URLs: https://…, obsidian://…
  '^%a+:%d', -- prefixed IDs: arxiv:2210.03629, doi:10.1000/…
  '^%d', -- numbers, ordinals, sizes: 95th, 10k, 2x, 5th–95th
  '^%a%d+$', -- one letter + digits (versions, IDs, headings): v2, B6, H1, R1
  '^[vV]%d', -- version strings: v2.1.278, v1.x
  '^@[%w_-]+', -- handles: @karpathy
  '^#[%w_/-]+$', -- tags: #reading, #project/llm
  '^[\128-\255][\128-\255]?[\128-\255]?[\128-\255]?$', -- lone symbols/Greek letters: α, τ, κ
}

local ns = vim.api.nvim_create_namespace 'spell_ignore'

---@param token string
local function ignored(token)
  for _, pat in ipairs(M.patterns) do
    if token:find(pat) then
      return true
    end
  end
  return false
end

---Trim surrounding punctuation such as ( ) , . ; : " ' * _ ` [ ]
---@return integer offset of the trimmed text within `token`
---@return string trimmed
local function trim(token)
  local lead = token:match '^[%(%[%{"\'`*_<]*'
  return #lead, (token:sub(#lead + 1):gsub('[%)%]%}"\'`*_>,.;:!?]*$', ''))
end

---Mark matching tokens in `buf` as not-to-be-spell-checked
---@param buf integer
function M.mark(buf)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for lnum, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    local function skip(col, len)
      vim.api.nvim_buf_set_extmark(buf, ns, lnum - 1, col, { end_col = col + len, spell = false })
    end
    for start, token in line:gmatch '()(%S+)' do
      local offset, core = trim(token)
      if #core > 1 and ignored(core) then
        skip(start - 1 + offset, #core)
      else
        -- Also check the pieces of joined tokens: H1–H5, B14/B12, F1/F2, [B9](…), AIDE+o1-preview
        local pieces = token:gsub('\226\128[\147\148]', '   '):gsub('[/%-+|%[%]()]', ' ') -- dashes, / - + | [ ] ( )
        for pstart, piece in pieces:gmatch '()(%S+)' do
          local poffset, pcore = trim(piece)
          if #pcore > 1 and ignored(pcore) then
            skip(start - 1 + pstart - 1 + poffset, #pcore)
          end
        end
      end
    end
  end
end

---Keep `buf` marked as it changes
---@param buf integer
function M.attach(buf)
  M.mark(buf)
  vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
    buffer = buf,
    group = vim.api.nvim_create_augroup('spell_ignore_' .. buf, { clear = true }),
    callback = function()
      M.mark(buf)
    end,
  })
end

return M
