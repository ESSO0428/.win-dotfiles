-- Reference : https://github.com/sindrets/diffview.nvim/issues/241
vim.cmd "hi DiffAdd gui=none guifg=none guibg=#2C6468"
vim.cmd "hi DiffChange gui=none guifg=none guibg=#272D43"
vim.cmd "hi DiffText gui=none guifg=none guibg=#4A5B80"
vim.cmd "hi DiffDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffviewDiffAddAsDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffviewDiffDelete gui=none guifg=#3B4252 guibg=none"

-- Left panel
-- "DiffChange:DiffAddAsDelete",
-- "DiffText:DiffDeleteText",
vim.cmd "hi DiffAddAsDelete gui=none guifg=none guibg=#5F3D4D"
vim.cmd "hi DiffDeleteText gui=none guifg=none guibg=#5A1D1D"

-- Right panel
-- "DiffChange:DiffAdd",
-- "DiffText:DiffAddText",
vim.cmd "hi DiffAddText gui=none guifg=none guibg=#2C6468"


function SetWinbar()
  local filename = vim.fn.expand('%:t')
  if filename == '' then
    return ''
  end
  local modified = vim.bo.modified and '*' or ''
  return filename .. modified
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    local filetype = vim.bo.filetype
    local winbar_filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neo-tree",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "alpha",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "Jaq",
      "harpoon",
      "dap-repl",
      "dap-terminal",
      "dapui_console",
      "dapui_hover",
      "lab",
      "notify",
      "noice",
      "neotest-summary",
      "",
    }
    if vim.tbl_contains(winbar_filetype_exclude, filetype) then
      return
    end
    vim.opt_local.winbar = "%{%v:lua.SetWinbar()%}"
  end,
})
