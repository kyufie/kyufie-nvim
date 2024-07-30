local M = { 'mawkler/modicator.nvim' }

M.init = function()
    vim.o.cursorline = true
    vim.o.cursorlineopt = 'number'
    vim.o.number = true
    vim.o.termguicolors = true
end

M.opts = { show_warnings = true }

return M
