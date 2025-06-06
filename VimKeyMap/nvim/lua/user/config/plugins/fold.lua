-- ufo folding
vim.opt.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "manual"

-- Option 1: lsp settings

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
  require("lspconfig")[ls].setup {
    capabilities = capabilities,
    -- you can add other fields for setting up lsp server in this table
  }
end
local ftMap = {
  vim = "indent",
  python = { "indent" },
  git = "",
}
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" … 󱦶 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end
require("ufo").setup {
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
    local empty_return_filetypes = {
      "org",
      "markdown",
      "copilot-chat",
      "Avante",
    }
    if vim.tbl_contains(empty_return_filetypes, filetype) then
      return ""
    end
    -- if you prefer treesitter provider rather than lsp,
    -- return ftMap[filetype] or {'treesitter', 'indent'}
    return ftMap[filetype]
  end,
  preview = {
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-o>",
      jumpTop = "gg",
      jumpBot = "G",
      switch = "u",
    },
  },
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.api.nvim_buf_get_name(0):match "UfoPreviewFloatWin" then
      vim.opt_local.list = false
      vim.cmd "UfoAttach"
      vim.cmd "UfoEnableFold"
      vim.cmd "normal! zX"
    else
      if vim.wo.foldenable then
        vim.cmd "UfoEnableFold"
      end
    end
  end,
})

function PeekFoldedLinesUnderCursor()
  require("ufo").peekFoldedLinesUnderCursor()
  local winid = require("ufo.preview.floatwin").winid

  if winid ~= nil then
    vim.api.nvim_set_option_value("list", vim.opt.list:get(), { win = winid })
  end
end

vim.keymap.set("n", "<leader>uu", "<cmd>lua PeekFoldedLinesUnderCursor()<cr>")

function Vscode_like_foldLevel_enhance(n)
  require("fold-cycle").close_all()
  n = n - 1
  if n >= 1 then
    for _ = 1, n do
      require("fold-cycle").open()
    end
  end
end

vim.keymap.set("n", "]1", "<cmd>lua Vscode_like_foldLevel_enhance(1)<cr>")
vim.keymap.set("n", "]2", "<cmd>lua Vscode_like_foldLevel_enhance(2)<cr>")
vim.keymap.set("n", "]3", "<cmd>lua Vscode_like_foldLevel_enhance(3)<cr>")
vim.keymap.set("n", "]4", "<cmd>lua Vscode_like_foldLevel_enhance(4)<cr>")
vim.keymap.set("n", "]5", "<cmd>lua Vscode_like_foldLevel_enhance(5)<cr>")
vim.keymap.set("n", "]6", "<cmd>lua Vscode_like_foldLevel_enhance(6)<cr>")
vim.keymap.set("n", "]7", "<cmd>lua Vscode_like_foldLevel_enhance(7)<cr>")
vim.keymap.set("n", "]8", "<cmd>lua Vscode_like_foldLevel_enhance(8)<cr>")
vim.keymap.set("n", "]9", "<cmd>lua Vscode_like_foldLevel_enhance(9)<cr>")

-- global handler
-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
-- require('ufo').setup({
--   fold_virt_text_handler = handler
-- })

-- buffer scope handler
-- will override global handler if it is existed
-- local bufnr = vim.api.nvim_get_current_buf()
-- require('ufo').setFoldVirtTextHandler(bufnr, handler)
