M = { 'folke/snacks.nvim' }

M.lazy = false

---@type snacks.Config
M.opts = {
  bigfile = {},
  indent = {},
  explorer = {
    replace_netrw = true
  },
  scroll = {},
  quickfile = {},
  terminal = {}
}

return M
