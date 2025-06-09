local function mini_icons()
  require("mini.icons").setup({ style = 'glyph' })
  MiniIcons.mock_nvim_web_devicons()
  MiniIcons.tweak_lsp_kind()
end

local function mini_files()
  -- toggle explorer
  vim.keymap.set('n', '<leader>e', function()
    if not MiniFiles.close() then MiniFiles.open() end
  end)
  -- customize bookmark
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      MiniFiles.set_bookmark('c', vim.fn.stdpath('config'))
      MiniFiles.set_bookmark('w', vim.fn.getcwd)
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
    if path ~= nil then vim.fn.chdir(vim.fs.dirname(path)) end
  end
  -- yank in register full path of entry under cursor
  local yank_path = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path ~= nil then vim.fn.setreg(vim.v.register, path) end
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local b = args.data.buf_id
      vim.keymap.set('n', 'g.', toggle_dot, { buffer = b })
      vim.keymap.set('n', 'gw', set_cwd,    { buffer = b })
      vim.keymap.set('n', 'gy', yank_path,  { buffer = b })
    end,
  })

  require("mini.files").setup({
    mappings = {
      go_in = '',
      go_out = '',
    },
    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
    },
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 25,
      width_nofocus = 25,
      width_preview = 50,
    },
  })
end

local function mini_tabline()
  require("mini.tabline").setup({
    -- format = function(buf_id, label)
    --   local suffix = vim.bo[buf_id].modified and '+' or ''
    --   return MiniTabline.default_format(buf_id, label) .. suffix
    -- end,
    tabpage_section = 'right',
  })
end

local function mini_statusline()
  vim.opt.showmode = false
  local mini = require("mini.statusline")
  local function active()
    local mode, mode_hl = mini.section_mode({ trunc_width = 75 })
    local filename = "%{fnamemodify(expand('%'), ':~:.')} %m%r"

    local filetype = "%{&filetype}"
    local percent = "%2p%%"
    local location = "%3l:%-2c"

    return mini.combine_groups({
      { hl = mode_hl, strings = { mode } },
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

local function mini_pick()
  local win_config = function()
    local height = math.floor(0.75 * vim.o.lines)
    local width = math.floor(0.5 * vim.o.columns)
    return {
      anchor = 'NW', height = height, width = width,
      row = math.floor(0.3 * (vim.o.lines - height)),
      col = math.floor(0.5 * (vim.o.columns - width)),
    }
  end
  require("mini.pick").setup({
    window = { config = win_config },
    mappings = {
      move_down  = '<C-j>',
      move_up    = '<C-k>',
      move_start = '<C-g>',

      toggle_info    = '<C-i>',
      toggle_preview = '<C-p>',
      stop = '<Esc>',

      choose            = '<CR>',
      choose_in_split   = '<C-s>',
      choose_in_vsplit  = '<C-v>',
      choose_in_tabpage = '<C-t>',
      choose_marked     = '',

      scroll_up    = '<C-u>',
      scroll_down  = '<C-d>',
      scroll_left  = '<C-h>',
      scroll_right = '<C-l>',

      refine        = '<C-n>',
      refine_marked = '<M-n>',

      delete_char       = '<BS>',
      delete_char_right = '<Del>',
      delete_word       = '<C-w>',
      delete_left       = '<C-0>',

      paste    = '<C-r>',
      mark     = '<C-v>',
      mark_all = '<C-a>',
    },
  })
  vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files)
  vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers)
  vim.keymap.set("n", "<leader>fgp", MiniPick.builtin.grep)
  vim.keymap.set("n", "<leader>fgl", MiniPick.builtin.grep_live)
  vim.keymap.set("n", "<leader>fh", function()
    MiniPick.builtin.help({default_split = 'vertical'})
  end)
  vim.keymap.set("n", "<leader>fc", function()
    local cmd_str = vim.fn.input("Command: ")
    local cmd = {}
    for part in string.gmatch(cmd_str, '%S+') do table.insert(cmd, part) end
    if next(cmd) then MiniPick.builtin.cli({ command = cmd }) end
  end)
end

local function mini_ai()
  local custom_textobjects = {
    -- brackets
    r = {{'%b()', '%b{}', '%b[]', '%b<>'}, '^.().*().$'},
    R = {{'%b()', '%b{}', '%b[]', '%b<>'}, '^.%s*().-()%s*.$'},
    b = { '%b()', '^.().*().$' },
    B = { '%b()', '^.%s*().-()%s*.$'},
    c = { '%b{}', '^.().*().$' },
    C = { '%b{}', '^.%s*().-()%s*.$'},
    u = { '%b[]', '^.().*().$' },
    U = { '%b[]', '^.%s*().-()%s*.$'},
    y = { '%b<>', '^.().*().$' },
    Y = { '%b<>', '^.%s*().-()%s*.$'},
    -- quotes
    q = {{"'.-'", '".-"', '`.-`'}, '^.().*().$'},
    k = { "'.-'", '^.().*().$' },
    j = { '".-"', '^.().*().$' },
    z = { '`.-`', '^.().*().$' },
  }
  require("mini.ai").setup({
    custom_textobjects = custom_textobjects,
    search_method = 'cover',
    n_lines = 50,
    silent = false,
  })
end

local function mini_surround()
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
      input = { '%b()', '^.%s*().-()%s*.$'},
      output = { left = '(', right = ')' }
    },
    c = {
      input = { '%b{}', '^.().*().$' },
      output = { left = '{', right = '}' }
    },
    C = {
      input = { '%b{}', '^.%s*().-()%s*.$'},
      output = { left = '{', right = '}' }
    },
    u = {
      input = { '%b[]', '^.().*().$' },
      output = { left = '[', right = ']' }
    },
    U = {
      input = { '%b[]', '^.%s*().-()%s*.$'},
      output = { left = '[', right = ']' }
    },
    y = {
      input = { '%b<>', '^.().*().$' },
      output = { left = '<', right = '>' }
    },
    Y = {
      input = { '%b<>', '^.%s*().-()%s*.$'},
      output = { left = '<', right = '>' }
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
    z = {
      input = { '`.-`', '^.().*().$' },
      output = { left = '`', right = '`' }
    },
  }
  require("mini.surround").setup({
    custom_surroundings = custom_surroundings,
    search_method = 'cover',
    n_lines = 50,
    silent = true,
    highlight_duration = 1000,
    respect_selection_type = true,
    mappings = { add = 'sj' },
  })
end

local function mini_extra()
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
  vim.keymap.set("n", "<leader>fm", MiniExtra.pickers.marks)
  vim.keymap.set("n", "<leader>fe", MiniExtra.pickers.explorer)
  vim.keymap.set("n", "<leader>fgh", MiniExtra.pickers.git_hunks)
  vim.keymap.set("n", "<leader>fo", MiniExtra.pickers.oldfiles)
  vim.keymap.set("n", "<leader>fr", function()
    MiniExtra.pickers.lsp({ scope = "references" })
  end)
  vim.keymap.set("n", "<leader>fk", MiniExtra.pickers.keymaps)
end

local function mini_completion()
  require("mini.completion").setup({
    lsp_completion = { source_func = 'omnifunc' },
    window = {
      info = { height = 30, width = 70 },
      signature = { height = 30, width = 70 },
    },
    fallback_action = '<C-n>',
    mappings = {
      force_twostep = '<M-n>',
      force_fallback = '<M-S-n>',
      scroll_up = '<M-u>',
      scroll_down = '<M-d>',
    }
  })
  vim.opt.completeopt:append('fuzzy')
  vim.lsp.config('*', {capabilities = MiniCompletion.get_lsp_capabilities()})
end

local function mini_diff()
  require('mini.diff').setup({
    mappings = { apply = '', reset = 'gh' },
    view = {
      style = 'sign',
      signs = {
        add    = "║",
        change = "║",
        delete = "║",
      }
    },
  })
  vim.keymap.set('n', '<leader>hv', MiniDiff.toggle_overlay)
  vim.keymap.set('n', '<leader>hV', MiniDiff.toggle)
end

local function mini_pairs()
  local mappings = {
      ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
      ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
      ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
      ['<'] = { action = 'open', pair = '<>', neigh_pattern = '\r.' },

      [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
      [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
      ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
      ['>'] = { action = 'close', pair = '<>', neigh_pattern = '\r.' },

      ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = true } },
      ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^\\].', register = { cr = true } },
      ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = true } },

  }
  require("mini.pairs").setup({ mappings = mappings })

  local map_bs = function(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { expr = true, replace_keycodes = false })
  end
  map_bs('<C-h>', 'v:lua.MiniPairs.bs()')
  map_bs('<C-w>', 'v:lua.MiniPairs.bs("\23")')
  map_bs('<C-u>', 'v:lua.MiniPairs.bs("\21")')
end

local function mini_bufremove()
  require("mini.bufremove").setup({})
  vim.keymap.set("n", "<leader>bd", MiniBufremove.wipeout)
  vim.keymap.set("n", "<leader>bD", vim.cmd.bd)
end

return {
  "echasnovski/mini.nvim",
  config = function()
    mini_icons()
    mini_files()
    mini_tabline()
    mini_statusline()

    mini_pick()
    mini_ai()
    mini_surround()
    mini_extra()

    mini_diff()
    mini_completion()
    mini_pairs()

    mini_bufremove()
  end,
}

