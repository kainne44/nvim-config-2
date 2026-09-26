-- Prose-friendly window settings for markdown buffers
local opt = vim.opt_local

opt.list = false -- no trailing-space dots in prose

-- 'wrap' itself is handled by wrapping.nvim (soft mode for markdown)
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = 'list:-1' -- wrapped list items align with their text
opt.conceallevel = 2

opt.spell = true
opt.spelllang = 'en'

-- Move by screen line so j/k follow the rendered text. With a count (e.g. 5j from the
-- relative numbers) they still jump by real lines.
local function display_motion(key)
  vim.keymap.set({ 'n', 'x' }, key, function()
    return vim.v.count == 0 and 'g' .. key or key
  end, { buffer = true, expr = true, desc = 'Move by display line' })
end
display_motion 'j'
display_motion 'k'

-- Indent guides draw stray bars under headings in prose
vim.b.snacks_indent = false

-- Bare URLs aren't link nodes in the markdown parser, so their path segments get
-- spell-checked. Mark them with spell=false extmarks.
local url_ns = vim.api.nvim_create_namespace 'markdown_url_nospell'
local function mark_urls(buf)
  vim.api.nvim_buf_clear_namespace(buf, url_ns, 0, -1)
  for lnum, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    for s, e in line:gmatch '()%a[%w+.-]*://[^%s<>()]+()' do
      vim.api.nvim_buf_set_extmark(buf, url_ns, lnum - 1, s - 1, { end_col = e - 1, spell = false })
    end
  end
end
local buf = vim.api.nvim_get_current_buf()
mark_urls(buf)
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
  buffer = buf,
  group = vim.api.nvim_create_augroup('markdown_url_nospell_' .. buf, { clear = true }),
  callback = function()
    mark_urls(buf)
  end,
})

-- gd follows the link under the cursor (relative paths, #anchors, URLs), then falls back to the LSP.
-- Set after LspAttach so it wins over the generic `gd` from lspconfig.lua.
local function map_follow()
  vim.keymap.set('n', 'gd', require('markdown_links').follow, { buffer = buf, desc = 'Follow link' })
end
map_follow()
vim.api.nvim_create_autocmd('LspAttach', { buffer = buf, callback = vim.schedule_wrap(map_follow) })

-- <C-d>/<C-u> scroll half the window in *screen* rows. The built-in counts buffer lines,
-- and one wrapped paragraph or rendered table row can be a whole screen, so it overshoots.
local function half_page(key)
  return function()
    local half = math.max(1, math.floor(vim.api.nvim_win_get_height(0) / 2))
    vim.cmd('normal! ' .. half .. vim.keycode(key))
    vim.cmd 'normal! M'
  end
end
vim.keymap.set('n', '<C-d>', half_page '<C-e>', { buffer = buf, desc = 'Half page down (screen rows)' })
vim.keymap.set('n', '<C-u>', half_page '<C-y>', { buffer = buf, desc = 'Half page up (screen rows)' })

-- ]o / [o jump to the next / previous link ([text](...), [[wiki]], bare URL), like obsidian.nvim
-- does inside its workspaces
local link_pattern = [=[\v\[\zs[^]]+\]\(|\[\[\zs|<\zs\a[[:alnum:]+.-]*://]=]
vim.keymap.set('n', ']o', function()
  vim.fn.search(link_pattern, 'W')
end, { buffer = buf, desc = 'Next link' })
vim.keymap.set('n', '[o', function()
  vim.fn.search(link_pattern, 'bW')
end, { buffer = buf, desc = 'Previous link' })

-- Fold by heading (za toggles a section, zM shows just the outline, zR opens all).
-- Notes open fully expanded.
vim.wo[0][0].foldmethod = 'expr'
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldtext = ''
vim.wo[0][0].foldlevel = 99
