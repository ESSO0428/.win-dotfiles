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
require("lazy").setup({
  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  { "tpope/vim-surround" },
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
    event = { "BufReadPre", "BufNewFile" }, -- ★ 新增
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

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`

      local actions = require "telescope.actions"
      local action_layout = require "telescope.actions.layout"
      local custom_layout_config = {
        -- scroll_speed = 1,
        width = 0.95,
        height = 0.65,
        prompt_position = "top",
        -- preview_width   = 0.50
        horizontal = {
          -- scroll_speed = 1,
          width = 0.95,
          height = 0.65,
          mirror = false,
        },
        vertical = {
          -- scroll_speed = 1,
          width = 0.95,
          height = 0.95,
          preview_height = 0.50,
          mirror = true,
        },
      }
      require("telescope").setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = custom_layout_config,
          mappings = {
            -- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            n = {
              ["q"] = {
                actions.close,
                type = "action",
                opts = { nowait = true, silent = true },
              },
              ["k"] = actions.move_selection_next,
              ["i"] = actions.move_selection_previous,
              -- ["<Left>"] = actions.preview_scrolling_left,
              -- ["<Right>"] = actions.preview_scrolling_right,
              -- ["<C-Left>"] = actions.preview_scrolling_left,
              -- ["<C-Right>"] = actions.preview_scrolling_right,
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<c-f>"] = actions.preview_scrolling_up,
              ["<c-d>"] = actions.preview_scrolling_down,
              ["<ScrollWheelUp>"] = actions.move_selection_previous,
              ["<ScrollWheelDown>"] = actions.move_selection_next,
              ["<LeftMouse>"] = function()
                vim.defer_fn(function()
                  vim.api.nvim_input "<cr>"
                end, 100)
              end,
              ["<C-q>"] = function(...)
                actions.smart_send_to_qflist(...)
                actions.open_qflist(...)
              end,
              ["<C-j>"] = function(...)
                actions.toggle_selection(...)
                actions.move_selection_better(...)
              end,
              ["<C-l>"] = function(...)
                actions.toggle_selection(...)
                actions.move_selection_worse(...)
              end,
              ["<c-k>"] = actions.toggle_all,
              ["<a-=>"] = actions.select_all,
              ["<a-->"] = actions.drop_all,
              ["<a-t>"] = actions.select_tab,
              ["<a-m>"] = actions.select_tab,
              ["<a-l>"] = actions.select_vertical,
              ["<a-k>"] = actions.select_horizontal,
              ["<a-d>"] = action_layout.toggle_preview,
              ["<c-p>"] = action_layout.cycle_layout_next,
              ["<c-u>"] = actions.preview_scrolling_up,
              ["<c-o>"] = actions.preview_scrolling_down,
            },
            i = {
              ["<c-v>"] = function()
                local paste = vim.fn["PasteWithoutTrailingNewline"]
                local text = paste "i"
                vim.api.nvim_put({ text }, "c", true, true)
              end,
              -- ['<cr>'] = function()
              --   vim.api.nvim_input('<Esc>')
              --   vim.defer_fn(function()
              --     vim.api.nvim_input('<cr>')
              --   end, 100)
              -- end,
              -- ["<C-Left>"] = actions.preview_scrolling_left,
              -- ["<C-Right>"] = actions.preview_scrolling_right,
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<c-f>"] = actions.preview_scrolling_up,
              ["<c-d>"] = actions.preview_scrolling_down,
              ["<ScrollWheelUp>"] = actions.move_selection_previous,
              ["<ScrollWheelDown>"] = actions.move_selection_next,
              ["<LeftMouse>"] = function()
                vim.defer_fn(function()
                  vim.api.nvim_input "<cr>"
                end, 100)
              end,
              ["<C-q>"] = function(...)
                actions.smart_send_to_qflist(...)
                actions.open_qflist(...)
              end,
              ["<C-j>"] = function(...)
                actions.toggle_selection(...)
                actions.move_selection_better(...)
              end,
              ["<C-l>"] = function(...)
                actions.toggle_selection(...)
                actions.move_selection_worse(...)
              end,
              ["<c-k>"] = actions.toggle_all,
              ["<a-=>"] = actions.select_all,
              ["<a-->"] = actions.drop_all,
              ["<a-t>"] = actions.select_tab,
              ["<a-m>"] = actions.select_tab,
              ["<a-l>"] = actions.select_vertical,
              ["<a-k>"] = actions.select_horizontal,
              ["<a-d>"] = action_layout.toggle_preview,
              ["<c-p>"] = action_layout.cycle_layout_next,
              ["<c-u>"] = actions.preview_scrolling_up,
              ["<c-o>"] = actions.preview_scrolling_down,
            },
          },
        },
        pickers = {
          buffers = {
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>uw", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>ur", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>ss", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- Slightly advanced example of overriding default behavior and theme

      vim.keymap.set("n", "<c-f>", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find()
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader><c-f>", function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
      end, { desc = "[S]earch [/] in Open Files" })
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>sz",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)

      local origin_get_previewer = require("telescope-undo.previewer").get_previewer
      local previewers = require "telescope.previewers"
      local is_wsl = (function()
        local output = vim.fn.systemlist "uname -r"
        return not not string.find(output[1] or "", "WSL")
      end)()
      local has_powershell = vim.fn.executable "powershell" == 1
      local has_bash = vim.fn.executable "bash" == 1
      require("telescope-undo.previewer").get_previewer = function(o)
        o = o or {}
        if
          o.use_custom_command == nil
          and not (o.use_delta and not is_wsl and (has_powershell or has_bash) and vim.fn.executable "delta" == 1)
        then
          return previewers.new_buffer_previewer {
            -- this is not the prettiest preview...
            define_preview = function(self, entry, _)
              vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, true, vim.split(entry.value.diff, "\n"))
              require("telescope.previewers.utils").highlighter(
                self.state.bufnr,
                "diff",
                { preview = { treesitter = { enable = true } } }
              )
            end,
          }
        else
          return origin_get_previewer(o)
        end
      end
      require("telescope").load_extension "undo"
    end,
  },
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
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    deprecated = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "[a", function()
        require("treesitter-context").go_to_context()
      end, { silent = true, nowait = true })
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
    deprecated = {
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    enabled = true,
  },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- ★ 新增
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      require("lspconfig.ui.windows").default_options.border = "rounded"
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("<a-o>", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- map("gh", vim.lsp.buf.hover(), "documentation hover")
          -- map("gm", vim.lsp.buf.signature_help(), "documentation hover")

          -- Find references for the word under your cursor.
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("<leader>v", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          -- map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>uh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      if vim.g.have_nerd_font then
        local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup {
        ui = {
          check_outdated_packages_on_open = true,
          width = 0.8,
          height = 0.9,
          border = "rounded",
          keymaps = {
            toggle_package_expand = "<cr>",
            install_package = ">",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
          },
        },

        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },
      }
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    event = "VeryLazy",
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
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    -- commit = "4f07545",
    event = "LspAttach",
    opts = {
      finder = {
        max_height = 0.5,
        min_width = 30,
        force_max_height = false,
        keys = {
          shuttle = "<c-s>",
          toggle_or_open = { "l", "<cr>" },
          vsplit = "<a-l>",
          split = "<a-k>",
          tabe = "t",
          tabnew = "r",
          quit = { "q", "<ESC>", "<leader>q" },
          -- close = '<ESC>',
        },
      },
      outline = {
        enable = false,
        win_position = "right",
        win_with = "",
        win_width = 30,
        preview_width = 0.4,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        auto_resize = false,
        custom_sort = nil,
        keys = {
          toggle_or_jump = "l",
          jump = { "<cr>", "o" },
          quit = { "q", "<ESC>", "<leader>q" },
        },
      },
      symbol_in_winbar = {
        enable = false,
        separator = " ",
        ignore_patterns = {},
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = true,
      },
      lightbulb = {
        enable = false,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
      },
      callhierarchy = {
        enable = true,
        layout = "normal",
        keys = {
          edit = "e",
          vsplit = "<a-l>",
          split = "<a-k>",
          tabe = "t",
          quit = { "q", "<ESC>", "<leader>q" },
          shuttle = "<c-s>",
          toggle_or_req = { "l", "<cr>" },
          close = "<C-c>k",
        },
      },
    },
    deprecated = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("lsp_signature").on_attach()
      require("lsp_signature").setup {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded",
        },
        hint_prefix = "🌟 ",
      }
    end,
  },
  {
    "rmagatti/goto-preview",
    event = "VeryLazy",
    config = function()
      require("goto-preview").setup {
        post_open_hook = function(_, win)
          -- Close the current preview window with <Esc>
          vim.keymap.set("n", "q", function()
            vim.api.nvim_win_close(win, true)
          end, { buffer = true, nowait = true })
        end,
      }
    end,
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
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      "saadparwaiz1/cmp_luasnip",

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require "cmp"
      local cmp_mapping = require "cmp.config.mapping"
      local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
      if not status_cmp_ok then
        return
      end
      local ConfirmBehavior = cmp_types.ConfirmBehavior
      local SelectBehavior = cmp_types.SelectBehavior
      local luasnip = require "luasnip"
      luasnip.config.setup {}

      local original_cmp_path_dirname = require("cmp_path")._dirname

      require("cmp_path").get_trigger_characters = function()
        return { "/", ".", "'", '"', ":" }
      end
      require("cmp_path")._dirname = function(self, params, option)
        local original_return = original_cmp_path_dirname(self, params, option)
        if original_return ~= nil then
          return original_return
        end
        local NAME_REGEX = "\\%([^/\\\\:\\*?<>'\"`\\|]\\)"
        local PATH_REGEX = vim.regex(([[\%([/"\']PAT\+\)*[/"\']\zePAT*$]]):gsub("PAT", NAME_REGEX))
        local cursor_line = params.context.cursor_before_line

        local s = PATH_REGEX:match_str(cursor_line)

        if s then
          local buf_dirname = option.get_cwd(params)
          local dirname = string.gsub(string.sub(cursor_line, s + 2), "%a*$", "") -- exclude '/'
          local prefix = string.sub(cursor_line, 1, s + 1) -- include '/'
          if prefix:match '"$' or prefix:match "'$" then
            return vim.fn.resolve(buf_dirname .. "/" .. dirname)
          end
        end

        local orgmode_s = cursor_line:find "%[%[file:"
        if orgmode_s then
          local buf_dirname = option.get_cwd(params)
          local dirname = string.gsub(string.sub(cursor_line, orgmode_s + 7), "%a*$", "") -- exclude '/'
          local prefix = string.sub(cursor_line, 7, orgmode_s + 7) -- include '/'
          if prefix:match ":/$" then
            return vim.fn.resolve("/" .. dirname)
          end
        end

        return nil
      end

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      ---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
      ---@param dir number 1 for forward, -1 for backward; defaults to 1
      ---@return boolean true if a jumpable luasnip field is found while inside a snippet
      local function jumpable(dir)
        local win_get_cursor = vim.api.nvim_win_get_cursor
        local get_current_buf = vim.api.nvim_get_current_buf

        ---sets the current buffer's luasnip to the one nearest the cursor
        ---@return boolean true if a node is found, false otherwise
        local function seek_luasnip_cursor_node()
          -- TODO(kylo252): upstream this
          -- for outdated versions of luasnip
          if not luasnip.session.current_nodes then
            return false
          end

          local node = luasnip.session.current_nodes[get_current_buf()]
          if not node then
            return false
          end

          local snippet = node.parent.snippet
          local exit_node = snippet.insert_nodes[0]

          local pos = win_get_cursor(0)
          pos[1] = pos[1] - 1

          -- exit early if we're past the exit node
          if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil

              return false
            end
          end

          node = snippet.inner_first:jump_into(1, true)
          while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
              or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- Past unmarked exit node, exit early
            if n_next == nil or n_next == snippet.next then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil

              return false
            end

            if candidate then
              luasnip.session.current_nodes[get_current_buf()] = node
              return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
            if not ok then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil

              return false
            end
          end

          -- No candidate, but have an exit node
          if exit_node then
            -- to jump to the exit node, seek to snippet
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
          end

          -- No exit node, exit from snippet
          snippet:remove_from_jumplist()
          luasnip.session.current_nodes[get_current_buf()] = nil
          return false
        end

        if dir == -1 then
          return luasnip.in_snippet() and luasnip.jumpable(-1)
        else
          return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
        end
      end
      local cmp_confirm_opts = {
        behavior = ConfirmBehavior.Replace,
        select = false,
      }
      local cmp_formatting_source_names = {
        buffer = "(Buffer)",
        calc = "(Calc)",
        cmp_tabnine = "(Tabnine)",
        copilot = "(Copilot)",
        ["copilot-chat"] = "(copilot-chat)",
        dap = "(dap)",
        emoji = "(Emoji)",
        ["html-css"] = "(html-css)",
        jupynium = "(jupynium)",
        jupyter = "(jupyter)",
        lazydev = "(lazydev)",
        luasnip = "(L-Snippet)",
        nvim_lsp = "(LSP)",
        orgmode = "(orgmode)",
        path = "(Path)",
        tmux = "(TMUX)",
        treesitter = "(TreeSitter)",
        ultisnips = "(U-Snippet)",
        ["vim-dadbod-completion"] = "(dadbod-sql)",
        vsnip = "(V-Snippet)",
      }
      local cmp_formatting_duplicates = {
        ["html-css"] = 1,
        buffer = 1,
        path = 1,
        nvim_lsp = 1,
        luasnip = 1,
        ultisnips = 1,
        vsnip = 1,
      }
      local cmp_duplicates_default = 0

      cmp.setup {
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered {
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          },
        },
        -- completion = { completeopt = "menu,menuone,noinsert" },
        completion = {
          ---@usage The minimum length of a word to complete on.
          keyword_length = 1,
        },
        experimental = {
          ghost_text = true,
          native_menu = false,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local max_width = 0
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. require("user.config.icons").ui.Ellipsis
            end

            -- tailwindcss color preview
            --[[
            local doc = entry.completion_item.documentation
            if vim_item.kind == "Color" and doc then
              local utils = require "tailwind-tools.utils"
              local content = type(doc) == "string" and doc or doc.value
              local base, _, _, _r, _g, _b = 10, content:find "rgba?%((%d+), (%d+), (%d+)"

              if not _r then
                base, _, _, _r, _g, _b = 16, content:find "#(%x%x)(%x%x)(%x%x)"
              end

              if _r then
                local r, g, b = tonumber(_r, base), tonumber(_g, base), tonumber(_b, base)
                vim_item.kind_hl_group = utils.set_hl_from(r, g, b, "foreground")
              end
            end
            --]]

            vim_item.kind = require("user.config.icons").kind[vim_item.kind]

            if entry.source.name == "copilot" then
              if vim.bo.filetype == "prompt" then
                return
              end
              vim_item.kind = require("user.config.icons").git.Octoface
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            end
            if entry.source.name == "copilot-chat" then
              vim_item.kind = require("user.config.icons").git.Octoface
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            end
            if entry.source.name == "cmp_tabnine" then
              vim_item.kind = require("user.config.icons").misc.Robot
              vim_item.kind_hl_group = "CmpItemKindTabnine"
            end

            if entry.source.name == "crates" then
              vim_item.kind = require("user.config.icons").misc.Package
              vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            if entry.source.name == "lab.quick_data" then
              vim_item.kind = require("user.config.icons").misc.CircuitBoard
              vim_item.kind_hl_group = "CmpItemKindConstant"
            end

            if entry.source.name == "emoji" then
              vim_item.kind = require("user.config.icons").misc.Smiley
              vim_item.kind_hl_group = "CmpItemKindEmoji"
            end

            if entry.source.name == "orgmode" then
              -- vim_item.kind = ""
              -- vim_item.kind_hl_group = "CmpItemKindCopilot"
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if ok then
                local icon, icon_highlight_group = devicons.get_icon(vim.fn.expand "%:t")
                if icon == nil then
                  icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
                end
                vim_item.kind = icon
                vim_item.kind_hl_group = icon_highlight_group
              end
            end
            if entry.source.name == "vim-dadbod-completion" then
              vim_item.kind = ""
              vim_item.kind_hl_group = "CmpItemKindEmoji"
            end
            vim_item.menu = cmp_formatting_source_names[entry.source.name]
            vim_item.dup = cmp_formatting_duplicates[entry.source.name] or cmp_duplicates_default

            if entry.source.name == "html-css" then
              -- vim_item.menu = entry.source.menu
              vim_item.menu = "(html-css)" .. " " .. entry.completion_item.menu
            end
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp_mapping.preset.insert {
          -- ["<M-i>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
          ["<M-i>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              -- cmp.select_prev_item()
              cmp.select_prev_item { behavior = SelectBehavior.Select }
            else
              cmp.complete()
              --fallback()
            end
          end, { "i", "c" }),
          ["<M-k>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              -- cmp.select_next_item()
              cmp.select_next_item { behavior = SelectBehavior.Select }
            else
              cmp.complete()
              --fallback()
            end
          end, { "i", "c" }),
          ["<M-j>"] = cmp.mapping(cmp_mapping.abort(), { "i", "c" }),
          -- ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
          ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
          ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
          ["<C-u>"] = cmp_mapping.scroll_docs(-4),
          ["<C-o>"] = cmp_mapping.scroll_docs(4),
          ["<M-l>"] = cmp_mapping {
            -- i = cmp_mapping.confirm { behavior = ConfirmBehavior.Replace, select = false },
            i = cmp_mapping.confirm { cmp_confirm_opts },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<M-d>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              -- cmp.complete()
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<M-a>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- ["<C-Space>"] = cmp_mapping.complete(),
          -- ["<C-e>"] = cmp_mapping.abort(),
          ["<CR>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              local confirm_opts = vim.deepcopy(cmp_confirm_opts) -- avoid mutating the original opts below
              local is_insert_mode = function()
                return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
              end
              if is_insert_mode() then -- prevent overwriting brackets
                confirm_opts.behavior = ConfirmBehavior.Insert
              end
              local entry = cmp.get_selected_entry()
              local is_copilot = entry and entry.source.name == "copilot"
              -- if is_copilot then
              --   confirm_opts.behavior = ConfirmBehavior.Replace
              --   confirm_opts.select = true
              -- end
              if cmp.confirm(confirm_opts) then
                return -- success, exit early
              end
            end
            fallback() -- if not exited early, always fallback
          end),
        },
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                local max_size = 100000 -- 设置文件大小限制为 100,000 字节
                local bufs = {}

                -- 获取当前 Tab 中的所有窗口
                local windows = vim.api.nvim_tabpage_list_wins(0)
                for _, win in ipairs(windows) do
                  -- 获取每个窗口的缓冲区编号
                  local buf = vim.api.nvim_win_get_buf(win)
                  -- 检查文件类型是否不是 neo-tree
                  if vim.api.nvim_get_option_value("filetype", { buf = buf }) ~= "neo-tree" then
                    -- 检查文件大小
                    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
                    if size > 0 and size < max_size then
                      bufs[buf] = true
                    end
                  end
                end

                return vim.tbl_keys(bufs)
              end,
            },
          },
        },
      }
    end,
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
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
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
  -- Status Line and Bufferline
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      local files = require "mini.files"
      files.setup {
        options = {
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = true,
          -- Whether to use for editing directories
          use_as_default_explorer = false,
        },
        mappings = {
          close = "<leader>q",
          go_in = "l",
          go_in_plus = "L",
          go_out = "j",
          go_out_plus = "J",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "S",
          trim_left = "<",
          trim_right = ">",
        },
      }
      local minifiles_toggle = function(...)
        if not MiniFiles.close() then
          MiniFiles.open(...)
        end
      end

      local minicurrentfiles_toggle = function(...)
        if not MiniFiles.close() then
          local get_parent = vim.fs.dirname
          local exists = function(path)
            return vim.loop.fs_stat(path) ~= nil
          end
          local path = vim.api.nvim_buf_get_name(0)

          while not exists(path) do
            path = get_parent(path)
          end
          MiniFiles.open(path)
        end
      end
      vim.api.nvim_create_user_command("MiniFilesToggle", function()
        minifiles_toggle()
      end, {})
      vim.api.nvim_create_user_command("MiniCurrentFilesToggle", function()
        minicurrentfiles_toggle()
      end, {})
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      -- require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require "mini.statusline"
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
    keys = {
      { "<leader>-", "<cmd>MiniFilesToggle<cr>", desc = "Toggle mini file explorer" },
      { "<leader>_", "<cmd>MiniCurrentFilesToggle<cr>", desc = "Toggle mini current file explorer" },
      { "<leader>+", "<cmd>MiniCurrentFilesToggle<cr>", desc = "Toggle mini current file explorer" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    -- event = "VimEnter",
    event = "VeryLazy", -- 或 "UIEnter"
    config = function()
      vim.g.vim_pid = vim.fn.getpid()
      require("lualine").setup {
        sections = {
          lualine_c = {},
          lualine_x = {
            { 'vim.api.nvim_call_function("getcwd", {0})' },
            { "encoding" },
            { "fileformat" },
            { "filetype", icon_only = false },
            {
              "pid",
              fmt = function()
                return "pid:" .. vim.g.vim_pid
              end,
            },
          },
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" }, -- ★ 新增
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
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
    event = "VeryLazy",
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
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy", -- ★ 新增
    dependencies = {
      "ESSO0428/tabline.nvim",
      dependencies = { "fgheng/winbar.nvim", "nvim-lualine/lualine.nvim", "nvim-tree/nvim-web-devicons" },
      config = function()
        require("tabline").setup {
          enable = false,
          options = {
            show_tabs_always = true,
          },
        }
        vim.cmd [[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
      end,
    },
    config = function()
      local function is_ft(b, ft)
        return vim.bo[b].filetype == ft
      end
      local function custom_filter(buf, buf_nums)
        local logs = vim.tbl_filter(function(b)
          return is_ft(b, "log")
        end, buf_nums or {})
        if vim.tbl_isempty(logs) then
          return true
        end
        local tab_num = vim.fn.tabpagenr()
        local last_tab = vim.fn.tabpagenr "$"
        local is_log = is_ft(buf, "log")
        if last_tab == 1 then
          return true
        end
        -- only show log buffers in secondary tabs
        return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
      end
      local function diagnostics_indicator(num, _, diagnostics, _)
        local result = {}
        local symbols = {
          error = "",
          warning = "",
          info = "",
        }
        for name, count in pairs(diagnostics) do
          if symbols[name] and count > 0 then
            table.insert(result, symbols[name] .. " " .. count)
          end
        end
        result = table.concat(result, " ")
        return #result > 0 and result or ""
      end

      local ok_bufferline, bufferline = pcall(require, "bufferline")
      if not ok_bufferline then
        return
      end

      local status_ok, bufferline = pcall(require, "bufferline")
      if not status_ok then
        return
      end

      -- can't be set in settings.lua because default tabline would flash before bufferline is loaded
      vim.opt.showtabline = 2
      bufferline.setup {
        on_config_done = nil,
        highlights = {
          background = {
            italic = true,
          },
          buffer_selected = {
            bold = true,
          },
        },
        options = {
          themable = true, -- whether or not bufferline highlights can be overridden externally
          -- style_preset = preset,
          get_element_icon = nil,
          show_duplicate_prefix = true,
          duplicates_across_groups = true,
          auto_toggle_bufferline = true,
          move_wraps_at_ends = false,
          groups = { items = {}, options = { toggle_hidden_on_enter = true } },
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
          close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
          middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
          indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "icon", -- can also be 'underline'|'none',
          },
          buffer_close_icon = "󰅖",
          modified_icon = "",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          --- name_formatter can be used to change the buffer's label in the bufferline.
          --- Please note some names can/will break the
          --- bufferline so use this at your discretion knowing that it has
          --- some limitations that will *NOT* be fixed.
          name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match "%.md" then
              return vim.fn.fnamemodify(buf.name, ":t:r")
            end
          end,
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          truncate_names = true, -- whether or not tab names should be truncated
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = diagnostics_indicator,
          -- NOTE: this will be called a lot so don't do any heavy processing here
          custom_filter = custom_filter,
          offsets = {
            {
              filetype = "undotree",
              text = "Undotree",
              highlight = "PanelHeading",
              padding = 1,
            },
            {
              filetype = "NvimTree",
              text = "Explorer",
              highlight = "PanelHeading",
              padding = 1,
            },
            {
              filetype = "DiffviewFiles",
              text = "Diff View",
              highlight = "PanelHeading",
              padding = 1,
            },
            {
              filetype = "flutterToolsOutline",
              text = "Flutter Outline",
              highlight = "PanelHeading",
            },
            {
              filetype = "lazy",
              text = "Lazy",
              highlight = "PanelHeading",
              padding = 1,
            },
          },
          color_icons = true, -- whether or not to add the filetype icon highlights
          show_buffer_icons = true, -- disable filetype icons for buffers
          show_buffer_close_icons = true,
          show_close_icon = false,
          show_tab_indicators = false,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = false, -- requires nvim 0.8+
            delay = 200,
            reveal = { "close" },
          },
          sort_by = "id",
          debug = { logging = false },
        },
      }
      if bufferline.on_config_done then
        bufferline.on_config_done()
      end
      local ok_tabline, tabline = pcall(require, "tabline")
      if ok_tabline then
        tabline.on_session_load_post()
        vim.o.tabline = "%!v:lua.nvim_bufferline() .. v:lua.require'tabline'.tabline_tabs()"
      else
        vim.o.tabline = "%!v:lua.nvim_bufferline()"
      end
    end,
  },
  {
    "lfv89/vim-interestingwords",
    event = "VeryLazy",
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
    "ESSO0428/bioSyntax-vim",
    ft = {
      "fasta",
      "fastq",
      "sam",
      "bam",
      "vcf",
      "bed",
      "gtf",
      "pdb",
      "nexus",
      "clustal",
      "cwl",
      "pml",
      "flagstat",
      "faidx",
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufWinEnter", -- 比 VeryLazy 再精準一點
    config = function()
      require("scrollbar").setup {
        show = true,
        handle = {
          text = " ",
          color = "#928374",
          hide_if_all_visible = true,
        },
        marks = {
          Search = { color = "yellow" },
          Misc = { color = "purple" },
        },
      }
    end,
  },
  {
    "kevinhwang91/promise-async",
    lazy = true,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    deprecated = { "kevinhwang91/promise-async" },
    config = function()
      require("user.config.plugins.fold").setup()
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = function()
      local builtin = require "statuscol.builtin"
      return {
        setopt = true,
        -- override the default list of segments with:
        -- number-less fold indicator, then signs, then line number & separator
        segments = {
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
        },
      }
    end,
  },
  {
    "jghauser/fold-cycle.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("fold-cycle").setup()
      vim.keymap.set("n", "[f", function()
        return require("fold-cycle").close()
      end, { silent = true, desc = "Fold-cycle: close folds" })
      vim.keymap.set("n", "]f", function()
        return require("fold-cycle").open()
      end, { silent = true, desc = "Fold-cycle: open folds" })
      vim.keymap.set("n", "[g", function()
        return require("fold-cycle").close_all()
      end, { remap = true, silent = true, desc = "Fold-cycle: close all folds" })
      vim.keymap.set("n", "]g", function()
        return require("fold-cycle").open_all()
      end, { remap = true, silent = true, desc = "Fold-cycle: Open all folds" })
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
  { "dhruvasagar/vim-table-mode" },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
  { "ESSO0428/vim-fugitive" },
  { "rbong/vim-flog" },
  { "sindrets/diffview.nvim" },
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy", -- 只有你真的用 hydra 的時候才會拖一點
    config = function()
      require("user.keymappings.hydra").setup()
    end,
  },
}, {
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
})
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
set_if_command_exists("GuiWindowOpacity", "0.9")

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
