local _load_ui    = "LazyGroup" .. "UI"
local _load_extra = "LazyGroup" .. "Extra"

return {
  {
    'nvim-mini/mini.notify',
    lazy = false,
    config = function()

      require('mini.notify').setup({
        content = {
          format = function(notif)
            if notif.data.source == 'lsp_progress' then return notif.msg end
            return MiniNotify.default_format(notif)
          end,
          sort = function(notif_arr)
            table.sort(
              notif_arr,
              function(a, b) return a.ts_update > b.ts_update end
            )
            return notif_arr
          end,
        },
        window = { winblend = 0 }
      })
      vim.notify = MiniNotify.make_notify({
        ERROR = { duration = 4000,  hl_group = 'DiagnosticError'  },
        WARN  = { duration = 3000,  hl_group = 'DiagnosticWarn'   },
        INFO  = { duration = 2000,  hl_group = 'DiagnosticInfo'   },
        DEBUG = { duration = 1000,  hl_group = 'DiagnosticHint'   },
        TRACE = { duration = 1000,  hl_group = 'DiagnosticOk'     },
        OFF   = { duration = 1000,  hl_group = 'MiniNotifyNormal' },
      })
    end
  },
  {
    'nvim-mini/mini.files',
    keys = {
      "<leader>e",
      "<leader>E",
    },
    config = function()
      require("mini.files").setup({
        mappings = {
          go_in = 'l',
          go_out = 'h',
          go_in_plus = '',
          go_out_plus = '',
        },
        options = {
          permanent_delete = true,
          use_as_default_explorer = true,
        },
        windows = {
          max_number = math.huge,
          preview = false,
          width_nofocus = 30,
          width_focus = 30,
          width_preview = 30,
        },
      })
      -- open explorer
      local _is_active = function() return MiniFiles.get_explorer_state() end
      vim.keymap.set('n', '<leader>e', function()
        if _is_active() then return end
        MiniFiles.open()
      end)
      vim.keymap.set('n', '<leader>E', function()
        if _is_active() then return end
        if not vim.bo.buflisted then return end
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      end)
      -- customized bookmarks
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesExplorerOpen',
        callback = function()
          MiniFiles.set_bookmark('c', vim.fn.stdpath('config'))
          MiniFiles.set_bookmark('w', vim.fn.getcwd())
          MiniFiles.set_bookmark('h', '~')
        end,
      })
      -- toggle dot files
      local showdot = true
      local _fshow = function(fs_entry) return true end
      local _fhide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end
      local toggle_dot = function()
        showdot = not showdot
        local filter = showdot and _fshow or _fhide
        MiniFiles.refresh({ content = { filter = filter } })
      end
      -- set focused directory as cwd
      local set_cwd = function()
        local path = (MiniFiles.get_fs_entry() or {}).path
        if path == nil then return end
        vim.fn.chdir(vim.fs.dirname(path))
        MiniFiles.close()
      end
      -- yank in register full path of entry under cursor
      local yank_path = function()
        local path = (MiniFiles.get_fs_entry() or {}).path
        if path ~= nil then vim.fn.setreg("+", path) end
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local map = function (mod, lhs, rhs)
            vim.keymap.set(mod, lhs, rhs, { buffer = args.data.buf_id })
          end
          map('n', '<C-h>', toggle_dot)
          map('n', '<CR>', set_cwd)
          map('n', '<C-c>', yank_path)
        end,
      })
    end
  },
  {
    "catppuccin/nvim", name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        dim_inactive = { enable = false },
        -- no_bold = true,
        no_italic = true,
        no_underline = true,
        default_integrations = true,
        integrations = {
          leap = true
        },
      })
      vim.cmd.colorscheme "catppuccin-nvim"
    end,
  },
  {
    'nvim-mini/mini.icons',
    config = function()
      require("mini.icons").setup({ style = 'glyph' })
      MiniIcons.mock_nvim_web_devicons()
      MiniIcons.tweak_lsp_kind()
    end
  },
  {
    'romgrk/barbar.nvim',
    cmd = _load_ui,
    dependencies = { "catppuccin", 'nvim-mini/mini.icons' },
    commit = "539d73def39c9172b4d4d769f14090e08f37b29d",
    config = function()
      vim.g.barbar_auto_setup = false
      require('barbar').setup({
        animation = false,
        no_name_title = '<none>',
        semantic_letters = false,
        focus_on_close = 'previous',
        highlight_alternate = true,
        highlight_visible = false,
        exclude_ft = {},
        exclude_name = {},
        icons = {
        }
      })

      vim.keymap.set('n', '<M-h>', function() vim.cmd('BufferPrevious') end)
      vim.keymap.set('n', '<M-l>', function() vim.cmd('BufferNext') end)
      vim.keymap.set('n', '<M-H>', function() vim.cmd('BufferMovePrevious') end)
      vim.keymap.set('n', '<M-L>', function() vim.cmd('BufferMoveNext') end)

      vim.keymap.set('n', '<M-d>', vim.cmd.BufferDelete)
      vim.keymap.set('n', '<M-D>', vim.cmd.bdelete)
      vim.keymap.set('n', '<leader>br', vim.cmd.BufferRestore)

      vim.keymap.set('n', '<M-s>', vim.cmd.BufferPick)
      vim.keymap.set('n', '<leader>bd', vim.cmd.BufferPickDelete)
    end
  },
  {
    'nvim-mini/mini.statusline',
    cmd = _load_ui,
    config = function()
      vim.opt.showmode = false
      local mini = require("mini.statusline")
      local active = function()
        local mode, mode_hl = mini.section_mode({ trunc_width = 75 })
        local diagnostics   = MiniStatusline.section_diagnostics({
          signs = { ERROR = '!', WARN = '?', INFO = '@', HINT = '*' },
          trunc_width = 75,
        })
        local filename = not vim.bo.buflisted and '' or
        "%{fnamemodify(expand('%'), ':~:.')} %m%r"

        local filetype = "%{&filetype}"
        local percent = "%2p%%"
        local location = "%3l:%-2c"
        local undofile = vim.bo.undofile and 'undofile' or ''

        return mini.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics, undofile } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFilename", strings = { filetype } },
          { hl = "MiniStatuslineFileinfo", strings = { percent } },
          { hl = mode_hl, strings = { location } },
        })
      end
      mini.setup({ content = { active = active } })
    end
  },
  {
    'stevearc/resession.nvim',
    keys = {
      "<leader>sl",
      "<leader>ss",
    },
    config = function()
      local rs = require("resession")

      local extensions = {}
      if package.loaded["barbar"] then extensions.barbar = {} end

      rs.setup({
        dir = 'session', -- vim.fn.stdpath('data') .. dir
        load_detail = false,
        extensions = extensions,
      })

      vim.keymap.set("n", "<leader>ss", function()
        vim.ui.input({ prompt = 'Session name: ', default = rs.get_current() },
        function(input)
          input = (input or ''):match('^%s*(.-)%s*$')
          if input ~= '' then rs.save(input) end
          vim.cmd.normal(':')
        end)
      end)

      local function save_current()
        if not rs.get_current() then return end
        rs.save(nil, { notify = false })
      end
      rs.add_hook('pre_load', save_current)
      vim.keymap.set("n", "<leader>sl", rs.load)

      vim.keymap.set("n", "<leader>sd", rs.delete)

      vim.api.nvim_create_autocmd("VimLeavePre", { callback = save_current })
    end
  },
  {
    'nvim-mini/mini.move',
    keys = {
      '<M-J>',
      '<M-K>',
      {'J', mode = 'v'},
      {'K', mode = 'v'},
    },
    config = function()
      require('mini.move').setup({
        mappings = {
          left  = '',
          right = '',
          down  = 'J',
          up    = 'K',

          line_left = '',
          line_right = '',
          line_down = '<M-J>',
          line_up = '<M-K>',
        },
        options = {
          reindent_linewise = false,
        },
      })
    end
  },
  {
    'nvim-mini/mini.splitjoin',
    keys = { { 'gs', mode = {'n', 'x'} } },
    config = function()
      require('mini.splitjoin').setup({
        mappings = { toggle = 'gs' },
        detect = {
          brackets = { '%b()', '%b[]', '%b{}', '%b<>' },
          separator = ',',
          exclude_regions = {
            '%b()', '%b[]', '%b{}', '%b<>',
            '%b""', "%b''", '%b``',
          },
        }
      })

      local gen_hook = MiniSplitjoin.gen_hook
      MiniSplitjoin.config.split.hooks_post = { gen_hook.add_trailing_separator() }
      MiniSplitjoin.config.join.hooks_post = { gen_hook.del_trailing_separator() }
    end
  },
  {
    'nvim-mini/mini.pick',
    keys = "<leader>f;",
    config = function()
      local win_config = function()
        local height = math.floor(0.85 * vim.o.lines)
        local width = math.floor(0.75 * vim.o.columns)
        return {
          anchor = 'NW', height = height, width = width,
          row = math.floor(0.25 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end
      require("mini.pick").setup({
        window = { config = win_config },
        source = {
          choose_marked = function(items)
            for _,  item in ipairs(items) do MiniPick.default_choose(item) end
          end
        },
        mappings = {
          choose            = '<CR>',
          choose_in_split   = '<C-s>',
          choose_in_vsplit  = '<C-v>',
          choose_in_tabpage = '<C-t>',
          choose_marked     = '<C-CR>',

          move_down  = '<C-j>',
          move_up    = '<C-k>',
          move_start = '<C-g>',

          toggle_info    = '<C-i>',
          toggle_preview = '<C-p>',
          stop = '<Esc>',

          scroll_up    = '<C-u>',
          scroll_down  = '<C-d>',
          scroll_left  = '<C-h>',
          scroll_right = '<C-l>',

          refine        = '<M-n>',
          refine_marked = '<C-n>',

          delete_char       = '<BS>',
          delete_char_right = '<Del>',
          delete_word       = '<C-w>',
          delete_left       = '<C-0>',

          paste    = '<C-r>',
          mark     = '<C-x>',
          mark_all = '<C-a>',
        },
      })
      vim.ui.select = MiniPick.ui_select

      vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files)
      vim.keymap.set('n', '<leader>fp', MiniPick.builtin.grep)
      vim.keymap.set('n', '<leader>fl', MiniPick.builtin.grep_live)
      vim.keymap.set('n', '<leader>fh', function()
        MiniPick.builtin.help({default_split = 'vertical'})
      end)
      vim.keymap.set('n', '<leader>fb', function()
        MiniPick.builtin.buffers({ include_unlisted = true })
      end)
      vim.keymap.set('n', '<leader>fc', MiniPick.builtin.resume)
    end
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim", name = "leap.nvim",
    keys = {
      { "r", mode = {"n", "x"} },
      { "R", mode = {"n", "x"} },
    },
    config = function()
      local leap = require("leap")
      leap.opts.case_sensitive = false
      leap.opts.equivalence_classes = { " \t\r\n", "([{<>}])", "'\"`" }
      leap.opts.max_highlighted_traversal_targets = 0
      leap.opts.safe_labels =
      "fdsajkl;ghtrewquiopvcxznm,./" ..
      "FDSAJKL:GHTREWQUIOPVCXZNM<>?"
      leap.opts.labels = ""
      vim.keymap.set({"n", "x"}, "r", "<Plug>(leap-anywhere)")
      vim.keymap.set({"n", "x"}, "R", "<Plug>(leap)")
    end
  },
  {
    'mbbill/undotree',
    keys = "<M-u>",
    config = function()
      vim.keymap.set('n', '<M-u>', vim.cmd.UndotreeShow)

      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_DiffpanelHeight = 30
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_DisabledBuftypes = {
        'terminal', 'prompt', 'quickfix',
        'nofile', 'help',
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    keys = { "<leader>h;" },
    config = function()
      local gs = require('gitsigns')
      gs.setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,

        -- Keymaps
        on_attach = function(bufnr)
          local map = function(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then vim.cmd.normal({']c', bang = true})
            else gs.nav_hunk('next') end
          end)
          map('n', '[c', function()
            if vim.wo.diff then vim.cmd.normal({'[c', bang = true})
            else gs.nav_hunk('prev') end
          end)
          -- Actions
          map('n', '<leader>ha', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('x', '<leader>ha', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)
          map('x', '<leader>hr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)
          map('n', '<leader>hA', gs.stage_buffer)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hs', gs.preview_hunk)
          map('n', '<leader>hS', gs.preview_hunk_inline)
          map('n', '<leader>hb', function()
            gs.blame_line({ full = true })
          end)
          map('n', '<leader>hq', gs.setqflist)
          map('n', '<leader>hQ', function() gs.setqflist('all') end)
          -- Toggles
          map('n', '<leader>hw', gs.toggle_word_diff)
          -- Text object
          map({'o', 'x'}, 'ih', gs.select_hunk)
        end
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter", name = "treesitter",
    branch = "master", version = false,
    enabled = function()
      return vim.fn.executable("gcc") == 1
      or vim.fn.executable("clang") == 1
      or vim.fn.executable("zig") == 1
    end,
    cmd = _load_ui,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- MUST installed
          "markdown_inline",
          "markdown",
          "query",
          "vimdoc",
          "vim",
          "lua",
          "c",
        },
        sync_install = false,
        auto_install = false,

        -- HIGHLIGHT config
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,

          -- disable for large files
          disable = function(lang, buf)
            local maxsize = 300 * 1024 -- 300 KB
            local ok, stats = pcall(
              (vim.uv or vim.loop).fs_stat,
              vim.api.nvim_buf_get_name(buf)
            )
            return ok and stats and stats.size > maxsize
          end
        },
        incremental_selection = {
          enable = false,
        },
      })
    end,
  },
  {
    'nvim-mini/mini.surround',
    keys = { { 's', mode = {'n', 'x'} } },
    config = function()
      vim.keymap.set({"n", "x"}, "s", "<nop>")
      require("mini.surround").setup({
        search_method = 'cover_or_next',
        n_lines = 100,
        silent = false,
        highlight_duration = 500,
        respect_selection_type = true,
        mappings = { add = 's' },
      })
    end
  },
  {
    'nvim-mini/mini.ai',
    cmd = _load_extra,
    config = function()
      require("mini.ai").setup({
        search_method = 'cover_or_next',
        n_lines = 100,
        silent = false,
      })
    end
  },
  {
    'nvim-mini/mini.extra',
    cmd = _load_extra,
    dependencies = {
      'nvim-mini/mini.ai',
      'nvim-mini/mini.pick',
    },
    config = function()
      require("mini.extra").setup()
      -- extra mini.ai
      local custom_textobjects = {
        G = MiniExtra.gen_ai_spec.buffer(),
        L = MiniExtra.gen_ai_spec.line(),
        N = MiniExtra.gen_ai_spec.number(),
        D = MiniExtra.gen_ai_spec.diagnostic(),
        i = MiniExtra.gen_ai_spec.indent(),
      }
      if package.loaded["mini.ai"] then
        MiniAi.setup({ custom_textobjects = custom_textobjects })
      end
      -- extra mini.pick
      if package.loaded["mini.pick"] then
        vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic)
        vim.keymap.set("n", "<leader>fjr", function()
          MiniExtra.pickers.lsp({ scope = "references" })
        end)
        vim.keymap.set("n", "<leader>fjd", function()
          MiniExtra.pickers.lsp({ scope = "definition" })
        end)

        vim.keymap.set("n", "<leader>fgh", MiniExtra.pickers.git_hunks)
        vim.keymap.set("n", "<leader>fgc", MiniExtra.pickers.git_commits)
        vim.keymap.set("n", "<leader>fgb", MiniExtra.pickers.git_branches)
        vim.keymap.set("n", "<leader>fgg", MiniExtra.pickers.git_files)

        vim.keymap.set("n", "<leader>fm", MiniExtra.pickers.marks)
        vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps)
        vim.keymap.set("n", "<leader>fr", MiniExtra.pickers.registers)
        vim.keymap.set("n", "<leader>fo", MiniExtra.pickers.oldfiles)
      end
    end
  },
  {
    'neovim/nvim-lspconfig', name = "lsp",
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        signs = false,
      })
      vim.keymap.set("n", "grd", vim.lsp.buf.definition)

      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ float = false }) end)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ float = false }) end)
      vim.keymap.set("n", "g/", vim.diagnostic.open_float)

      vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo)
      vim.keymap.set("n", "<leader>lr", ":LspRestart ")
      vim.keymap.set("n", "<leader>ld", ":LspStop ")
      vim.keymap.set("n", "<leader>ls", ":LspStart ")

      vim.lsp.enable({
        "pyrefly",
      })
      -- CONFIGs
    end
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'nvim-mini/mini.snippets' },
    version = '1.*',
    opts = {
      fuzzy = {
        implementation = "prefer_rust",
        sorts = { 'score', 'sort_text', 'kind' }
      },
      sources = {
        default = { 'snippets', 'lsp', 'buffer', 'path' },
        providers = {
          lsp = { fallbacks = {} },
          path = { opts = {
            get_cwd = function(ctx) return vim.fn.getcwd() end,
            show_hidden_files_by_default = true,
          }},
          buffer = { opts = {
            get_bufnrs = function()
              return vim
              .iter(vim.api.nvim_list_bufs())
              :filter(function(buf) return vim.bo[buf].buflisted end)
              :totable()
            end,
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
          menu = { auto_show = false },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}

