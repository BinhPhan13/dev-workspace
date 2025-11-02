local mini_icons = function()
  require("mini.icons").setup({ style = 'glyph' })
  MiniIcons.mock_nvim_web_devicons()
  MiniIcons.tweak_lsp_kind()
end

local mini_files = function()
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
      map('n', 'gy', yank_path)
    end,
  })
end

local mini_statusline = function()
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

    return mini.combine_groups({
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
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

local mini_pick = function()
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

local mini_ai = function()
  local custom_textobjects = {
    -- brackets
    r = {{'%b()', '%b{}', '%b[]', '%b<>'}, '^.().*().$'},
    R = {{'%b()', '%b{}', '%b[]', '%b<>'}, '^.%s*().-()%s*.$'},
    b = { '%b()', '^.().*().$' },
    B = { '%b()', '^.%s*().-()%s*.$' },
    c = { '%b{}', '^.().*().$' },
    C = { '%b{}', '^.%s*().-()%s*.$' },
    o = { '%b[]', '^.().*().$' },
    O = { '%b[]', '^.%s*().-()%s*.$' },
    s = { '%b<>', '^.().*().$' },
    S = { '%b<>', '^.%s*().-()%s*.$' },
    -- quotes
    q = {{"%b''", '%b""', '%b``'}, '^.().*().$'},
    k = { "%b''", '^.().*().$' },
    j = { '%b""', '^.().*().$' },
    a = { '%b``', '^.().*().$' },
  }
  require("mini.ai").setup({
    custom_textobjects = custom_textobjects,
    search_method = 'cover_or_next',
    n_lines = 70,
    silent = false,
  })
end

local mini_surround = function()
  vim.keymap.set({"n", "x"}, "s", "<nop>")
  local custom_surroundings = {
    -- brackets
    r = {
      input = { {'%b()', '%b{}', '%b[]', '%b<>'}, '^.().*().$' },
      output = { left = '(', right = ')' }
    },
    R = {
      input = { {'%b()', '%b{}', '%b[]', '%b<>'}, '^.%s*().-()%s*.$'},
      output = { left = '(', right = ')' }
    },
    b = {
      input = { '%b()', '^.().*().$' },
      output = { left = '(', right = ')' }
    },
    B = {
      input = { '%b()', '^.%s*().-()%s*.$' },
      output = { left = '( ', right = ' )' }
    },
    c = {
      input = { '%b{}', '^.().*().$' },
      output = { left = '{', right = '}' }
    },
    C = {
      input = { '%b{}', '^.%s*().-()%s*.$' },
      output = { left = '{ ', right = ' }' }
    },
    o = {
      input = { '%b[]', '^.().*().$' },
      output = { left = '[', right = ']' }
    },
    O = {
      input = { '%b[]', '^.%s*().-()%s*.$' },
      output = { left = '[ ', right = ' ]' }
    },
    s = {
      input = { '%b<>', '^.().*().$' },
      output = { left = '<', right = '>' }
    },
    S = {
      input = { '%b<>', '^.%s*().-()%s*.$' },
      output = { left = '< ', right = ' >' }
    },
    -- quotes
    q = {
      input = { {"'.-'", '".-"', '`.-`'}, '^.().*().$' },
      output = { left = '"', right = '"' }
    },
    k = {
      input = { "'.-'", '^.().*().$' },
      output = { left = "'", right = "'" }
    },
    j = {
      input = { '".-"', '^.().*().$' },
      output = { left = '"', right = '"' }
    },
    a = {
      input = { '`.-`', '^.().*().$' },
      output = { left = '`', right = '`' }
    },
  }
  require("mini.surround").setup({
    custom_surroundings = custom_surroundings,
    search_method = 'cover_or_next',
    n_lines = 70,
    silent = false,
    highlight_duration = 500,
    respect_selection_type = true,
    mappings = { add = 's' },
  })
end

local mini_extra = function()
  require("mini.extra").setup()

  -- extra mini.ai
  local custom_textobjects = {
    G = MiniExtra.gen_ai_spec.buffer(),
    L = MiniExtra.gen_ai_spec.line(),
    N = MiniExtra.gen_ai_spec.number(),
    D = MiniExtra.gen_ai_spec.diagnostic(),
    i = MiniExtra.gen_ai_spec.indent(),
  }
  for k, v in pairs(custom_textobjects) do
    MiniAi.config.custom_textobjects[k] = v
  end

  -- extra mini.pick
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

local mini_move = function()
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

local mini_splitjoin = function()
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

local mini_notify = function()
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
    ERROR = { duration = 5000,  hl_group = 'DiagnosticError'  },
    WARN  = { duration = 3000,  hl_group = 'DiagnosticWarn'   },
    INFO  = { duration = 3000,  hl_group = 'DiagnosticInfo'   },
    DEBUG = { duration = 1000,  hl_group = 'DiagnosticHint'   },
    TRACE = { duration = 1000,  hl_group = 'DiagnosticOk'     },
    OFF   = { duration = 1000,  hl_group = 'MiniNotifyNormal' },
  })
end

local mini_snippets = function()
  require('mini.snippets').setup({})
  MiniSnippets.config.mappings = {
      expand = '',
      jump_next = '<C-l>',
      jump_prev = '<C-h>',
      stop = '<esc>',
  }
  MiniSnippets.config.snippets = {
    MiniSnippets.gen_loader.from_lang()
  }
end

return {
  "echasnovski/mini.nvim",
  priority = 500,
  config = function()
    mini_icons()
    mini_notify()

    mini_files()
    mini_statusline()

    mini_pick()
    mini_ai()
    mini_surround()
    mini_extra()

    mini_snippets()
    mini_move()
    mini_splitjoin()
  end,
}

