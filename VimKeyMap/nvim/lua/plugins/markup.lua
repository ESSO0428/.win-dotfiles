return {
  -- NOTE: The handling of `concealcursor` in LSP hover markdown rendering
  -- was changed after commit 0022a57. The previous behavior allowed
  -- concealed elements to be visible, but the new version hides them
  -- by default.
  -- If you prefer the old behavior in LSP hover windows, check issue #312
  -- for possible workarounds: [#312](https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/312)
  {
    "MeanderingProgrammer/markdown.nvim",
    commit = "0022a57",
    ft = "markdown",
    main = "render-markdown",
    opts = {},
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("user.config.plugins.MarkdownNvim").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "norg", "org" }, -- ★ 比 VeryLazy 更精準
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("user.config.plugins.headline").setup()
    end,
  },
}
