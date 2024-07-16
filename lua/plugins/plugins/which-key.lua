local M = { 'folke/which-key.nvim' }

M.config = function()
  -- document existing key chains
  require('which-key').add {
    { "<leader>g", group = "[G]it" },
    { "<leader>g_", hidden = true },
    { "<leader>h", group = "Git [H]unk" },
    { "<leader>h_", hidden = true },
    { "<leader>l", group = "[L]SP" },
    { "<leader>l_", hidden = true },
    { "<leader>s", group = "[S]earch" },
    { "<leader>s_", hidden = true },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>t_", hidden = true },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>w_", hidden = true },
  }
  -- register which-key VISUAL mode
  -- required for visual <leader>hs (hunk stage) to work
  require('which-key').add {
    { "<leader>", group = "VISUAL <leader>", mode = "v" },
    { "<leader>h", desc = "Git [H]unk", mode = "v" },
  }
end

return M
