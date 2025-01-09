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

local transparent_highlights = {
  'Normal',
  'NormalNC',
  'LineNr',
  'Folded',
  'NonText',
  'SpecialKey',
  'VertSplit',
  'SignColumn',
  'EndOfBuffer',
  'TablineFill', -- this might be preference
}


for _, hl in ipairs(transparent_highlights) do
  vim.cmd.highlight(hl .. ' guibg=NONE ctermbg=NONE')
end
