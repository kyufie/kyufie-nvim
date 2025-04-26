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

M.keys = {
  {
    'gr',
    '<cmd>Lspsaga finder ref<CR>',
    desc = '[G]oto [R]eference'
  },
  {
    -- Overrides default keymap
    'gi',
    '<cmd>Lspsaga finder imp<CR>',
    desc = '[G]oto [I]mplementation'
  },
  {
    'gd',
    '<cmd>Lspsaga finder def<CR>',
    desc = '[G]oto [D]efinition'
  },
  {
    'gD',
    '<cmd>Lspsaga diagnostic_jump_next<CR>',
    desc = '[G]oto next [D]iagnostic'
  },
  {
    '<leader>la',
    '<cmd>Lspsaga code_action<CR>',
    desc = 'Code [A]ction'
  },
  {
    '<leader>lr',
    '<cmd>Lspsaga rename<CR>',
    desc = '[R]ename'
  },
  {
    '<leader>lci',
    '<cmd>Lspsaga incoming_calls<CR>',
    desc = '[I]ncoming [C]alls'
  },
  {
    '<leader>lco',
    '<cmd>Lspsaga outgoing_calls<CR>',
    desc = '[O]utgoing [C]alls'
  },
  {
    'K',
    '<cmd>Lspsaga hover_doc<CR>',
    desc = 'Hover Documentation'
  },
}

M.dependencies = {
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-web-devicons',
}

return M
