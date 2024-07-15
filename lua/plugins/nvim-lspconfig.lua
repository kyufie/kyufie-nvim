local M = { 'neovim/nvim-lspconfig' }

-- NOTE: Most mason LSPs aren't compatible with Termux
local use_mason = false
local servers = {
  clangd = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = true },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  nixd = {},
}

M.dependencies = {
  -- Automatically install LSPs to stdpath for neovim
  'williamboman/mason-lspconfig.nvim',
  -- Useful status updates for LSP
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  { 'j-hui/fidget.nvim', opts = {} },
  -- Additional lua configuration, makes nvim stuff amazing!
  'folke/neodev.nvim',
  'hrsh7th/nvim-cmp',
  'folke/which-key.nvim',
  'nvim-telescope/telescope.nvim'
}

if use_mason then
  table.insert(M.dependencies, { 'williamboman/mason.nvim', config = true })
end

M.config = function()
  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    local t_builtin = require('telescope.builtin')
    local keybinds = {
      {
        key = '<leader>lR',
        func = vim.lsp.buf.rename,
        desc = '[R]ename (global)'
      },
      {
        key = '<leader>lr',
        func = t_builtin.lsp_references,
        desc = '[R]eferences (global)'
      },
      {
        key = '<leader>la',
        func = vim.lsp.buf.code_action,
        desc = 'Code [A]ction'
      },
      {
        key = '<leader>li',
        func = t_builtin.lsp_implementations,
        desc = '[I]mplementation'
      },
      {
        key = '<leader>lD',
        func = vim.lsp.buf.declaration,
        desc = '[D]eclaration (cursor)'
      },
      {
        key = '<leader>ld',
        func = t_builtin.lsp_definitions,
        desc = '[D]efinition (cursor)'
      },
      {
        key = '<leader>lt',
        func = t_builtin.lsp_type_definitions,
        desc = '[T]ype Definition'
      },
      {
        key = '<leader>ls',
        func = t_builtin.lsp_document_symbols,
        desc = '[S]ymbols (local)'
      },
      {
        key = '<leader>lS',
        func = t_builtin.lsp_dynamic_workspace_symbols,
        desc = '[S]ymbols (workspace)'
      },
      {
        key = '<leader>lci',
        func = t_builtin.lsp_incoming_calls,
        desc = '[I]ncoming [C]alls (cursor)'
      },
      {
        key = '<leader>lco',
        func = t_builtin.lsp_outgoing_calls,
        desc = '[O]utgoing [C]alls (cursor)'
      },
      {
        key = '<leader>l<space>',
        func = function(t) t_builtin.diagnostics(t, 0) end,
        desc = '[D]iagnostics (buffer)'
      },
      -- See `:help K` for why this keymap
      {
        key = 'K',
        func = vim.lsp.buf.hover,
        desc = 'Hover Documentation'
      },
      {
        key = '<C-k>',
        func = vim.lsp.buf.signature_help,
        desc = 'Signature Documentation'
      },
      {
        key = '<leader>wa',
        func = vim.lsp.buf.add_workspace_folder,
        desc = '[W]orkspace [A]dd Folder'
      },
      {
        key = '<leader>wr',
        func = vim.lsp.buf.remove_workspace_folder,
        desc = '[W]orkspace [R]emove Folder'
      },
      {
        key = '<leader>wl',
        func = function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = '[W]orkspace [L]ist Folders'
      }
    }

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    for _, kb in ipairs(keybinds) do
      nmap(kb.key, kb.func, kb.desc)
    end

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end

  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  if use_mason then
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup()

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }
  else
    for server_name, opts in pairs(servers) do
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = opts,
        filetypes = (opts or {}).filetypes,
      }
    end
  end
end

return M
