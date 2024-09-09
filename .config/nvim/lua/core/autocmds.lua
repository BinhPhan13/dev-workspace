local yank_grp = vim.api.nvim_create_augroup('YANK', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = yank_grp,
  callback = function()
    vim.highlight.on_yank({ on_visual = false })
  end,
})

