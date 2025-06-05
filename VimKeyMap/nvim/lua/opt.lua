-- HACK: #31675 After upgrading to 0.10.3, the Inspect command throws an error
-- Abstract: The `Inspect` command is not functional in Neovim v0.10.3.
-- Reference: [#31675](https://github.com/neovim/neovim/issues/31675)
-- NOTE: If you are using a version higher than v0.10.3, consider commenting out the line below to check if the issue has been resolved.
vim.hl = vim.highlight
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
  let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  set shellquote= shellxquote=
]]
-- NOTE: Neovim writes session data (registers, marks, etc.) to the `main.shada` file on exit.
-- Sometimes, it creates temporary files like `main.shada.tmp.x`, but if many of these accumulate (e.g. .tmp.a to .tmp.z),
-- Neovim may fail to write and show error E138: "All tmp.X files exist, cannot write ShaDa file".
-- To prevent this, we automatically remove empty `.tmp.*` files in the shada directory during shutdown.
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local uv = vim.loop
    local path = vim.fn.stdpath "data" .. "\\shada"
    local pattern = "^main%.shada%.tmp%.([a-z])$"

    local fs = uv.fs_scandir(path)
    if not fs then
      return
    end

    -- { {name=..., full=..., size=..., suffix=...}, ... }
    local tmp_files = {}

    for name in
      function()
        return uv.fs_scandir_next(fs)
      end
    do
      local suffix = name:match(pattern)
      if suffix then
        local fullpath = path .. "\\" .. name
        local stat = uv.fs_stat(fullpath)
        if stat then
          table.insert(tmp_files, {
            name = name,
            full = fullpath,
            size = stat.size,
            suffix = suffix,
          })
        end
      end
    end

    -- Delete empty shada tmp
    for _, file in ipairs(tmp_files) do
      if file.size == 0 then
        uv.fs_unlink(file.full)
      end
    end

    -- Delete shada tmp only keep one
    local non_empty = vim.tbl_filter(function(f)
      return f.size > 0
    end, tmp_files)
    if #non_empty > 1 then
      table.sort(non_empty, function(a, b)
        return a.suffix < b.suffix
      end)

      for i = 1, #non_empty - 1 do
        uv.fs_unlink(non_empty[i].full)
      end
    end
  end,
  desc = "Smart cleanup of ShaDa tmp files",
})

-- References: https://github.com/nvim-lua/kickstart.nvim
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.opt.spell = true
vim.opt.spelllang = "en,cjk"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.g.have_nerd_font = true
vim.opt.listchars:append "space:·"

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- signcolumn
vim.wo.signcolumn = "auto:3-6"

-- conceal
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

-- lunarvim default options
local default_options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
  foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smartcase = true, -- smart case
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
  sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
  showcmd = false,
  ruler = false,
  laststatus = 3,
}

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

vim.cmd "source $HOME/AppData/Local/nvim/keymap.vim"
