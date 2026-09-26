-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Save files faster
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Toggle Keymaps
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, desc = '[T]oggle [D]iagnostics' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move things up and down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move Down' })

-- append below to end without moving cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- half page jumping up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half Page Jump Down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half Page Jump Up' })

-- search terms stay in the middle
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next Match' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev Match' })

-- greatest remap ever - prevent overwrite of paste buffer
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Prevent Paste Overwrite' })

-- next greatest remap ever : asbjornHaland - lets you yank to system
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to Sys' })
vim.keymap.set('n', '<leader>Y', '"+Y')

-- lets you replace the word you were on everywhere it occurs
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace word under cursor' })

-- Not `:bd!` -- that silently discards unsaved changes
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>', { desc = '[C]lose Buffer' })

-- prev / next buffer: use the built-in `[b` / `]b` (Neovim 0.11+).
-- Mapping <Tab> breaks <C-i> (jump forward), since terminals send the same key for both.

-- oil.nvim open file directory
vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })

-- -- molten keymaps
-- vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { desc = 'evaluate operator', silent = true })
-- vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { desc = 'open output window', silent = true })
-- vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { desc = 're-eval cell', silent = true })
-- vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'execute visual selection', silent = true })
-- vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { desc = 'close output window', silent = true })
-- vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>', { desc = 'delete Molten cell', silent = true })
-- vim.keymap.set('n', '<localleader>mx', ':MoltenOpenInBrowser<CR>', { desc = 'open output in browser', silent = true })

-- toggleterm window navigation. Only applied to toggleterm buffers so that programs
-- running in other terminals still receive <Esc>, <C-w>, etc.
-- (Exit terminal mode with `jk` via better-escape, or <Esc><Esc>.)
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

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
