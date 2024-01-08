local M = { 'mawkler/modicator.nvim' }

M.dependencies = 'sainnhe/everforest'

M.init = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
end

M.config = function()
    require('modicator').setup()
end

return M
