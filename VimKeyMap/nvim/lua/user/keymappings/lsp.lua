local map = function(keys, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
end
map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
map("gh", vim.lsp.buf.hover, "documentation hover")
-- map("gm", vim.lsp.buf.signature_help, "signature help")
map("gm", "<cmd>lua require('lsp_signature').toggle_float_win()<cr>", "signature help")
map("gh", vim.lsp.buf.hover, "documentation hover")
map("g;", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Goto type definition")
map("gp", "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>", "Goto type definition (preview)")
map("<leader><a-o>", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", "[G]oto [D]efinition (preview)")
map("<leader>ua", "<cmd>lua require('actions-preview').code_actions()<cr>", "Code Action")
map("gl", function()
  local float = vim.diagnostic.config().float

  if float then
    local config = type(float) == "table" and float or {}
    config.scope = "line"

    vim.diagnostic.open_float(config)
  end
end, "Show line diagnostics")
vim.keymap.set("n", "<", vim.diagnostic.goto_prev, { desc = "goto prev diagnostic", silent = true, nowait = true })
vim.keymap.set("n", ">", vim.diagnostic.goto_next, { desc = "goto next diagnostic", silent = true, nowait = true })
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "Lsp Buffer Format", silent = true, nowait = true })
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "Lsp Buffer Format", silent = true, nowait = true })
