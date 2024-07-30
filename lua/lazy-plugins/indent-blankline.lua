-- Add indentation guides even on blank lines
local M = { 'lukas-reineke/indent-blankline.nvim' }

M.main = 'ibl'

M.config = function()
  require('ibl').setup()
end

return M
