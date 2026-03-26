-- References: https://github.com/nvim-lua/kickstart.nvim
-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
local plugins = {
  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  {
    "LunarVim/bigfile.nvim",
    config = function()
      require("user.bigfile").setup()
    end,
  },
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    -- event = { "BufReadPre", "BufNewFile" }, -- ★ 新增
    event = "User FileOpened",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },
      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false,
          suggestions = 20,
        }, -- use which-key for spelling hints
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
          h = false, -- bindings for hydra with h
        },
      },
      -- triggers = "auto", -- automatically setup triggers
      triggers = { "<leader>" }, -- or specify a list manually
      -- Document existing key chains
      spec = {
        { "<leader>d", group = "[D]ap" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" }, -- 用指令時才載
    version = "*",
    opts = {
      on_config_done = nil,
      -- size can be a number or function which is passed the current terminal
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = false, -- whether or not the open mapping applies in insert mode
      persist_size = false,
      -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      shell = nil, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        border = "curved",
        -- width = <value>,
        -- height = <value>,
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
      },
    },
  },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  { import = "plugins" },
  { import = "plugins.autocomplete" },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    enabled = true,
  },
  {
    "aznhe21/actions-preview.nvim",
    -- event = "VeryLazy",
    event = "User FileOpened",
    config = function()
      require("actions-preview").setup {
        diff = {
          algorithm = "patience",
          ignore_whitespace = true,
        },
        telescope = vim.tbl_extend(
          "force",
          -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
          require("telescope.themes").get_dropdown { initial_mode = "normal" },
          -- a table for customizing content
          {
            -- a function to make a table containing the values to be displayed.
            -- fun(action: Action): { title: string, client_name: string|nil }
            make_value = nil,

            -- a function to make a function to be used in `display` of a entry.
            -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
            -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
            make_make_display = nil,
          }
        ),
      }
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach", -- 或 { "CursorHold", "CursorHoldI" }
    opts = require("user.config.plugins.nvim_lightbulb").opt,
  },
  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>=",
        function()
          require("conform").format { async = true, lsp_format = "fallback" }
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent = true,
    },
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme "tokyonight-night"

      -- You can configure highlights by doing something like:
      vim.cmd.hi "Comment gui=none"
    end,
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil", -- ★ command lazy
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<cr>"] = { "actions.select", mode = "n" },
        ["<tab>"] = { "actions.select", mode = "n" },
        ["<a-l>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Open the entry in a vertical split",
          mode = "n",
        },
        ["<a-k>"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Open the entry in a horizontal split",
          mode = "n",
        },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab", mode = "n" },
        ["gh"] = { "actions.preview", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["`"] = { "actions.refresh", mode = "n" },
        ["<"] = { "actions.parent", mode = "n" },
        [">"] = { "actions.select", mode = "n" },
        ["go"] = { "actions.open_cwd", mode = "n" },
        ["gc"] = { "actions.cd", mode = "n" },
        ["gC"] = {
          "actions.cd",
          opts = { scope = "tab" },
          desc = ":tcd to the current oil directory",
          mode = "n",
        },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = { "actions.open_external", mode = "n" },
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "lfv89/vim-interestingwords",
    -- event = "VeryLazy",
    event = "User FileOpened",
  },
  {
    "Shatur/neovim-session-manager",
    config = function()
      vim.api.nvim_clear_autocmds {
        group = "SessionManager",
        event = "VimEnter",
      }
      local group = vim.api.nvim_create_augroup("SessionManager", { clear = false })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        nested = true,
        callback = function()
          require("session_manager").autoload_session()
        end,
      })
    end,
    keys = {
      { "<leader>S", ":SessionManager save_current_session<cr>", desc = "SessionManager save_current_session" },
    },
  },
  {
    "nvimtools/hydra.nvim",
    -- event = "VeryLazy", -- 只有你真的用 hydra 的時候才會拖一點
    event = "User FileOpened",
    config = function()
      require("user.keymappings.hydra").setup()
    end,
  },
}

-- NOTE: Lazy.nvim settings
local settings = {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  performance = {
    rtp = { reset = false },
  },
}

require("lazy").setup(plugins, settings)

-- NOTE: Here is rebinded keymaps for lazy.nvim
-- use require cover, because lunarvim not builtin it's keymaps
require("lazy.view.config").keys = {
  hover = "gh",
  diff = "d",
  close = "q",
  details = "<cr>",
  profile_sort = "<C-s>",
  profile_filter = "<C-f>",
  abort = "<C-c>",
  next = "]]",
  prev = "[[",
}
require("lazy.view.config").commands.install = {
  button = true,
  desc = "Install missing plugins",
  desc_plugin = "Install a plugin",
  id = 2,
  key = ">",
  key_plugin = ">",
  plugins = true,
}
require("lazy.view.config").commands.log = {
  button = true,
  desc = "Show recent updates",
  desc_plugin = "Show recent updates",
  id = 7,
  key = "O",
  key_plugin = "o",
  plugins = true,
}

local function set_if_command_exists(cmd, value)
  pcall(vim.cmd, cmd .. " " .. value)
end
set_if_command_exists("GuiWindowOpacity", "0.85")

local transparent_highlights = {
  "Normal",
  "NormalNC",
  "LineNr",
  "Folded",
  "NonText",
  "SpecialKey",
  "VertSplit",
  "SignColumn",
  "EndOfBuffer",
  "TablineFill", -- this might be preference
}

for _, hl in ipairs(transparent_highlights) do
  vim.cmd.highlight(hl .. " guibg=NONE ctermbg=NONE")
end
