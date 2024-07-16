
local M = { 'romgrk/barbar.nvim' }

M.enabled = false

M.dependencies = {
  'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
}

M.config = function ()
  require('barbar').setup()

  vim.keymap.set('n', '<tab>', ':BufferNext<cr>')
  vim.keymap.set('n', '<leader>x', ':BufferClose<cr>', { desc = 'Close tab/window' })
end

return M
