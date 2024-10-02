local M = { 'neovim/nvim-lspconfig' }

-- NOTE: Most mason LSPs aren't compatible with Termux
local use_mason = false
local servers = {
  clangd = {
    cmd = {
      "clangd --background-index --clang-tidy --completion-style=detailed --function-arg-placeholders --pch-storage=memory"
    }
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = true },
      telemetry = { enable = false },
    },
  },
  -- TODO: Use a git repository
  nixd = {
    nixd = {
      nixpkgs = 'import (builtins.getFlake "/home/kyufie/nixos").inputs.nixpkgs { }   ',
    },

    options = {
      nixos = {
        expr = '(builtins.getFlake "/home/kyufie/nixos").nixosConfigurations.thefoxflat.options'
      }
    }
  },
}

M.dependencies = {
  { 'j-hui/fidget.nvim', opts = {} },
  { 'folke/lazydev.nvim', opts = {} },
  'hrsh7th/nvim-cmp',
  'nvim-telescope/telescope.nvim',
  'nvimdev/lspsaga.nvim'
}

if use_mason then
  table.insert(M.dependencies, 'williamboman/mason.nvim')
  table.insert(M.dependencies, 'williamboman/mason-lspconfig.nvim')
end

M.config = function()
  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    local t_builtin = require('telescope.builtin')
    local keybinds = {
      {
        key = 'gr',
        func = '<cmd>Lspsaga finder ref<CR>',
        desc = '[G]oto [R]eference'
      },
      {
        -- Overrides default keymap
        key = 'gi',
        func = '<cmd>Lspsaga finder imp<CR>',
        desc = '[G]oto [I]mplementation'
      },
      {
        key = 'gd',
        func = '<cmd>Lspsaga finder def<CR>',
        desc = '[G]oto [D]efinition'
      },
      {
        key = 'gD',
        func = '<cmd>Lspsaga diagnostic_jump_next<CR>',
        desc = '[G]oto next [D]iagnostic'
      },

      {
        key = '<leader>la',
        func = '<cmd>Lspsaga code_action<CR>',
        desc = 'Code [A]ction'
      },
      {
        key = '<leader>lr',
        func = '<cmd>Lspsaga rename<CR>',
        desc = '[R]ename'
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
        func = '<cmd>Lspsaga incoming_calls<CR>',
        desc = '[I]ncoming [C]alls'
      },
      {
        key = '<leader>lco',
        func = '<cmd>Lspsaga outgoing_calls<CR>',
        desc = '[O]utgoing [C]alls'
      },
      {
        key = '<leader>ld',
        func = function(t) t_builtin.diagnostics(t, 0) end,
        desc = '[D]iagnostics'
      },
      -- See `:help K` for why this keymap
      {
        key = 'K',
        func = '<cmd>Lspsaga hover_doc<CR>',
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
