return {
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
}
