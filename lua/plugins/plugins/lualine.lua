
local M = { 'nvim-lualine/lualine.nvim' }

M.dependencies = { 'nvim-tree/nvim-web-devicons' }

M.opts = {
  options = {
    icons_enabled = true,
    theme = 'everforest',
    section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    component_separators = '',
  },
}

return M