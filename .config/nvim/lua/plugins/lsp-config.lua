return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd"},
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Minimal on_attach with keymaps
      local on_attach = function(_, bufnr)

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {} )
        vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
      end

      -- Minimal capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = {
        lua_ls = { cmd = { "lua-language-server" }, filetypes = { "lua" } },
        pyright = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" } },
        ts_ls = { cmd = { "typescript-language-server", "--stdio" }, filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
        clangd = { cmd = { "clangd" }, filetypes = { "c", "cpp", "objc", "objcpp" } },
      }


      for name, config in pairs(servers) do
        vim.lsp.start({
          name = name,
          cmd = config.cmd,
          filetypes = config.filetypes,
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end
  }
}
