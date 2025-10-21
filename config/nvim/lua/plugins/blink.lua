return {
  'saghen/blink.cmp',
  opts = {
    fuzzy = { implementation = "prefer_rust" },
    sources = {
      default = { 'lsp', 'buffer', 'snippets', 'path' },
      providers = {
        lsp = { fallbacks = {} }
      }
    },

    keymap = {
      preset = 'none',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    completion = {
      keyword = { range = 'full' },
      trigger = { prefetch_on_insert = false },
      list = { selection = {
        preselect = false,
        auto_insert = false,
      }},

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
  },
  opts_extend = { "sources.default" },
  cmdline = { enabled = false },
}

