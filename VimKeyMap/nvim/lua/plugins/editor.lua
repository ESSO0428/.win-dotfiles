return {
  { "tpope/vim-surround" },
  { "dhruvasagar/vim-table-mode" },
  {
    "rhysd/clever-f.vim",
    config = function()
      vim.keymap.set("n", ";", "<Plug>(clever-f-repeat-forward)", {})
      vim.keymap.set("n", ",", "<Plug>(clever-f-repeat-back)", {})
    end,
  },
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      config = nil,
      search = {
        mode = "fuzzy",
      },
      modes = {
        char = { enabled = false },
        search = {
          enabled = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>f", mode = { "n", "o", "x" }, function() require("flash").jump() end,       desc = "Flash" },
      { "<leader>F", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r",         mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      -- {
      --   "R",
      --   mode = { "o", "x" },
      --   function() require("flash").treesitter_search() end,
      --   desc =
      --   "Treesitter Search"
      -- },
      {
        "<a-f>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      }
    },
  },
}
