-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Quickly clear highlight
vim.keymap.set('n', '<esc>', ':noh<cr>', { desc = 'Clear highlight' })

-- Tab related keymaps
vim.api.nvim_set_keymap("n", "<leader>n", ":$tabnew<CR>", { noremap = true, desc = 'New tab' })
vim.api.nvim_set_keymap("n", "<leader>x", ":q<CR>", { noremap = true, desc = 'Close current window' })
vim.api.nvim_set_keymap("n", "<tab>", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-tab>", ":tabp<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>o", ":tabonly<CR>", { noremap = true, desc = 'Use current tab as only tab' })
-- vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
-- vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
-- move current tab to next position
-- vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })

-- Window navigation keymaps
vim.api.nvim_set_keymap('n', '<cr>', '<C-w>w', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim: ts=2 sts=2 sw=2 et
