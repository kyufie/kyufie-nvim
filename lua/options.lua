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

-- Indentation
vim.o.shiftwidth = 4
-- Use space instead of tab for indentation
vim.o.expandtab = true
-- Even though space indent would have the same width as tab indent,
-- both should still be distinguishable from one another (see listchars)
vim.o.tabstop = 4

-- Set highlight on search
vim.o.hlsearch = true

-- Ask for confirmation when doing operations that would normally
-- fail because of unsaved changes
vim.o.confirm = true

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

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- The following options use millisecond as their unit
-- How long should "doing nothing" occur until the swap file is updated
vim.o.updatetime = 250
-- Time to wait for a mapped sequence to complete
vim.o.timeoutlen = 300

-- Wide color range
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Exrc support
vim.o.exrc = true

-- 'vsplit' puts the window to the right
vim.o.splitright = true
-- 'hsplit' puts the window to the bottom
vim.o.splitbelow = true

-- vim: ts=2 sts=2 sw=2 et
