-- [[ Setting options ]]
-- See `:help vim.o`

-- Highlight spaces and tabs at crucial locations
vim.o.list = true
vim.opt.listchars = {
  -- Leading spaces
  lead = '∙',
  -- Trailing spaces
  trail = '◦',
  --Tabs
  tab = '›-',
}

-- Set highlight on search
vim.o.hlsearch = true

-- Enable line number
vim.o.number = true
-- Enable relative line number for quick navigation
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent (keep indentation for wrapped lines)
vim.o.breakindent = true

-- Indentation
vim.o.shiftwidth = 4
-- Use space instead of tab for indentation
vim.o.expandtab = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Exrc support
vim.o.exrc = true;

-- vim: ts=2 sts=2 sw=2 et
