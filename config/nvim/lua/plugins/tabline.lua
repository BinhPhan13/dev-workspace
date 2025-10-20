return {
  'romgrk/barbar.nvim',
  config = function()
    vim.g.barbar_auto_setup = false
    require('barbar').setup({
      animation = false,
      no_name_title = '<none>',
      semantic_letters = false,
      exclude_ft = {},
      exclude_name = {},
    })

    vim.keymap.set('n', '<M-h>', function() vim.cmd('BufferPrevious') end)
    vim.keymap.set('n', '<M-l>', function() vim.cmd('BufferNext') end)
    vim.keymap.set('n', '<M-H>', function() vim.cmd('BufferMovePrevious') end)
    vim.keymap.set('n', '<M-L>', function() vim.cmd('BufferMoveNext') end)

    vim.keymap.set('n', '<M-b>', function() vim.cmd('BufferClose') end)
    vim.keymap.set('n', '<M-B>', function() vim.cmd('BufferRestore') end)

    vim.keymap.set('n', '<leader>bp', function() vim.cmd('BufferPick') end)
    vim.keymap.set('n', '<leader>bd', function() vim.cmd('BufferPickDelete') end)
  end
}

