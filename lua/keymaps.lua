-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Up' })
-- Move things up and down
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
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace All' })

vim.keymap.set('n', '<leader>c', ':bd!<cr>', { desc = 'Close Buffer' })

-- prev / next buffer
vim.keymap.set('n', '<S-Tab>', ':bprev<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<Tab>', ':bnext<cr>', { desc = 'Next Buffer' })

-- oil.nvim open file directory
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- toggle term bindings
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
