local M = { 'neovim/nvim-lspconfig' }

local servers = {
  clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--completion-style=detailed',
      '--function-arg-placeholders',
      '--pch-storage=memory'
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = true },
        telemetry = { enable = false },
      }
    },
  },

  -- TODO: Use a git repository
  nixd = {
    settings = {
      nixd = {
        nixpkgs = 'import (builtins.getFlake "/home/kyufie/nixos").inputs.nixpkgs { }   ',
      },

      options = {
        nixos = {
          expr = '(builtins.getFlake "/home/kyufie/nixos").nixosConfigurations.thefoxflat.options'
        }
      }
    },
  },

  rust_analyzer = {},

  ts_ls = {}
}

M.dependencies = {
  { 'j-hui/fidget.nvim', opts = {} },
  { 'folke/lazydev.nvim', opts = {} },
  'hrsh7th/nvim-cmp',
}

M.config = function()
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  vim.lsp.config('*', {
    capabilities = capabilities
  })

  for server_name, opts in pairs(servers) do
    vim.lsp.config(server_name, opts)
    vim.lsp.enable(server_name)
  end
end

M.lazy = false

M.keys = {
  {
    '<leader>wa',
    vim.lsp.buf.add_workspace_folder,
    desc = '[W]orkspace [A]dd Folder'
  },
  {
    '<leader>wr',
    vim.lsp.buf.remove_workspace_folder,
    desc = '[W]orkspace [R]emove Folder'
  },
}

return M
