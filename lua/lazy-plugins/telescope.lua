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
    require('telescope.builtin').oldfiles,
    desc = '[?] Find recently opened files'
  },
  {
    '<leader><space>',
    require('telescope.builtin').buffers,
    desc = '[ ] Find existing buffers'
  },
  {
    '<leader>ls',
    require('telescope.builtin').lsp_document_symbols,
    desc = '[S]ymbols (local)'
  },
  {
    '<leader>lS',
    require('telescope.builtin').lsp_dynamic_workspace_symbols,
    desc = '[S]ymbols (workspace)'
  },
  {
    '<leader>ld',
    function(t) require('telescope.builtin').diagnostics(t, 0) end,
    desc = '[D]iagnostics'
  },
  {
    '<leader>ss',
    require('telescope.builtin').builtin,
    desc = '[S]earch [S]elect Telescope'
  },
  {
    '<leader>gf',
    require('telescope.builtin').git_files,
    desc = 'Search [G]it [F]iles'
  },
  {
    '<leader>sf',
    require('telescope.builtin').find_files,
    desc = '[S]earch [F]iles'
  },
  {
    '<leader>sh',
    require('telescope.builtin').help_tags,
    desc = '[S]earch [H]elp'
  },
  {
    '<leader>sw',
    require('telescope.builtin').grep_string,
    desc = '[S]earch current [W]ord'
  },
  {
    '<leader>sg',
    require('telescope.builtin').live_grep,
    desc = '[S]earch by [G]rep'
  },
  {
    '<leader>sG',
    ':LiveGrepGitRoot<cr>',
    desc = '[S]earch by [G]rep on Git Root'
  },
  {
    '<leader>sd',
    require('telescope.builtin').diagnostics,
    desc = '[S]earch [D]iagnostics'
  },
  {
    '<leader>sr',
    require('telescope.builtin').resume,
    desc = '[S]earch [R]esume'
  },
}

return M
