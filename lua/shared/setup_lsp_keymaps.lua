local M = {}

function M.execute(bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set("n", "gk", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })

  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   buffer = bufnr,
  --   callback = function()
  --     vim.lsp.buf.format()
  --   end,
  -- })
end

return M
