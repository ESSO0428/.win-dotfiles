return {
  { -- Autocompletion
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      -- Snippet Engine used by blink.cmp
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

      {
        "saghen/blink.compat",
        version = "2.*",
        lazy = true,
        opts = {},
      },
      "hrsh7th/cmp-path",
    },
    config = function()
      local blink = require "blink.cmp"
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

      local source_labels = {
        buffer = "(Buffer)",
        lazydev = "(lazydev)",
        lsp = "(LSP)",
        path = "(Path)",
        snippets = "(L-Snippet)",
      }
      local icons = require "user.config.icons"
      local termcodes = vim.api.nvim_replace_termcodes

      local function get_source_label(ctx)
        return source_labels[ctx.source_id] or ("(" .. ctx.source_name .. ")")
      end

      local function get_kind_icon(ctx)
        return icons.kind[ctx.kind] or ctx.kind_icon
      end

      local function get_kind_highlight(ctx)
        return ctx.kind_hl
      end

      local function get_bufnrs()
        local max_size = 100000
        local bufs = {}

        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.api.nvim_get_option_value("filetype", { buf = buf }) ~= "neo-tree" then
            local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
            if size > 0 and size < max_size then
              bufs[buf] = true
            end
          end
        end

        return vim.tbl_keys(bufs)
      end

      blink.setup {
        appearance = {
          nerd_font_variant = "mono",
        },
        snippets = {
          preset = "luasnip",
        },
        keymap = {
          preset = "none",
          ["<M-i>"] = { "select_prev", "show" },
          ["<M-k>"] = { "select_next", "show" },
          ["<M-j>"] = {
            function(cmp)
              if cmp.is_menu_visible() then
                return cmp.cancel()
              end
              return termcodes("<Esc>", true, false, true)
            end,
          },
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<C-u>"] = { "scroll_documentation_up", "fallback" },
          ["<C-o>"] = { "scroll_documentation_down", "fallback" },
          ["<M-l>"] = { "accept", "fallback" },
          ["<M-d>"] = { "select_next", "snippet_forward", "fallback" },
          ["<M-a>"] = { "select_prev", "snippet_backward", "fallback" },
          ["<CR>"] = {
            function(cmp)
              if cmp.is_menu_visible() then
                return cmp.accept()
              end
            end,
            "fallback",
          },
        },
        completion = {
          keyword = {
            range = "prefix",
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          ghost_text = {
            enabled = true,
          },
          menu = {
            border = "rounded",
            winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
            draw = {
              columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_label" } },
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    return get_kind_icon(ctx) .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    return get_kind_highlight(ctx)
                  end,
                },
                label = {
                  width = { fill = true, max = 60 },
                },
                label_description = {
                  width = { max = 30 },
                },
                source_label = {
                  width = { max = 24 },
                  text = function(ctx)
                    return get_source_label(ctx)
                  end,
                  highlight = "BlinkCmpSource",
                },
              },
            },
          },
          documentation = {
            auto_show = false,
            window = {
              border = "rounded",
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
          },
        },
        cmdline = {
          enabled = true,
          keymap = {
            preset = "cmdline",
            ["<M-i>"] = { "select_prev", "show" },
            ["<M-k>"] = { "select_next", "show" },
            ["<M-j>"] = { "cancel", "fallback" },
            ["<Right>"] = false,
            ["<Left>"] = false,
            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<M-l>"] = { "accept", "fallback" },
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
          completion = {
            menu = {
              auto_show = true,
            },
            list = { selection = { preselect = false } },
            ghost_text = { enabled = true },
          },
        },
        sources = {
          min_keyword_length = 1,
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            lsp = {
              name = "LSP",
              fallbacks = {},
            },
            path = {
              name = "Path",
              module = "blink.compat.source",
              score_offset = 3,
              opts = {
                cmp_name = "path",
                get_cwd = function(context)
                  local bufnr = context.bufnr
                  if bufnr == nil and context.context ~= nil then
                    bufnr = context.context.bufnr
                  end
                  bufnr = bufnr or vim.api.nvim_get_current_buf()
                  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h")
                end,
              },
            },
            snippets = {
              name = "LuaSnip",
              score_offset = -1,
            },
            buffer = {
              name = "Buffer",
              score_offset = -3,
              opts = {
                get_bufnrs = get_bufnrs,
              },
            },
            cmdline = {
              name = "Cmdline",
            },
          },
        },
        fuzzy = {
          implementation = "lua",
        },
      }
    end,
  },
}
