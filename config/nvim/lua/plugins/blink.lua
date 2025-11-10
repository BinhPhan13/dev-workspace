return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    fuzzy = {
      implementation = "prefer_rust",
      sorts = { 'exact', 'score', 'sort_text', 'kind' }
    },
    snippets = { preset = 'mini_snippets' },
    sources = {
      default = { 'snippets', 'lsp', 'buffer', 'path' },
      providers = {
        lsp = { fallbacks = {} },
        path = { opts = {
          get_cwd = function(ctx) return vim.fn.getcwd() end,
          show_hidden_files_by_default = true,
        }},
      }
    },

    keymap = {
      preset = 'none',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
      keyword = { range = 'prefix' },
      trigger = { prefetch_on_insert = false },
      list = { selection = {
        preselect = false,
        auto_insert = false,
      }},
      accept = {
        dot_repeat = true,
        create_undo_point = false,
        auto_brackets = { enabled = false },
      },

      documentation = { auto_show = false },
      menu = {
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                txt = MiniIcons.get("lsp", ctx.kind)
                return txt
              end,
              highlight = function(ctx)
                _, hl = MiniIcons.get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    appearance = { nerd_font_variant = 'mono' },

    cmdline = {
      keymap = {
        preset = 'none',
        ['<Tab>'] = { 'show', 'select_next' },
        ['<S-Tab>'] = { 'show', 'select_prev' },
      },
      sources = { 'cmdline', 'buffer' },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        menu = { auto_show = true },
      },
    },
  },
  opts_extend = { "sources.default" },
}

