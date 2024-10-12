-- [[ Basic Keymaps ]]

local keymaps = {
  -- Access to custom keymaps
  {
    { 'n', 'v' },
    '<Space>',
    '<Nop>',
    { silent = true }
  },

  -- Quickly clear highlight
  {
    'n',
    '<esc>',
    ':noh<cr>',
    { desc = 'Clear highlight' }
  },

  -- Tab related keymaps
  {
    'n',
    '<leader>n',
    ':$tabnew<CR>',
    { noremap = true, desc = 'New tab' }
  },
  {
    'n',
    '<leader>x',
    ':q<CR>',
    { noremap = true, desc = 'Close current window' }
  },
  {
    'n',
    '<tab>',
    ':tabn<CR>',
    { noremap = true }
  },
  {
    'n',
    '<S-tab>',
    ':tabp<CR>',
    { noremap = true }
  },

  -- Window navigation keymap
  {
    'n',
    '<cr>',
    '<C-w>w',
    { noremap = true }
  },

  -- For dealing with word wrap
  {
    'n',
    'k',
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true }
  },
  {
    'n',
    'j',
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true }
  },
}

for _, keymap in ipairs(keymaps) do
  vim.keymap.set(unpack(keymap))
end

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
