-- Fuzzy Finder (files, lsp, etc)
local M = { 'nvim-telescope/telescope.nvim' }

M.branch = '0.1.x'

M.dependencies = {
  'nvim-lua/plenary.nvim',
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}

M.keys = {
  {
    '<leader>?',
    function() require('telescope.builtin').oldfiles() end,
    desc = '[?] Find recently opened files'
  },
  {
    '<leader><space>',
    function() require('telescope.builtin').buffers() end,
    desc = '[ ] Find existing buffers'
  },
  {
    '<leader>ls',
    function() require('telescope.builtin').lsp_document_symbols() end,
    desc = '[S]ymbols (local)'
  },
  {
    '<leader>lS',
    function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
    desc = '[S]ymbols (workspace)'
  },
  {
    '<leader>ld',
    function(t) require('telescope.builtin').diagnostics(t, 0) end,
    desc = '[D]iagnostics'
  },
  {
    '<leader>ss',
    function() require('telescope.builtin').builtin() end,
    desc = '[S]earch [S]elect Telescope'
  },
  {
    '<leader>gf',
    function() require('telescope.builtin').git_files() end,
    desc = 'Search [G]it [F]iles'
  },
  {
    '<leader>sf',
    function() require('telescope.builtin').find_files() end,
    desc = '[S]earch [F]iles'
  },
  {
    '<leader>sh',
    function() require('telescope.builtin').help_tags() end,
    desc = '[S]earch [H]elp'
  },
  {
    '<leader>sw',
    function() require('telescope.builtin').grep_string() end,
    desc = '[S]earch current [W]ord'
  },
  {
    '<leader>sg',
    function() require('telescope.builtin').live_grep() end,
    desc = '[S]earch by [G]rep'
  },
  {
    '<leader>sd',
    function() require('telescope.builtin').diagnostics() end,
    desc = '[S]earch [D]iagnostics'
  },
  {
    '<leader>sr',
    function() require('telescope.builtin').resume() end,
    desc = '[S]earch [R]esume'
  },
}

return M
