vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  close_events = { "BufHidden", "InsertLeave" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
vim.diagnostic.config {
  float = { border = "rounded" },
}

-- HACK: Temporary fix for `_str_utfindex_enc` (reverted to `0.10.1 behavior`).
-- `Neovim 0.10.2` introduced stricter boundary checks, causing LSP completion
-- issues (e.g., `marksman`) with CJK characters. This override removes these
-- stricter checks. The issue remains unfixed in 0.10.4. When `Neovim 0.11` or
-- a patched version (e.g., `0.10.5`) is available, comment out this override
-- to test native behavior.
require("vim.lsp.util")._str_utfindex_enc = function(line, index, encoding)
  if not encoding then
    encoding = "utf-16"
  end
  if encoding == "utf-8" then
    if index then
      return index
    else
      return #line
    end
  elseif encoding == "utf-16" then
    local _, col16 = vim.str_utfindex(line, index)
    return col16
  elseif encoding == "utf-32" then
    local col32, _ = vim.str_utfindex(line, index)
    return col32
  else
    error("Invalid encoding: " .. vim.inspect(encoding))
  end
end
