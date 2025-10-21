return {
  'lewis6991/gitsigns.nvim',
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
}

