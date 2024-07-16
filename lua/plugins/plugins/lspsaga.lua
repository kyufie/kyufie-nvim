local M = { 'nvimdev/lspsaga.nvim' }

M.lazy = true

M.opts = {
  border = 'rounded',

  finder = {
    layout = 'float'
  },

  diagnostic = {
    border_follow = true
  }
}

M.dependencies = {
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-web-devicons',
}

return M
