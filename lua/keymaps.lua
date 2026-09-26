-- [[ Keymaps ]]
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Toggles
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, desc = '[T]oggle [D]iagnostics' })
vim.keymap.set('n', '<leader>ts', function()
  vim.wo.spell = not vim.wo.spell
end, { desc = '[T]oggle [S]pell check' })

-- Spelling: ]s / [s jump between misspellings, zg adds the word to spell/en.utf-8.add,
-- zG ignores it for this session only, zw marks a word as wrong, zug / zuG undo those.
vim.keymap.set('n', 'z=', function()
  require('telescope.builtin').spell_suggest()
end, { desc = 'Spelling suggestions' })

-- Terminal: <Esc><Esc> leaves terminal mode (so does `jk` via better-escape)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows: CTRL+<hjkl> moves between splits
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Editing
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move Down' })
vim.keymap.set('n', 'J', 'mzJ`z') -- join lines without moving the cursor
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Prevent Paste Overwrite' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to Sys' })
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace word under cursor' })

-- Scrolling and search keep the cursor centred (markdown overrides <C-d>/<C-u> for wrapped text)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half Page Jump Down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half Page Jump Up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next Match' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev Match' })

-- Buffers
-- Not `:bd!` -- that silently discards unsaved changes
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[C]lose Buffer' })
-- Cycle in bufferline order (`[b` / `]b` also work). Ghostty reports <Tab> and <C-i> as
-- different keys, so <C-i> (jump forward) still works; other terminals may not.
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
-- <leader>1..9 jumps to the buffer with that number in the tab bar
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<cmd>BufferLineGoToBuffer ' .. i .. '<cr>', { desc = 'Go to buffer ' .. i })
end

vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })

-- toggleterm window navigation, only in toggleterm buffers so programs running in
-- other terminals still receive <C-h>, <C-j>, etc.
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Set toggleterm keymaps',
  group = vim.api.nvim_create_augroup('toggleterm-keymaps', { clear = true }),
  pattern = 'term://*toggleterm#*',
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
