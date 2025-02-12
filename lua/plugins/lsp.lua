local M = {}

function M.setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- LSP servers setup
  local servers = { "pyright", "ts_ls", "rust_analyzer", "eslint" }
  for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        require('shared.setup_lsp_keymaps').execute(bufnr)
      end,
      settings = {
        eslint = {
          eslint = true,
          format = true,
          quiet = false,
          validate = "on",
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue"
          },
        },
      },
    })
  end
end

return M
