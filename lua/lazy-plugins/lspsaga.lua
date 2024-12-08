local M = { 'nvimdev/lspsaga.nvim' }

M.lazy = true

M.opts = {
  border = 'rounded',

  finder = {
    layout = 'float',
    left_width = 0.2,
    keys = {
      quit = '<ESC>',
      toggle_or_open = '<CR>'
    }
  },

  diagnostic = {
    border_follow = true
  },

  symbol_in_winbar = {
    enable = false
  }
}

M.dependencies = {
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-web-devicons',
}

return M
