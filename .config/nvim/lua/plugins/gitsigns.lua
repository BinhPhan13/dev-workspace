local function on_attach(bufnr)
  local gs = require('gitsigns')
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']h', function() gs.nav_hunk('next') end)
  map('n', '[h', function() gs.nav_hunk('prev') end)

  -- Actions
  map('n', '<leader>hs', gs.stage_hunk)
  map('n', '<leader>hr', gs.reset_hunk)
  map('v', '<leader>hs', function()
    gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
  map('v', '<leader>hr', function()
    gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

  map('n', '<leader>hS', gs.stage_buffer)
  map('n', '<leader>hR', gs.reset_buffer)
  map('n', '<leader>hu', gs.undo_stage_hunk)

  map('n', '<leader>hb', gs.blame_line)
  map('n', '<leader>hB', gs.toggle_current_line_blame)

  map('n', '<leader>hv', gs.preview_hunk_inline)
  map('n', '<leader>hV', gs.toggle_deleted)

  map('n', '<leader>hd', gs.diffthis)
  map('n', '<leader>hD', function() gs.diffthis('~') end)
end

local function config()
  require('gitsigns').setup({
    on_attach = on_attach,
    auto_attach = true,
    attach_to_untracked = true,

    signs = {
      add          = { text = '║' },
      change       = { text = '║' },
      delete       = { text = '║' },
      topdelete    = { text = '━' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signcolumn = true,

    current_line_blame = false,
    current_line_blame_formatter = '<author>, <author_time:%x %H:%M> - <summary>',

    sign_priority = 3,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 30000,
  })
end

return {
  'lewis6991/gitsigns.nvim', tag = 'v0.9.0',
  config = config
}

