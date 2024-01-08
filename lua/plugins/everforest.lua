local M = { 'sainnhe/everforest' }

M.config = function()
  vim.g.everforest_disable_italic_comment = 1
  vim.g.everforest_background = 'medium'
  vim.cmd.colorscheme('everforest')
end

return M
