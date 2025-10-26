return {
  'romgrk/barbar.nvim',
  branch = 'master',
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
}

