return {
  { "MunifTanjim/nui.nvim" },
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    config = function()
      require("user.config.breadcrumbs").setup()
    end,
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "SmiteshP/nvim-navbuddy",
    deprecated = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>uv", "<cmd>Navbuddy<cr>", desc = "Nav" },
    },
    config = function()
      local actions = require "nvim-navbuddy.actions"
      local navbuddy = require "nvim-navbuddy"
      require("lspconfig").clangd.setup {
        on_attach = function(client, bufnr)
          navbuddy.attach(client, bufnr)
        end,
      }
      navbuddy.setup {
        window = {
          border = "double",
        },
        mappings = {
          ["i"] = actions.previous_sibling(),
          ["k"] = actions.next_sibling(),
          ["j"] = actions.parent(),
          ["l"] = actions.children(),
          ["I"] = actions.previous_sibling(),
          ["K"] = actions.next_sibling(),
          ["<a-Up>"] = actions.move_up(),
          ["<a-Down>"] = actions.move_down(),
          ["h"] = actions.insert_name(),
          ["H"] = actions.insert_scope(),
          ["a"] = actions.append_name(),
          ["A"] = actions.append_scope(),
        },
        lsp = {
          auto_attach = true, -- If set to true, you don't need to manually use attach function
          preference = nil, -- list of lsp server names in order of preference
        },
      }
    end,
  },
}
